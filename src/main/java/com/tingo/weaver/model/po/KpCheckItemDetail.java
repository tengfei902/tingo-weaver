package com.tingo.weaver.model.po;

import java.math.BigDecimal;
import java.util.Date;

public class KpCheckItemDetail {
    private Long id;

    private Long itemId;

    private String pfbz;

    private BigDecimal fs;

    private String tkxz;

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

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public String getPfbz() {
        return pfbz;
    }

    public void setPfbz(String pfbz) {
        this.pfbz = pfbz;
    }

    public BigDecimal getFs() {
        return fs;
    }

    public void setFs(BigDecimal fs) {
        this.fs = fs;
    }

    public String getTkxz() {
        return tkxz;
    }

    public void setTkxz(String tkxz) {
        this.tkxz = tkxz;
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