package com.tingo.weaver.model.dto;

import com.tingo.weaver.utils.enums.Align;
import com.tingo.weaver.utils.enums.TdType;

/**
 * Created by user on 17/10/17.
 */
public class Column {
    private String id;
    private String name;
    private String value;
    private Integer order;
    private String width;
    private boolean nowrap;
    private Align align;
    private boolean disabled;
    private String style;
    private TdType type;
    private String href;
    private String alias;
    private Select select;

    public Column(String id,String name,String value,int order) {
        this.id = id;
        this.name = name;
        this.value = value;
        this.order = order;
    }

    public Column width(String width) {
        this.width = width;
        return this;
    }

    public Column style(String style) {
        this.style = style;
        return this;
    }

    public Column type(TdType type) {
        this.type = type;
        return this;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getValue() {
        return value;
    }

    public Integer getOrder() {
        return order;
    }

    public String getWidth() {
        return width;
    }

    public boolean isNowrap() {
        return nowrap;
    }

    public Align getAlign() {
        return align;
    }

    public boolean isDisabled() {
        return disabled;
    }

    public String getStyle() {
        return style;
    }

    public TdType getType() {
        return type;
    }

    public String getHref() {
        return href;
    }

    public String getAlias() {
        return alias;
    }

    public Select getSelect() {
        return select;
    }
}
