package com.tingo.weaver.biz.common;

import com.tingo.weaver.biz.RefService;
import com.tingo.weaver.utils.ApplicationContextUtils;

import java.lang.reflect.Method;
import java.util.Map;
import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by user on 17/10/17.
 */
public class BeanCache {

    private Map<String,Method> beanMap ;

    private static BeanCache beanCache;

    private BeanCache() {
        load();
    }

    public static BeanCache getInstance() {
        if(Objects.isNull(beanCache)) {
            beanCache = new BeanCache();
        }
        return beanCache;
    }

    private synchronized void load() {
        if(null == beanMap) {
            beanMap = new ConcurrentHashMap<>();
        }

        Method[] methods = RefService.class.getDeclaredMethods();

        for(Method method:methods) {
            beanMap.put(String.format("%s_%s","RefService",method.getName()),method);
        }
    }

    public Method getCachedMethod(String clazz,String methodName) {
        Method method =  beanMap.get(String.format("%s_%s",clazz,methodName));
        if(Objects.isNull(method)) {
            throw new RuntimeException(String.format("method is null,%s,%s",clazz,methodName));
        }
        return method;
    }
}
