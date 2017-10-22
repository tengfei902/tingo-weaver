package com.tingo.weaver.model.po;

import java.math.BigDecimal;

public class HrmSubCompany {
    private BigDecimal id;

    private String subcompanyname;

    private String subcompanydesc;

    private BigDecimal companyid;

    private BigDecimal supsubcomid;

    private String url;

    private BigDecimal showorder;

    private String canceled;

    private String subcompanycode;

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getSubcompanyname() {
        return subcompanyname;
    }

    public void setSubcompanyname(String subcompanyname) {
        this.subcompanyname = subcompanyname == null ? null : subcompanyname.trim();
    }

    public String getSubcompanydesc() {
        return subcompanydesc;
    }

    public void setSubcompanydesc(String subcompanydesc) {
        this.subcompanydesc = subcompanydesc == null ? null : subcompanydesc.trim();
    }

    public BigDecimal getCompanyid() {
        return companyid;
    }

    public void setCompanyid(BigDecimal companyid) {
        this.companyid = companyid;
    }

    public BigDecimal getSupsubcomid() {
        return supsubcomid;
    }

    public void setSupsubcomid(BigDecimal supsubcomid) {
        this.supsubcomid = supsubcomid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public BigDecimal getShoworder() {
        return showorder;
    }

    public void setShoworder(BigDecimal showorder) {
        this.showorder = showorder;
    }

    public String getCanceled() {
        return canceled;
    }

    public void setCanceled(String canceled) {
        this.canceled = canceled == null ? null : canceled.trim();
    }

    public String getSubcompanycode() {
        return subcompanycode;
    }

    public void setSubcompanycode(String subcompanycode) {
        this.subcompanycode = subcompanycode == null ? null : subcompanycode.trim();
    }
}