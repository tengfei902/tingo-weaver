package com.tingo.weaver.model.dto;

import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by user on 17/10/17.
 */
public class Table {
    private String id;
    private String name;
    private String clazz;
    private int border;
    private String style;
    private List<Column> columns;
    private String initFunction;

    public Table(String id,String name) {
        this.id = id;
        this.name = name;
    }

    public Table clazz(String clazz) {
        this.clazz = clazz;
        return this;
    }

    public Table border(int border) {
        this.border = border;
        return this;
    }

    public Table style(String style) {
        this.style = style;
        return this;
    }

    public Table addColumn(Column column) {
        if(CollectionUtils.isEmpty(columns)) {
            columns = new ArrayList<>();
        }
        columns.add(column);
        return this;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getClazz() {
        return clazz;
    }

    public int getBorder() {
        return border;
    }

    public String getStyle() {
        return style;
    }

    public List<Column> getColumns() {
        return columns;
    }

    public String getInitFunction() {
        return initFunction;
    }
}
