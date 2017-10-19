package com.tingo.weaver.utils.enums;

/**
 * Created by user on 17/10/19.
 */
public enum Jd {

    ONE(1,"第一季度"),TWO(2,"第二季度"),THREE(3,"第三季度"),FOUR(4,"第四季度");

    private int value;
    private String desc;

    Jd(int value,String desc) {
        this.value = value;
        this.desc = desc;
    }

    public static Jd parse(int value) {
        for(Jd jd: Jd.values()) {
            if(jd.value == value) {
                return jd;
            }
        }
        return null;
    }

    public String getDesc() {
        return this.desc;
    }
}
