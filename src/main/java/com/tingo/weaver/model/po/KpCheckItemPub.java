package com.tingo.weaver.model.po;

import java.math.BigDecimal;
import java.util.Date;

public class KpCheckItemPub {
    private BigDecimal id;

    private BigDecimal itemId;

    private BigDecimal qdId;

    private String qd;

    private String kpnr;

    private BigDecimal kpfs;

    private String pfbm;

    private BigDecimal jd;

    private BigDecimal status;

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

    public BigDecimal getQdId() {
        return qdId;
    }

    public void setQdId(BigDecimal qdId) {
        this.qdId = qdId;
    }

    public String getQd() {
        return qd;
    }

    public void setQd(String qd) {
        this.qd = qd == null ? null : qd.trim();
    }

    public String getKpnr() {
        return kpnr;
    }

    public void setKpnr(String kpnr) {
        this.kpnr = kpnr == null ? null : kpnr.trim();
    }

    public BigDecimal getKpfs() {
        return kpfs;
    }

    public void setKpfs(BigDecimal kpfs) {
        this.kpfs = kpfs;
    }

    public String getPfbm() {
        return pfbm;
    }

    public void setPfbm(String pfbm) {
        this.pfbm = pfbm == null ? null : pfbm.trim();
    }

    public BigDecimal getJd() {
        return jd;
    }

    public void setJd(BigDecimal jd) {
        this.jd = jd;
    }

    public BigDecimal getStatus() {
        return status;
    }

    public void setStatus(BigDecimal status) {
        this.status = status;
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