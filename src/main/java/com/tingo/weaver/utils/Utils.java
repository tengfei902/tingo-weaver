package com.tingo.weaver.utils;

import org.apache.commons.lang3.math.NumberUtils;

import java.util.Calendar;
import java.util.Objects;

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
        return now.get(Calendar.MONTH)%3==0? now.get(Calendar.MONTH)/3: (now.get(Calendar.MONTH)/3)+1;
    }

    public static Long o2l(Object obj) {
        if(Objects.isNull(obj)) {
            return 0L;
        }
        if(!NumberUtils.isNumber(String.valueOf(obj))) {
            return 0L;
        }
        return Long.parseLong(String.valueOf(obj));
    }
}
