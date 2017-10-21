package com.tingo.weaver.model.po;

import java.math.BigDecimal;
import java.util.Date;

public class KpCheckItemDetailPf {
    private BigDecimal id;

    private BigDecimal itemId;

    private BigDecimal itemDetailId;

    private BigDecimal zpId;

    private BigDecimal orgId;

    private BigDecimal toOrgId;

    private BigDecimal pf;

    private Date kpTime;

    private Date createTime;

    private Date updateTime;

    private BigDecimal version;

    private BigDecimal pfId;

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public BigDecimal getItemId() {
        return itemId;
    }

    public void setItemId(BigDecimal itemId) {
        this.itemId = itemId;
    }

    public BigDecimal getItemDetailId() {
        return itemDetailId;
    }

    public void setItemDetailId(BigDecimal itemDetailId) {
        this.itemDetailId = itemDetailId;
    }

    public BigDecimal getZpId() {
        return zpId;
    }

    public void setZpId(BigDecimal zpId) {
        this.zpId = zpId;
    }

    public BigDecimal getOrgId() {
        return orgId;
    }

    public void setOrgId(BigDecimal orgId) {
        this.orgId = orgId;
    }

    public BigDecimal getToOrgId() {
        return toOrgId;
    }

    public void setToOrgId(BigDecimal toOrgId) {
        this.toOrgId = toOrgId;
    }

    public BigDecimal getPf() {
        return pf;
    }

    public void setPf(BigDecimal pf) {
        this.pf = pf;
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

    public BigDecimal getPfId() {
        return pfId;
    }

    public void setPfId(BigDecimal pfId) {
        this.pfId = pfId;
    }
}