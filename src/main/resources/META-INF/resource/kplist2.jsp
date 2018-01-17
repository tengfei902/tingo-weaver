<%@page import="org.apache.commons.lang.NumberUtils"%>
<%@page import="org.bouncycastle.asn1.DERApplicationSpecific"%>
<%@page import="weaver.mobile.rest.gson.tingo.ZcDetailListGson"%>
<%@page import="weaver.mobile.rest.gson.tingo.ZcListGson"%>
<%@page import="weaver.mobile.rest.gson.tingo.QingdanGson"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="weaver.general.Util,java.util.*,java.math.*"%>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo"
             class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo"
             class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="TrainTypeComInfo"
             class="weaver.hrm.tools.TrainTypeComInfo" scope="page" />
<jsp:useBean id="TrainComInfo" class="weaver.hrm.train.TrainComInfo"
             scope="page" />
<jsp:useBean id="TrainResourceComInfo"
             class="weaver.hrm.train.TrainResourceComInfo" scope="page" />
<jsp:useBean id="TrainPlanComInfo"
             class="weaver.hrm.train.TrainPlanComInfo" scope="page" />

<jsp:useBean id="weaverClient"
             class="weaver.mobile.rest.common.WeaverClient" scope="page" />
<HTML>
<HEAD>
    <LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
    <LINK href="/css/crmcss/lanlv.css" type=text/css rel=STYLESHEET>
    <SCRIPT language="javascript" src="/js/weaver.js"></script>
    <script type="text/javascript" src="/js/jquery/jquery.js"></script>
    <script language="javascript"
            src="/wui/theme/ecology7/jquery/js/zDialog.js"></script>
    <script language="javascript"
            src="/wui/theme/ecology7/jquery/js/zDrag.js"></script>
</head>
<%
    int msgid = Util.getIntValue(request.getParameter("msgid"), -1);
    String resourceid = Util.null2String(request
            .getParameter("resourceid"));

    if (resourceid.equals(""))
        resourceid = String.valueOf(user.getUID());

    char separator = Util.getSeparator();

    String imagefilename = "/images/hdReport.gif";
    String titlename = SystemEnv.getHtmlLabelName(181511,
            user.getLanguage())
            + "-"
            + SystemEnv.getHtmlLabelName(181524, user.getLanguage());
    String needfav = "1";
    String needhelp = "";
    int userid = user.getUID();
    int deptId = user.getUserDepartment();
    String resourceId = "";

    String id = "";
    String tmpvalue1 = "";
    String tmpname1 = "";
    String type1 = "1";
    int tmpcount1 = 1;

    if (resourceid.equals(""))
        resourceid = String.valueOf(user.getUID());
    String deptname = DepartmentComInfo.getDepartmentname(deptId+"");
    String username = user.getUsername();

    String jdStr = Util.null2String(request.getParameter("jd"));
    int jd = (StringUtils.isEmpty(jdStr) || !NumberUtils.isNumber(jdStr))?weaverClient.getCurrentSeason():Integer.parseInt(jdStr);

    String status = request.getParameter("status");
    String qingdanId = request.getParameter("qingdanid");

    List<QingdanGson> qds = weaverClient.getQingdanList(jd);
    List<ZcListGson> zcList = weaverClient.getZcList(String.valueOf(userid), status, String.valueOf(jd), qingdanId);

    int rowindex = 0;
    int view = Util.getIntValue(request.getParameter("view"),0);

%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp"%>
<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
<%
    RCMenu += "{查询,javascript:doSearch(),_self} ";
    RCMenuHeight += RCMenuHeightStep;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp"%>
