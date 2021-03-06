package com.tingo.weaver.utils.enums;

/**
 * Created by Administrator on 2017/10/21.
 */
public enum ZpStatus {
    NEW(0,"未自评"),CHECKED(1,"已自评");

    private int value;
    private String desc;

    ZpStatus(int value,String desc) {
        this.value = value;
        this.desc = desc;
    }

    public static ZpStatus parse(int value) {
        for(ZpStatus zpStatus:ZpStatus.values()) {
            if(zpStatus.value == value) {
                return zpStatus;
            }
        }
        return null;
    }

    public String getDesc() {
        return this.desc;
    }

    public int getValue() {
        return this.value;
    }
}
