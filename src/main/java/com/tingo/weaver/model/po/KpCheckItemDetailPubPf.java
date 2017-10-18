package com.tingo.weaver.model.po;

import java.math.BigDecimal;
import java.util.Date;

public class KpCheckItemDetailPubPf {
    private BigDecimal id;

    private BigDecimal pubId;

    private BigDecimal pubDetailId;

    private BigDecimal orgId;

    private BigDecimal status;

    private BigDecimal pf;

    private BigDecimal type;

    private Date kpTime;

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

    public BigDecimal getPubDetailId() {
        return pubDetailId;
    }

    public void setPubDetailId(BigDecimal pubDetailId) {
        this.pubDetailId = pubDetailId;
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

    public BigDecimal getPf() {
        return pf;
    }

    public void setPf(BigDecimal pf) {
        this.pf = pf;
    }

    public BigDecimal getType() {
        return type;
    }

    public void setType(BigDecimal type) {
        this.type = type;
    }

    public Date getKpTime() {
        return kpTime;
    }

    public void setKpTime(Date kpTime) {
        this.kpTime = kpTime;
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