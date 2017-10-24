package com.tingo.weaver.model.po;

import java.math.BigDecimal;
import java.util.Date;

public class KpCheckItemPf {
    private BigDecimal id;

    private BigDecimal itemId;

    private BigDecimal zpId;

    private BigDecimal orgId;

    private Long qdId;

    private String qd;

    private BigDecimal status;

    private String pfsm;

    private Date kpTime;

    private BigDecimal jd;

    private Date createTime;

    private Date updateTime;

    private BigDecimal version;

    private BigDecimal toOrgId;

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

    public BigDecimal getToOrgId() {
        return toOrgId;
    }

    public void setToOrgId(BigDecimal toOrgId) {
        this.toOrgId = toOrgId;
    }

    public Long getQdId() {
        return qdId;
    }

    public void setQdId(Long qdId) {
        this.qdId = qdId;
    }

    public String getQd() {
        return qd;
    }

    public void setQd(String qd) {
        this.qd = qd;
    }
}