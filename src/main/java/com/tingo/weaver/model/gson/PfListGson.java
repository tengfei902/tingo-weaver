package com.tingo.weaver.model.gson;

import java.util.List;

/**
 * Created by Administrator on 2017/10/22.
 */
public class PfListGson {
    private Long pfId;
    private Long zpId;
    private Long itemId;
    private Long orgId;
    private String orgName;
    private Long toOrgId;
    private String toOrgName;
    private Long qdId;
    private String qd;
    private String kpnr;
    private String jd;
    private int zpStatus;
    private String zpStatusDesc;
    private int status;
    private String statusDesc;
    private String zpsm;
    private String pfsm;
    private List<PfDetailListGson> details;

    public Long getZpId() {
        return zpId;
    }

    public void setZpId(Long zpId) {
        this.zpId = zpId;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public Long getToOrgId() {
        return toOrgId;
    }

    public void setToOrgId(Long toOrgId) {
        this.toOrgId = toOrgId;
    }

    public String getToOrgName() {
        return toOrgName;
    }

    public void setToOrgName(String toOrgName) {
        this.toOrgName = toOrgName;
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

    public String getJd() {
        return jd;
    }

    public void setJd(String jd) {
        this.jd = jd;
    }

    public int getZpStatus() {
        return zpStatus;
    }

    public void setZpStatus(int zpStatus) {
        this.zpStatus = zpStatus;
    }

    public String getZpStatusDesc() {
        return zpStatusDesc;
    }

    public void setZpStatusDesc(String zpStatusDesc) {
        this.zpStatusDesc = zpStatusDesc;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getStatusDesc() {
        return statusDesc;
    }

    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    public String getZpsm() {
        return zpsm;
    }

    public void setZpsm(String zpsm) {
        this.zpsm = zpsm;
    }

    public String getPfsm() {
        return pfsm;
    }

    public void setPfsm(String pfsm) {
        this.pfsm = pfsm;
    }

    public List<PfDetailListGson> getDetails() {
        return details;
    }

    public void setDetails(List<PfDetailListGson> details) {
        this.details = details;
    }

    public Long getPfId() {
        return pfId;
    }

    public void setPfId(Long pfId) {
        this.pfId = pfId;
    }
}
