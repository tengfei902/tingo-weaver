package com.tingo.weaver.model.po;

import java.math.BigDecimal;

public class CompanyUserLink {
    private BigDecimal id;

    private BigDecimal userid;

    private String status;

    private BigDecimal companyid;

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getUserid() {
        return userid;
    }

    public void setUserid(BigDecimal userid) {
        this.userid = userid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public BigDecimal getCompanyid() {
        return companyid;
    }

    public void setCompanyid(BigDecimal companyid) {
        this.companyid = companyid;
    }
}