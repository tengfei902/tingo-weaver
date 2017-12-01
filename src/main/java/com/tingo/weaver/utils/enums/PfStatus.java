package com.tingo.weaver.utils.enums;

/**
 * Created by user on 17/10/18.
 */
public enum PfStatus {
    NEW(0,"待自评"),
    SELF_MARKED(1,"已自评"),
    MARKED(2,"已考核"),
    STOPPED(99,"已终止");

    private int value;
    private String desc;

    PfStatus(int value,String desc) {
        this.value = value;
        this.desc = desc;
    }

    public static PfStatus parse(int value) {
        for(PfStatus pfStatus:PfStatus.values()) {
            if(pfStatus.value == value) {
                return pfStatus;
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
