package com.tingo.weaver.utils;

/**
 * Created by user on 17/10/16.
 */
public class Utils {

    public static Object[] convertStr2ObjArray(String in) {
        String[] strArray = in.split(",");
        Object[] obj = new Object[strArray.length];
        for(int i=0;i<strArray.length;i++) {
            obj[i] = strArray[i];
        }
        return obj;
    }
}
