package com.tingo.weaver.model.po;

import java.math.BigDecimal;

public class Qingdan {
    private Long id;

    private String qingdanmc;

    private BigDecimal qz;

    private Integer status;

    private int jd;

    private String yearStr;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getQingdanmc() {
        return qingdanmc;
    }

    public void setQingdanmc(String qingdanmc) {
        this.qingdanmc = qingdanmc == null ? null : qingdanmc.trim();
    }

    public BigDecimal getQz() {
        return qz;
    }

    public void setQz(BigDecimal qz) {
        this.qz = qz;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public int getJd() {
        return jd;
    }

    public void setJd(int jd) {
        this.jd = jd;
    }

    public String getYearStr() {
        return yearStr;
    }

    public void setYearStr(String yearStr) {
        this.yearStr = yearStr;
    }
}