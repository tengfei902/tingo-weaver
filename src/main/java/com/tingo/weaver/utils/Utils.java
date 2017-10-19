package com.tingo.weaver.utils;

import java.util.Calendar;

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

    public static int getCurrentSeason() {
        Calendar now = Calendar.getInstance();
        return ((now.get(Calendar.MONTH)+1)/3)+1;
    }
}
