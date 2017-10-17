package com.tingo.weaver.model.dto;

/**
 * Created by user on 17/10/17.
 */
public class Head {

    private Label label;
    private Input input;
    private Integer row;

    public Head label(Label label) {
        this.label = label;
        return this;
    }

    public Head input(Input input) {
        this.input = input;
        return this;
    }

    public Head row(int  row) {
        this.row = row;
        return this;
    }

    public Label getLabel() {
        return label;
    }

    public Input getInput() {
        return input;
    }

    public Integer getRow() {
        return row;
    }
}
