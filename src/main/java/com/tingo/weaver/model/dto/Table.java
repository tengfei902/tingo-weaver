package com.tingo.weaver.model.dto;

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
