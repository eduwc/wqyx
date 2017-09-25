package base.net.websocket;

import base.thread.pool.ThreadPoolManager;
import game.net.datapackage.DataPackage;
import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;
import io.netty.channel.*;
import io.netty.handler.codec.http.DefaultFullHttpResponse;
import io.netty.handler.codec.http.FullHttpRequest;
import io.netty.handler.codec.http.HttpResponseStatus;
import io.netty.handler.codec.http.HttpVersion;
import io.netty.handler.codec.http.websocketx.*;
import io.netty.util.CharsetUtil;
import org.json.JSONObject;

import java.util.concurrent.ExecutorService;

/**
 * Created by Administrator on 2017/8/29 0029.
 * 处理字节流 分发到各个模块处理
 */
public class StreamHandle extends SimpleChannelInboundHandler<Object> {
    private WebSocketServerHandshaker handshaker;

    @Override
    protected void channelRead0(ChannelHandlerContext ctx, Object msg)
            throws Exception {

        /**
         * HTTP接入，WebSocket第一次连接使用HTTP连接,用于握手
         */
        if(msg instanceof FullHttpRequest){
            handleHttpRequest(ctx, (FullHttpRequest)msg);
        }

        /**
         * Websocket 接入
         */
        else if(msg instanceof WebSocketFrame){
            handlerWebSocketFrame(ctx, (WebSocketFrame)msg);
        }

    }

    @Override
    public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
        ctx.flush();
    }

    @Override
    public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause)
            throws Exception {
        ctx.close();
    }

    @Override
    public void channelActive(ChannelHandlerContext ctx) throws Exception {

    }

    @Override
    public void handlerRemoved(ChannelHandlerContext ctx) throws Exception {
        CHCManager.getInstance().removeCHC(ctx);
    }

    private void handleHttpRequest(ChannelHandlerContext ctx,FullHttpRequest req){
        if (!req.getDecoderResult().isSuccess()
                || (!"websocket".equals(req.headers().get("Upgrade")))) {
            sendHttpResponse(ctx, req, new DefaultFullHttpResponse(
                    HttpVersion.HTTP_1_1, HttpResponseStatus.BAD_REQUEST));
            return;
        }

        //建立和客户端握手报文
        //TODO ws://localhost:9635/ws 这个地址有什么用
        WebSocketServerHandshakerFactory wsFactory = new WebSocketServerHandshakerFactory(
                "ws://localhost:9635/ws", null, false);
        handshaker = wsFactory.newHandshaker(req);
        if (handshaker == null) {
            WebSocketServerHandshakerFactory
                    .sendUnsupportedWebSocketVersionResponse(ctx.channel());
        } else {
            handshaker.handshake(ctx.channel(), req);
        }
    }

    private static void sendHttpResponse(ChannelHandlerContext ctx,
                                         FullHttpRequest req, DefaultFullHttpResponse res) {
        // 返回应答给客户端
        if (res.getStatus().code() != 200) {
            ByteBuf buf = Unpooled.copiedBuffer(res.getStatus().toString(),
                    CharsetUtil.UTF_8);
            res.content().writeBytes(buf);
            buf.release();
        }
        // 如果是非Keep-Alive，关闭连接
        ChannelFuture f = ctx.channel().writeAndFlush(res);
        if (!isKeepAlive(req) || res.getStatus().code() != 200) {
            f.addListener(ChannelFutureListener.CLOSE);
        }
    }

    private static boolean isKeepAlive(FullHttpRequest req) {
        return false;
    }

    private void handlerWebSocketFrame(final ChannelHandlerContext ctx,
                                       WebSocketFrame frame) {

        /**
         * 判断是否关闭链路的指令
         */
        if (frame instanceof CloseWebSocketFrame) {
            handshaker.close(ctx.channel(),
                    (CloseWebSocketFrame) frame.retain());
            return;
        }

        /**
         * 判断是否ping消息
         */
        if (frame instanceof PingWebSocketFrame) {
            ctx.channel().write(
                    new PongWebSocketFrame(frame.content().retain()));
            return;
        }

        /**
         * 本例程仅支持文本消息，不支持二进制消息
         */
        if (frame instanceof BinaryWebSocketFrame) {
            throw new UnsupportedOperationException(String.format(
                    "%s frame types not supported", frame.getClass().getName()));
        }
        if(frame instanceof TextWebSocketFrame){
            // 返回应答消息
            final String request = ((TextWebSocketFrame) frame).text();
            System.out.println("服务端收到：" + request);

            //解码base64(等上线之前在打开，方便测试)
     /*       byte[] b = null;
            String result = null;
            BASE64Decoder decoder = new BASE64Decoder();
            try {
                b = decoder.decodeBuffer(request);
                result = new String(b,"utf-8");
                System.out.println("服务端收到：" + result);
            } catch (Exception e) {
                e.printStackTrace();
            }*/

            ExecutorService executorService = ThreadPoolManager.getInstance().getCachedThreadPool();
            executorService.execute(new Runnable() {

                public void run() {
                    //处理头格式
                    JSONObject jb = new JSONObject(request);
                    String head = jb.get("head").toString();
                    String[]headArr = head.split("_");


                    String className = "game.net.datapackage."+headArr[1];
                    try {
                        DataPackage dp = (DataPackage)Class.forName(className).newInstance();
                        dp.setChannelHandlerContext(ctx);
                        dp.analyData(jb);

                    } catch (ClassNotFoundException e) {
                    } catch (IllegalAccessException e) {
                        e.printStackTrace();
                    } catch (InstantiationException e) {
                        e.printStackTrace();
                    }
                }
            });


    /*            new Thread(new Runnable() {
                public void run() {

                }
            }).start();*/

        }

    }
}
