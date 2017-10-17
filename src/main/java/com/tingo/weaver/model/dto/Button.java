package com.tingo.weaver.model.dto;

import com.tingo.weaver.utils.enums.TdType;

/**
 * Created by user on 17/10/17.
 */
public class Button extends Input {

    private String onclickFunction;
    private String params;

    public Button(String id, TdType tdType, String name, String value) {
        super(id, tdType, name, value);
    }

    public Button(String id, TdType tdType, String name) {
        super(id, tdType, name);
    }

    public Button onclick(String onclickFunction) {
        this.onclickFunction = onclickFunction;
        return this;
    }

    public String getOnclickFunction() {
        return onclickFunction;
    }

    public String getParams() {
        return params;
    }

    public void setParams(String params) {
        this.params = params;
    }
}
