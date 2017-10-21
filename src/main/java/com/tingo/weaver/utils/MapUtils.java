package com.tingo.weaver.utils;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by user on 17/10/21.
 */
public class MapUtils extends org.apache.commons.collections.MapUtils {

    public static <K,V> Map<K,V> buildMap(Object... objs) {
        Map<K,V> map = new HashMap<>();
        append(map,objs);
        return map;
    }

    public static <K,V> void append(Map<K,V> map,Object... objs) {

        int z = objs.length;
        for(int i = 0; i < z - 1; i += 2) {
            map.put((K)objs[i], (V)objs[i + 1]);
        }
    }
}
