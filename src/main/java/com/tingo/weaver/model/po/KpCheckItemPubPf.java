package com.tingo.weaver.model.po;

import java.math.BigDecimal;
import java.util.Date;

public class KpCheckItemPubPf {
    private BigDecimal id;

    private BigDecimal pubId;

    private BigDecimal orgId;

    private BigDecimal status;

    private String pfsm;

    private Date kpTime;

    private BigDecimal jd;

    private BigDecimal type;

    private Date createTime;

    private Date updateTime;

    private BigDecimal version;

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getPubId() {
        return pubId;
    }

    public void setPubId(BigDecimal pubId) {
        this.pubId = pubId;
    }

    public BigDecimal getOrgId() {
        return orgId;
    }

    public void setOrgId(BigDecimal orgId) {
        this.orgId = orgId;
    }

    public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
    }

    public String getPfsm() {
        return pfsm;
    }

    public void setPfsm(String pfsm) {
        this.pfsm = pfsm == null ? null : pfsm.trim();
    }

    public Date getKpTime() {
        return kpTime;
    }

    public void setKpTime(Date kpTime) {
        this.kpTime = kpTime;
    }

    public BigDecimal getJd() {
        return jd;
    }

    public void setJd(BigDecimal jd) {
        this.jd = jd;
    }

    public BigDecimal getType() {
        return type;
    }

    public void setType(BigDecimal type) {
        this.type = type;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public BigDecimal getVersion() {
        return version;
    }

    public void setVersion(BigDecimal version) {
        this.version = version;
    }
}