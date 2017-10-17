package com.tingo.weaver.model.po;

import java.math.BigDecimal;

public class Qingdan {
    private Long id;

    private String qingdanmc;

    private BigDecimal qz;

    private BigDecimal status;

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

    public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }
}