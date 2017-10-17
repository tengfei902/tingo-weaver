package com.tingo.weaver.model.dto;

/**
 * Created by user on 17/10/17.
 */
public class Label {
    private String label;
    private Integer length;

    public Label(String label,Integer length) {
        this.label = label;
        this.length = length;
    }

    public Label(String label) {
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public Integer getLength() {
        return length;
    }

    public void setLength(Integer length) {
        this.length = length;
    }
}
