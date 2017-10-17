package com.tingo.weaver.model.dto;

import com.tingo.weaver.utils.enums.TdType;

/**
 * Created by user on 17/10/17.
 */
public class Input {
    private String id;
    private TdType tdType;
    private String value;
    private String name;

    public Input(String id,TdType tdType,String name,String value) {
        this.id = id;
        this.tdType = tdType;
        this.name = name;
        this.value = value;
    }

    public Input(String id,TdType tdType,String name) {
        this.id = id;
        this.tdType = tdType;
        this.name = name;
        this.value = "";
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public TdType getTdType() {
        return tdType;
    }

    public void setTdType(TdType tdType) {
        this.tdType = tdType;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