<table width=100% height=100% border="0" cellspacing="0"
       cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">
        <tr>
            <td></td>
            <td valign="top">
                <TABLE class=Shadow>
                    <tr>
                        <td valign="top">
                                <%
								if (msgid != -1) {
							%>
                            <DIV>
                                <font color=red size=2> <%=SystemEnv.getErrorMsgName(msgid, user.getLanguage())%>
                                </font>
                            </DIV> <%
 	}
 %> <%
 	if (HrmUserVarify.checkUserRight("HrmResourceTrainRecordAdd:Add",
 			user)) {
 %>
                            <!--<BUTTON class=Btn id=button1 accessKey=A
onclick='location.href="HrmResourceTrainRecordAdd.jsp?resourceid=<%=resourceid%>"' name=button1><U>A</U>-<%=SystemEnv.getHtmlLabelName(365, user.getLanguage())%></BUTTON>-->
                                <%
								}
							%>

                            <table class="ViewForm outertable">
                                <tbody>
                                <tr />
                                <tr>
                                    <td><br />
                                        <div align="center">
                                            <font class="reqname">考评自测</font>
                                        </div>
                                        <table class="ViewForm maintable">
    <colgroup>
        <col width="10%"></col>
        <col width="40%"></col>
        <col width="10%"></col>
        <col width="40%"></col>
    </colgroup>
    <tbody>
    <tr>
        <TD class="fname">部门</TD>
        <TD class="fvalue"><%=deptname %></TD>
        <input type="hidden" id="khbmid" readonly>

        <TD class="fname">当前用户</TD>
        <TD class="fvalue"><%=username %></TD>
    </tr>
    <tr>
        <TD class="fname">考评年度</TD>
        <TD class="fvalue">
            <select id="kpyear">
                <option id="kpyear1" value="<%=2017%>" <%if(yearStr==2017) { %>selected="selected"<%} %>>2017</option>
                <option id="kpyear2" value="<%=2018%>" <%if(yearStr==2018) { %>selected="selected"<%} %>>2018</option>
            </select>
        </TD>
        <TD class="fname">考评季度</TD>
        <TD class="fvalue">
            <select id="kpmonth">
                <option id="kpMonth1" value="<%=1%>" <%if(jd==1) { %>selected="selected"<%} %>>一季度</option>
                <option id="kpMonth2" value="<%=2%>" <%if(jd==2) { %>selected="selected"<%} %>>二季度</option>
                <option id="kpMonth3" value="<%=3%>" <%if(jd==3) { %>selected="selected"<%} %>>三季度</option>
                <option id="kpMonth4" value="<%=4%>" <%if(jd==4) { %>selected="selected"<%} %>>四季度</option>
            </select>
        </TD>
    </tr>
    <tr>
        <TD class="fname">清单列表</TD>
        <td><select id="qingdanSelect">
            <option value="">全部</option>
            <%
                for(QingdanGson qd:qds) {
                    boolean selected = false;
                    if(StringUtils.equals(String.valueOf(qd.getId()), qingdanId)) {
                        selected = true;
                    }
            %>
            <option id="selectQingdan<%=qd.getId()%>" value="<%=qd.getId()%>" <%if(selected) { %>selected="selected"<%} %>><%=qd.getQingdanmc()%></option>
            <%
                }
            %>
        </select></td>
    </tr>
    </tbody>
</table></td>
</tr>
</tbody>
</table>

<table id="table0button" class="form"
       style="word-wrap: break-word; left: 0px; width: 100%"
       name="table0button">
    <tbody>
    <colgroup>
        <col width="5%"></col>
        <col width="5%"></col>
        <col width="10%"></col>
        <col width="80%"></col>
    </colgroup>
    <p>&nbsp;</p>
    </tbody>
