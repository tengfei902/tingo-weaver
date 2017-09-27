package com.tingo.weaver.model.po;

import java.math.BigDecimal;
import java.util.Date;

public class DebtSale {
    private Long id;

    private Long userId;

    private Long boId;

    private Long vaId;

    private BigDecimal transferNum;

    private BigDecimal originalPrice;

    private BigDecimal price;

    private BigDecimal onePrice;

    private Boolean opType;

    private Integer toType;

    private String title;

    private BigDecimal transferRate;

    private BigDecimal percent;

    private Byte expect;

    private BigDecimal residueNum;

    private Date deadline;

    private Boolean status;

    private BigDecimal interest;

    private BigDecimal transAmount;

    private BigDecimal payAmount;

    private BigDecimal lockNum;

    private String seriNo;

    private Integer version;

    private Date createTime;

    private Date updateTime;

    private Long dbId;

    private Boolean transferType;

    private BigDecimal handingFeeRate;

    private BigDecimal yieldRate;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getBoId() {
        return boId;
    }

    public void setBoId(Long boId) {
        this.boId = boId;
    }

    public Long getVaId() {
        return vaId;
    }

    public void setVaId(Long vaId) {
        this.vaId = vaId;
    }

    public BigDecimal getTransferNum() {
        return transferNum;
    }

    public void setTransferNum(BigDecimal transferNum) {
        this.transferNum = transferNum;
    }

    public BigDecimal getOriginalPrice() {
        return originalPrice;
    }

    public void setOriginalPrice(BigDecimal originalPrice) {
        this.originalPrice = originalPrice;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getOnePrice() {
        return onePrice;
    }

    public void setOnePrice(BigDecimal onePrice) {
        this.onePrice = onePrice;
    }

    public Boolean getOpType() {
        return opType;
    }

    public void setOpType(Boolean opType) {
        this.opType = opType;
    }

    public Integer getToType() {
        return toType;
    }

    public void setToType(Integer toType) {
        this.toType = toType;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public BigDecimal getTransferRate() {
        return transferRate;
    }

    public void setTransferRate(BigDecimal transferRate) {
        this.transferRate = transferRate;
    }

    public BigDecimal getPercent() {
        return percent;
    }

    public void setPercent(BigDecimal percent) {
        this.percent = percent;
    }

    public Byte getExpect() {
        return expect;
    }

    public void setExpect(Byte expect) {
        this.expect = expect;
    }

    public BigDecimal getResidueNum() {
        return residueNum;
    }

    public void setResidueNum(BigDecimal residueNum) {
        this.residueNum = residueNum;
    }

    public Date getDeadline() {
        return deadline;
    }

    public void setDeadline(Date deadline) {
        this.deadline = deadline;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public BigDecimal getInterest() {
        return interest;
    }

    public void setInterest(BigDecimal interest) {
        this.interest = interest;
    }

    public BigDecimal getTransAmount() {
        return transAmount;
    }

    public void setTransAmount(BigDecimal transAmount) {
        this.transAmount = transAmount;
    }

    public BigDecimal getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(BigDecimal payAmount) {
        this.payAmount = payAmount;
    }

    public BigDecimal getLockNum() {
        return lockNum;
    }

    public void setLockNum(BigDecimal lockNum) {
        this.lockNum = lockNum;
    }

    public String getSeriNo() {
        return seriNo;
    }

    public void setSeriNo(String seriNo) {
        this.seriNo = seriNo == null ? null : seriNo.trim();
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
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

    public Long getDbId() {
        return dbId;
    }

    public void setDbId(Long dbId) {
        this.dbId = dbId;
    }

    public Boolean getTransferType() {
        return transferType;
    }

    public void setTransferType(Boolean transferType) {
        this.transferType = transferType;
    }

    public BigDecimal getHandingFeeRate() {
        return handingFeeRate;
    }

    public void setHandingFeeRate(BigDecimal handingFeeRate) {
        this.handingFeeRate = handingFeeRate;
    }

    public BigDecimal getYieldRate() {
        return yieldRate;
    }

    public void setYieldRate(BigDecimal yieldRate) {
        this.yieldRate = yieldRate;
    }
}