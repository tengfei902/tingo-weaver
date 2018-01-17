package com.tingo.weaver.model.gson;

import java.math.BigDecimal;

public class ZpGson {
    private Long orgId;
    private String zpStatus;
    private BigDecimal zpf;

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public String getZpStatus() {
        return zpStatus;
    }

    public void setZpStatus(String zpStatus) {
        this.zpStatus = zpStatus;
    }

    public BigDecimal getZpf() {
        return zpf;
    }

    public void setZpf(BigDecimal zpf) {
        this.zpf = zpf;
    }
}