</table>
<table id="table1button" class="form"
       style="word-wrap: break-word; left: 0px; width: 100%"
       name="table1button">
    <tbody>
    <tr>
        <td colspan="2">
            <table id="oTable1"
                   class="ListStyle detailtable detailtableTopTable"
                   style="width: 100%" border="1" name="oTable1">
                <colgroup>
                    <COL width="3%">
                    <COL width="6%">
                    <COL width="10%">
                    <COL width="5%">
                    <COL width="5%">
                    <COL width="20%">
                    <COL width="5%">
                    <COL width="20%">
                    <COL width="5%">
                    <COL width="20%">
                </colgroup>
                <tbody>
                <tr class="header detailtitle">
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9635" class="Label" name="label9635"
                            value="考评公司" disabled="true" style="width:100px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9635" class="Label" name="label9635"
                            value="清单名称" disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9635" class="Label" name="label9635"
                            value="考评内容" disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9637" class="Label" name="label9637"
                            value="考评季度" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9636" class="Label" name="label9636"
                            value="条款细则" disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9637" class="Label" name="label9637"
                            value="分值" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9637" class="Label" name="label9637"
                            value="评分标准" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9644" class="Label" name="label9639"
                            value="自评分" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9646" class="Label" name="label9639"
                            value="自评说明" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9647" class="Label" name="label9639"
                            value="评分部门" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9648" class="Label" name="label9639"
                            value="评分" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9649" class="Label" name="label9639"
                            value="评分状态" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9650" class="Label" name="label9639"
                            value="评分说明" disabled="true" style="width:60px;" /></td>
                </tr>
                </tbody>
                <%

                    for(int i=0;i<zcList.size();i++) {
                        ZcListGson zc = zcList.get(i);
                        int rowspan = zc.getDetails().size();

                        for(int detailCount = 0;detailCount<zc.getDetails().size();detailCount++) {
                            ZcDetailListGson detail = zc.getDetails().get(detailCount);

                %>
                <tr>
                    <%if(detailCount == 0) { %>
                    <td rowspan="<%=rowspan%>">
                        <div id='kpgs_<%=i %>' name='kpgs_<%=i %>' style='width=80%'><%=zc.getOrgName() %></div>
                        <input type="hidden" id='zpId_<%=i %>' value="<%=zc.getZpId()%>">
                    </td>
                    <td rowspan="<%=rowspan%>"><div id='qd_<%=i %>' name='qd_<%=i %>' style='width=80%'><%=zc.getQd() %></div></td>
                    <td rowspan="<%=rowspan%>"><div id='kpnr_<%=i %>' name='kpnr_<%=i %>' style='width=80%'><%=zc.getKpnr() %></div></td>
                    <td rowspan="<%=rowspan%>"><div id='jd_<%=i %>' name='jd_<%=i %>' style='width=80%'><%=zc.getJd() %></div></td>
                    <td rowspan="<%=rowspan%>"><div id='status_<%=i %>' name='status_<%=i %>' style='width=80%'><%=zc.getStatusDesc() %></div></td>
                    <%} %>
                    <td>
                        <div id='tkxz_<%=rowindex %>' name='tkxz_<%=rowindex %>' style='width=80%'><%=detail.getTkxz()%></div>
                        <input type="hidden" id="detailId_<%=rowindex%>" value="<%=detail.getZpDetailId()%>">
                    </td>
                    <td><div id='fz_<%=rowindex %>' name='fz_<%=rowindex %>' style='width=80%'><%=null == detail.getFz()?"":detail.getFz()%></div></td>
                    <td><div id='pfbz_<%=rowindex %>' name='pfbz_<%=rowindex %>' style='width=80%'><%=detail.getPfbz()%></div></td>
                    <%
                        if(zc.getStatus() == 0 && view != 1) {
                    %>
                    <td><input type="text" id='zpf_<%=rowindex %>' name='zpf_<%=rowindex %>' style='width=80%' value="<%=(null==detail.getZpf() || detail.getZpf().compareTo(BigDecimal.ZERO)<=0)?detail.getFz():detail.getZpf()%>"></td>
                    <%} else { %>
                    <td><div id='zpf_<%=rowindex %>' name='zpf_<%=rowindex %>' style='width=80%'><%=detail.getZpf()%>
                    </div></td>
                    <%}
                        rowindex++;
                    %>

                    <%
                        if(detailCount == 0) {
                            if(zc.getStatus() == 0 && view != 1) {
                    %>
                    <td rowspan="<%=rowspan%>"><textarea id='zpsm_<%=i %>' name='zpsm_<%=i %>' cols="80" style='height: <%=zc.getDetails().size()*35 %>' ><%=null==zc.getZpsm()?"":zc.getZpsm() %></textarea></td>
                    <%
                    } else {
                    %>
                    <td rowspan="<%=rowspan%>"><div id='zpsm_<%=i %>' name='zpsm_<%=i %>' style='width=80%'><%=zc.getZpsm() %></div></td>
                    <%
                            }
                        }
                    %>
                </tr>
                <%
                        }
                    }
                %>
            </table>
        </td>
    </tr>
    </tbody>
