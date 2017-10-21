package com.tingo.weaver.utils.enums;

/**
 * Created by user on 17/10/18.
 */
public enum PfType {
    ZP(0,"自评"),PF(1,"考核");

    private int value;
    private String desc;

    PfType(int value,String desc) {
        this.value = value;
        this.desc = desc;
    }

    public static PfType parse(int value) {
        for(PfType pfType:PfType.values()) {
            if(pfType.value == value) {
                return pfType;
            }
        }
        return null;
    }

    public int getValue() {
        return this.value;
    }
}
