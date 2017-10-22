package com.tingo.weaver.biz.common;

import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;

import java.util.concurrent.Callable;
import java.util.concurrent.TimeUnit;

/**
 * Created by user on 17/10/22.
 */
public class HrmCache {

    private static HrmCache hrmCache;

    public static HrmCache getInstance() {
        if(null == hrmCache) {
            hrmCache = new HrmCache();
        }
        return hrmCache;
    }

    private LoadingCache<String, Object> cache;

    private HrmCache(){
        CacheLoader<String,Object> cacheLoader = new CacheLoader<String, Object>() {
            @Override
            public String load(String key) throws Exception {
                return null;
            }
        };
        cache = CacheBuilder.newBuilder()
                .maximumSize(1000)
                .expireAfterWrite(600, TimeUnit.SECONDS)
                .build(cacheLoader);
    }

    public <T> T get(Long id,HrmType type,T dataType) {
        try {
            return (T)cache.get(String.format("%s_%s", type.name(), id));
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private enum HrmType {
        HRM,
        DEPT,
        COMPANY,
        SUB_COMPANY
    }
}
