package com.tingo.weaver.utils.enums;

import org.apache.commons.lang3.StringUtils;

/**
 * Created by tengfei on 2018/1/6.
 */
public enum Kpfs {
    ADD,
    MINUS,
    NO;

    public static Kpfs parse(String fs) {
        for(Kpfs kpfs:Kpfs.values()) {
            if(StringUtils.equalsIgnoreCase(fs,kpfs.name())) {
                return kpfs;
            }
        }
        return null;
    }
}
