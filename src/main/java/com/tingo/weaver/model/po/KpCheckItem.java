package com.tingo.weaver.model.po;

import java.util.Date;

public class KpCheckItem {
    private Long id;

    private Long qdId;

    private String qd;

    private String kpnr;

    private String kpfs;

    private String pfbm;

    private Integer jd;

    private Integer status;

    private Date createTime;

    private Date updateTime;

    private Integer version;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getKpnr() {
        return kpnr;
    }

    public void setKpnr(String kpnr) {
        this.kpnr = kpnr;
    }

    public String getKpfs() {
        return kpfs;
    }

    public void setKpfs(String kpfs) {
        this.kpfs = kpfs;
    }

    public String getPfbm() {
        return pfbm;
    }

    public void setPfbm(String pfbm) {
        this.pfbm = pfbm;
    }

    public Integer getJd() {
        return jd;
    }

    public void setJd(Integer jd) {
        this.jd = jd;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
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

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }
}