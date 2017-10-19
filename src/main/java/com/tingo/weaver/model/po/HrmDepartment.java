package com.tingo.weaver.model.po;

import java.math.BigDecimal;

public class HrmDepartment {
    private BigDecimal id;

    private String departmentmark;

    private String departmentname;

    private BigDecimal subcompanyid1;

    private BigDecimal supdepid;

    private String allsupdepid;

    private BigDecimal showorder;

    private String canceled;

    private String departmentcode;

    private BigDecimal coadjutant;

    private String zzjgbmfzr;

    private String zzjgbmfgld;

    private String jzglbmfzr;

    private String jzglbmfgld;

    private String bmfzr;

    private String bmfgld;

    private BigDecimal budgetatuomoveorder;

    public BigDecimal getId() {
        return id;
    }

    public void setId(BigDecimal id) {
        this.id = id;
    }

    public String getDepartmentmark() {
        return departmentmark;
    }

    public void setDepartmentmark(String departmentmark) {
        this.departmentmark = departmentmark == null ? null : departmentmark.trim();
    }

    public String getDepartmentname() {
        return departmentname;
    }

    public void setDepartmentname(String departmentname) {
        this.departmentname = departmentname == null ? null : departmentname.trim();
    }

    public BigDecimal getSubcompanyid1() {
        return subcompanyid1;
    }

    public void setSubcompanyid1(BigDecimal subcompanyid1) {
        this.subcompanyid1 = subcompanyid1;
    }

    public BigDecimal getSupdepid() {
        return supdepid;
    }

    public void setSupdepid(BigDecimal supdepid) {
        this.supdepid = supdepid;
    }

    public String getAllsupdepid() {
        return allsupdepid;
    }

    public void setAllsupdepid(String allsupdepid) {
        this.allsupdepid = allsupdepid == null ? null : allsupdepid.trim();
    }

    public BigDecimal getShoworder() {
        return showorder;
    }

    public void setShoworder(BigDecimal showorder) {
        this.showorder = showorder;
    }

    public String getCanceled() {
        return canceled;
    }

    public void setCanceled(String canceled) {
        this.canceled = canceled == null ? null : canceled.trim();
    }

    public String getDepartmentcode() {
        return departmentcode;
    }

    public void setDepartmentcode(String departmentcode) {
        this.departmentcode = departmentcode == null ? null : departmentcode.trim();
    }

    public BigDecimal getCoadjutant() {
        return coadjutant;
    }

    public void setCoadjutant(BigDecimal coadjutant) {
        this.coadjutant = coadjutant;
    }

    public String getZzjgbmfzr() {
        return zzjgbmfzr;
    }

    public void setZzjgbmfzr(String zzjgbmfzr) {
        this.zzjgbmfzr = zzjgbmfzr == null ? null : zzjgbmfzr.trim();
    }

    public String getZzjgbmfgld() {
        return zzjgbmfgld;
    }

    public void setZzjgbmfgld(String zzjgbmfgld) {
        this.zzjgbmfgld = zzjgbmfgld == null ? null : zzjgbmfgld.trim();
    }

    public String getJzglbmfzr() {
        return jzglbmfzr;
    }

    public void setJzglbmfzr(String jzglbmfzr) {
        this.jzglbmfzr = jzglbmfzr == null ? null : jzglbmfzr.trim();
    }

    public String getJzglbmfgld() {
        return jzglbmfgld;
    }

    public void setJzglbmfgld(String jzglbmfgld) {
        this.jzglbmfgld = jzglbmfgld == null ? null : jzglbmfgld.trim();
    }

    public String getBmfzr() {
        return bmfzr;
    }

    public void setBmfzr(String bmfzr) {
        this.bmfzr = bmfzr == null ? null : bmfzr.trim();
    }

    public String getBmfgld() {
        return bmfgld;
    }

    public void setBmfgld(String bmfgld) {
        this.bmfgld = bmfgld == null ? null : bmfgld.trim();
    }

    public BigDecimal getBudgetatuomoveorder() {
        return budgetatuomoveorder;
    }

    public void setBudgetatuomoveorder(BigDecimal budgetatuomoveorder) {
        this.budgetatuomoveorder = budgetatuomoveorder;
    }
}