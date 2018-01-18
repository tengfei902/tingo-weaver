package com.tingo.weaver.model.gson;

import java.math.BigDecimal;

public class PfGson {
    private Long itemDetailId;
    private Long orgId;
    private String org;
    private Long toOrgId;
    private String toOrg;
    private BigDecimal pf;
    private String pfStatus;
    private String pfsm;

    public Long getItemDetailId() {
        return itemDetailId;
    }

    public void setItemDetailId(Long itemDetailId) {
        this.itemDetailId = itemDetailId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public String getOrg() {
        return org;
    }

    public void setOrg(String org) {
        this.org = org;
    }

    public Long getToOrgId() {
        return toOrgId;
    }

    public void setToOrgId(Long toOrgId) {
        this.toOrgId = toOrgId;
    }

    public String getToOrg() {
        return toOrg;
    }

    public void setToOrg(String toOrg) {
        this.toOrg = toOrg;
    }

    public BigDecimal getPf() {
        return pf;
    }

    public void setPf(BigDecimal pf) {
        this.pf = pf;
    }

    public String getPfStatus() {
        return pfStatus;
    }

    public void setPfStatus(String pfStatus) {
        this.pfStatus = pfStatus;
    }

    public String getPfsm() {
        return pfsm;
    }

    public void setPfsm(String pfsm) {
        this.pfsm = pfsm;
    }
}
