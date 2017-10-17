package com.tingo.weaver.model.dto;

/**
 * Created by user on 17/10/17.
 */
public class Option {
    private String name;
    private String value;
    private boolean checked;
    private Integer order;

    public Option(String name,String value,Integer order) {
        this.name = name;
        this.value = value;
        this.order = order;
    }

    public Option checked() {
        this.checked = true;
        return this;
    }

    public String getName() {
        return name;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public Integer getOrder() {
        return order;
    }
}
