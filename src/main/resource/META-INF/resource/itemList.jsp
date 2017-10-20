<%@page import="weaver.mobile.rest.gson.tingo.CheckItemDetailGson"%>
<%@page import="weaver.mobile.rest.gson.tingo.QingdanGson"%>
<%@page import="weaver.mobile.rest.gson.tingo.CheckItemGson"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="weaver.general.Util,java.util.*,java.math.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page language="java" contentType="text/html; charset=GBK"%>
<%@ include file="/systeminfo/init.jsp"%>

<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs2" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo"
             class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="TrainTypeComInfo"
             class="weaver.hrm.tools.TrainTypeComInfo" scope="page" />
<jsp:useBean id="TrainComInfo" class="weaver.hrm.train.TrainComInfo"
             scope="page" />
<jsp:useBean id="TrainPlanComInfo"
             class="weaver.hrm.train.TrainPlanComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="weaverClient" class="weaver.mobile.rest.common.WeaverClient" scope="page" />
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
            + SystemEnv.getHtmlLabelName(181518, user.getLanguage());
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

    String qingdanId = request.getParameter("qingdanId");
    List<CheckItemGson> list = weaverClient.getCheckItemList(StringUtils.isEmpty(qingdanId)?0:Integer.parseInt(qingdanId));
    QingdanGson qingdanGson = weaverClient.getQingdanById(Integer.parseInt(qingdanId));
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp"%>
<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
<%
    RCMenu += "{查询,javascript:doSearch(),_self} ";
    RCMenu += "{新增,javascript:addNew(),_self} ";
    RCMenuHeight += 2 * RCMenuHeightStep;
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
                                            <font class="reqname">党建考评项目列表</font>
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
        <TD class="fname">考评清单</TD>
        <TD class="fvalue" >
            <input type="text" id="itemTitle" value="<%=qingdanGson.getQingdanmc()%>">
        </TD>
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
    <tr>
        <td style="font-size: 0pt" height="15" colspan="2">&nbsp;</td>
    </tr>
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
                    <COL width="15%">
                    <COL width="10%">
                    <COL width="15%">
                    <COL width="5%">
                    <COL width="15%">
                    <COL width="5%">
                    <COL width="15%">
                    <COL width="5%">
                    <COL width="5%">
                </colgroup>
                <tbody>
                <tr class="header detailtitle">
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9632" class="Label" name="label9634" value="考评清单"
                            disabled="true" /></td>
                    <td class="detailtitle" align="center"><input
                            id="label9633" class="Label" name="label9635"
                            value="内容" disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9637" class="Label" name="label9637"
                            value="评分部门" disabled="true" style="width:100px;" /></td>
                    <td class="detailtitle" align="center"><input
                            id="label9633" class="Label" name="label9635"
                            value="条款细则" disabled="true" /></td>
                    <td class="detailtitle" align="center"><input
                            id="label9635" class="Label" name="label9635"
                            value="分值" disabled="true" style="width:40px;" /></td>
                    <td class="detailtitle" align="center"><input
                            id="label9636" class="Label" name="label9636"
                            value="评分标准" disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9645" class="Label" name="label9639"
                            value=" 编辑" disabled="true" style="width:60px;" /></td>
                </tr>
                </tbody>

                <%
                    int rowindex = 1;
                    for(CheckItemGson item:list) {

                        for(int detailCount = 0;detailCount<item.getDetails().size();detailCount++) {
                %>
                <tr>
                    <% if(detailCount == 0) { %>
                    <td rowspan="<%=item.getDetails().size()%>"><div id="itemTitle<%=rowindex %>" name="itemTitle<%=rowindex %>" style='width=80%'><%=item.getQd() %></div></td>
                    <td rowspan="<%=item.getDetails().size()%>"><div id="itemType<%=rowindex %>" name="itemType<%=rowindex %>" style='width=80%'><%=item.getKpnr() %></div></td>
                    <td rowspan="<%=item.getDetails().size()%>"><div id="pfbm<%=rowindex %>" name="pfbm<%=rowindex %>" style='width=80%'><%=item.getPfbm() %></div></td>
                    <input type="hidden" id="itemId<%=rowindex %>" value="<%=item.getItemId()%>">
                    <%}
                        CheckItemDetailGson detail = item.getDetails().get(detailCount);
                    %>
                    <td><div id="itemDesc<%=rowindex %>" name="itemDesc<%=rowindex %>" style='width=80%'><%=detail.getTkxz() %></div></td>
                    <td><div id="maxScore<%=rowindex %>" name="maxScore<%=rowindex %>" style='width=80%'><%=detail.getFs() %></div></td>
                    <td><div id="pfbz<%=rowindex %>" name="pfbz<%=rowindex %>" style='width=80%'><%=detail.getPfbz() %></div></td>

                    <% if(detailCount == 0) { %>
                    <td rowspan="<%=item.getDetails().size()%>"><input type='button' value='编辑' onclick='onCheck(<%=rowindex %>)' id='edit<%=rowindex %>' name='edit<%=rowindex %>' style='width=80%'></td>
                    <%} %>
                </tr>
                <%
                            rowindex++;
                        }
                    }
                %>
            </table>
        </td>
    </tr>
    </tbody>
</table>
<script>
    function addNew() {
        var id = <%=qingdanId%>;
        window.location.href = "addDjkpItem.jsp?qingdanId="+id;
    }
</script>
</BODY>
</HTML>