</table>

<script>
    function doSave() {
        var mainCount = <%=zcList.size()%>;
        var detailCount = <%=rowindex%>;

        var zps = [];

        for(var row = 0;row<mainCount;row++) {
            zps.push({
                zpId:$("#zpId_"+row).val(),
                zpsm:$("#zpsm_"+row).val()
            });
        }

        var details = [];

        var isBeak = false;

        for(var row = 0;row<detailCount;row++) {
            if(isNaN($("#zpf_"+row).val())) {
                alert("自评分必须为数字");
                isBeak=true;
                return false;
            }

            if(parseFloat($("#zpf_"+row).val()) > parseFloat($("#fz_"+row).html())) {
                alert("自评分必须小于分数上限");
                isBeak = true;
                return false;
            }

            details.push({
                detailId:$("#detailId_"+row).val(),
                zpf:$("#zpf_"+row).val()
            });
        }

        if(isBeak) {
            return false;
        }

        var obj = {"zps":zps,"details":details};

        var status = $("#statusSelect").val();
        var qingdanid = $("#qingdanSelect").val();
        var jd = $("#kpmonth").val();

        jQuery.ajax({
            type:"POST",
            url:"/service/common/saveZp",
            contentType: "application/json",
            data:JSON.stringify(obj),
            success:function(res){
                alert("保存成功");
                window.location.href="kpzcList.jsp?status="+status+"&qingdanid="+qingdanid+"&jd="+jd;

            },
            error:function(e){}
        });
    }

    function doSubmit() {
        var mainCount = <%=zcList.size()%>;
        var detailCount = <%=rowindex%>;

        var zps = [];

        for(var row = 0;row<mainCount;row++) {
            zps.push({
                zpId:$("#zpId_"+row).val(),
                zpsm:$("#zpsm_"+row).val()
            });
        }

        var details = [];

        var isBeak = false;

        for(var row = 0;row<detailCount;row++) {
            if(isNaN($("#zpf_"+row).val())) {
                alert("自评分必须为数字");
                isBeak=true;
                return false;
            }

            if(parseFloat($("#zpf_"+row).val()) > parseFloat($("#fz_"+row).html())) {
                alert("自评分必须小于分数上限");
                isBeak = true;
                return false;
            }

            details.push({
                detailId:$("#detailId_"+row).val(),
                zpf:$("#zpf_"+row).val()
            });
        }

        if(isBeak) {
            return false;
        }

        var obj = {"zps":zps,"details":details};

        var status = $("#statusSelect").val();
        var qingdanid = $("#qingdanSelect").val();
        var jd = $("#kpmonth").val();

        jQuery.ajax({
            type:"POST",
            url:"/service/common/submitZp",
            contentType: "application/json",
            data:JSON.stringify(obj),
            success:function(res){
                alert("提交成功");
                window.location.href="kpzcList.jsp?status=1&qingdanid="+qingdanid+"&jd="+jd;

            },
            error:function(e){}
        });
    }

    function doSearch() {
        var url = window.location.href;
        url = url.split("?")[0];
        var status = $("#statusSelect").val();
        var qingdanid = $("#qingdanSelect").val();
        var jd = $("#kpmonth").val();
        var view = <%=view%>;
        location.replace(url+"&status="+status);
        location.replace(url+"?status="+status+"&qingdanid="+qingdanid+"&jd="+jd+"&view="+view);
    }

</script>
</BODY>
</HTML>