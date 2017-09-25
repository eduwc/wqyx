package base.thread.pool;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by Administrator on 2017/9/7 0007.
 */
public class ThreadPoolManager {

    static ThreadPoolManager _instance = null;
    private ExecutorService cachedThreadPool = null;

    public static ThreadPoolManager getInstance()
    {
        if(_instance == null)
        {
            _instance = new ThreadPoolManager();
        }
        return  _instance;
    }


    public ThreadPoolManager()
    {
        cachedThreadPool = Executors.newCachedThreadPool();
    }


    public  ExecutorService getCachedThreadPool()
    {
        return cachedThreadPool;
    }
}
