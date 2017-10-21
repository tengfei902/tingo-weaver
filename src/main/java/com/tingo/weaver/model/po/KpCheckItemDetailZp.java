package com.tingo.weaver.model.po;

import java.math.BigDecimal;
import java.util.Date;

public class KpCheckItemDetailZp {
    private BigDecimal id;

    private BigDecimal itemId;

    private BigDecimal detailId;

    private BigDecimal zpId;

    private BigDecimal orgId;

    private BigDecimal pf;

    private Date zpTime;

    private Date createTime;

    private Date updateTime;

    private BigDecimal version;

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

    public BigDecimal getDetailId() {
        return detailId;
    }

    public void setDetailId(BigDecimal detailId) {
        this.detailId = detailId;
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

    public BigDecimal getPf() {
        return pf;
    }

    public void setPf(BigDecimal pf) {
        this.pf = pf;
    }

    public Date getZpTime() {
        return zpTime;
    }

    public void setZpTime(Date zpTime) {
        this.zpTime = zpTime;
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