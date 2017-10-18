<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="weaver.general.Util,java.util.*,java.math.*"%>
<%@ page import="com.tingo.weaver.model.gson.KpZcGson" %>
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
    String titlename = SystemEnv.getHtmlLabelName(179,
            user.getLanguage())
            + "-"
            + SystemEnv.getHtmlLabelName(6156, user.getLanguage());
    String needfav = "1";
    String needhelp = "";
    int userid = user.getUID();
    int deptId = user.getUserDepartment();
    String deptname = DepartmentComInfo.getDepartmentname(deptId+"");
    String username = user.getUsername();
    String resourceId = "";

    String id = "";
    String tmpvalue1 = "";
    String tmpname1 = "";
    String type1 = "1";
    int tmpcount1 = 1;

    Calendar c = Calendar.getInstance();
    int currentMonth = c.get(Calendar.MONTH) + 1;
    int jd = currentMonth/4+1;

    jd = Util.getIntValue(request.getParameter("kpmonth"), jd);

    String kpMonth = String.valueOf(jd);

    String status = request.getParameter("status");
    String qingdanId = request.getParameter("qingdanid");

    String params = "t1.zipingfs,t1.kpmonth,t1.companyid,t1.id, t1.status,t1.itemid,t1.zipingrequestid,t3.subcompanyname, t1.qingdanmc,t2.itemType,t2.maxScore,t2.itemdesc,t2.accepttype,t2.pfbz,t1.isCanCheck,t1.qingdanid";
    String tablename = "t_item_company_link t1,t_check_item t2,hrmsubcompany t3,t_company_user_link t4";
    String whereClause = "t1.itemid = t2.id and t1.companyid = t3.id and t4.companyid=t1.companyid";
    whereClause+= " and t4.userid="+userid;
    if(StringUtils.isNotBlank(kpMonth)) {
        whereClause+=" and t1.kpmonth='"+jd+"'";
    }
    if(StringUtils.isNotBlank(status)) {
        if("NEW".equals(status)) {
            whereClause += " and t1.status='NEW'";
        } else {
            whereClause += " and t1.status='SELF_CHECKED'";
        }

    }
    if(StringUtils.isNotBlank(qingdanId)){
        whereClause += " and t1.qingdanid="+qingdanId;
    }
    //String orderby = "t1.id desc";
    String orderby = "t2.qingdanid,t2.showOrder,t2.itemorder";
    System.out.println("----------------------------------==============select "+params+" from "+whereClause+" order by "+orderby);
    RecordSet.execute("select "+params+" from "+tablename+" where " +whereClause+" order by "+orderby);

    RecordSet qingdanRecordSet = new RecordSet();
    qingdanRecordSet.execute("select * from qingdan order by id");

    String userId = ;
    String jd;
    String status;
    String qdId;
    List<KpZcGson> list = weaverClient.getKpzcList(userId,jd,status,qdId);

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

        <TD class="fname">状态</TD>
        <TD class="fvalue">
            <select id="statusSelect">
                <option value="" <%if(StringUtils.isBlank(status)) {%>selected="selected"<%} %>>全部</option>
                <option value="NEW" <%if(StringUtils.equals("NEW", status)) {%> selected="selected" <%} %>>未自评</option>
                <option value="NOT_NEW" <%if(StringUtils.equals("SELF_CHECKED", status)) {%>selected="selected"<%} %>>已自评</option>
            </select>
        </TD>
    </tr>
    <tr>
        <TD class="fname">当前用户</TD>
        <TD class="fvalue"><%=username %></TD>
        <TD class="fname">考评月份</TD>

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
            <%while(qingdanRecordSet.next()) {
                boolean selected = false;
                String currentQingdanId = qingdanRecordSet.getString("id");
                System.out.println("qingdanId:"+currentQingdanId);
                if(StringUtils.equals(currentQingdanId, qingdanId)) {
                    selected = true;
                }
            %>
            <option id="selectQingdan<%=qingdanRecordSet.getString("id")%>" value="<%=qingdanRecordSet.getString("id")%>" <%if(selected) { %>selected="selected"<%} %>><%=qingdanRecordSet.getString("qingdanmc")%></option>
            <%} %>
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
                    <COL width="3%">
                    <COL width="10%">
                    <COL width="25%">
                    <COL width="25%">
                    <COL width="10%">
                    <COL width="10%">
                    <COL width="10%">
                    <COL width="5%">
                    <COL width="5%">
                    <COL width="5%">
                    <COL width="5%">
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
                            value="内容" disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9636" class="Label" name="label9636"
                            value="条款细则" disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9637" class="Label" name="label9637"
                            value="考评月份" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9637" class="Label" name="label9637"
                            value="分数上限" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9638" class="Label" name="label9638"
                            value="验收方式" disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9643" class="Label" name="label9639"
                            value="状态" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9644" class="Label" name="label9639"
                            value="自评分数" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9646" class="Label" name="label9639"
                            value="自评" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9645" class="Label" name="label9639"
                            value="资料" disabled="true" style="width:60px;" /></td>
                </tr>
                </tbody>
                <%
                    int rowindex = 0;
                    while(RecordSet.next()) {
                        String statusStr = RecordSet.getString("status");
                        boolean isZiping = false;
                        if("NEW".equals(statusStr)) {
                            statusStr = "未自评";
                        }else {
                            isZiping = true;
                            statusStr = "已自评";
                        }

                        String zipingfs = RecordSet.getString("zipingfs");

                        String zipingrequestid = RecordSet.getString("zipingrequestid");
                        System.out.println("requestid:"+zipingrequestid);
                        String biaoti = RecordSet.getString("itemDesc")+"-"+RecordSet.getString("subcompanyname")+"-"+RecordSet.getString("kpMonth");
                %>
                <tr>
                    <td>
                        <div id='xmnr_index' name='xmnr_index' style='width:80px;'>
                        </div>
                    </td>
                    <td>
                        <div id='tkxz_index' name='tkxz_index' style='width:80px;'>
                        </div>
                    </td>
                    <td>
                        <div id='fz_index' name='fz_index' style='width:80px;'>
                        </div>
                    </td>
                    <td>
                        <div id='pfbz_index' name='pfbz_index' style='width:80px;'>
                        </div>
                    </td>
                    <td>
                        <div id='kpjd_index' name='kpjd_index' style='width:80px;'>
                        </div>
                    </td>
                    <td>
                        <div id='zt_index' name='zt_index' style='width:80px;'>
                        </div>
                    </td>
                    <td>
                        <input type='text' id='zpf_index' name='zpf_index' value=''>
                    </td>
                    <td>
                        <input type='text' id='zpsm_index' name='zpsm_index' value=''>
                    </td>
                </tr>
                <%
                    rowindex++;
                } %>
            </table>
        </td>
    </tr>
    </tbody>
</table> <script>
    jQuery(document).ready(function() {
        var userid =<%=userid%>;
        var deptId =<%=deptId%>;
        var rowindex1 = 0;
        var status = $("#statusSelect").val();
        var kpMonth = <%=kpMonth%>;

        //getKPDXData();
        //getCheckItems();


        function getKPDXData() {
            jQuery.ajax({
                type:"GET",
                url:"/service/common/getSelfCheckItemTypes",
                cache:false,
                data:"userid=" + userid+"&status="+status,
                success:function(res) {
                    var json = eval("(" + res + ")");
                    if (json.flag == "-1") {
                        alert("数据查询错误");
                    } else {
                        jQuery.each(json,function(i) {
                            var id = json[i].id;
                            var itemType = json[i].itemType;
                            $("#khdx").append( "<option value="+id+">"+itemType+"</option>" );
                        });
                    }
                }
            });
        }

        function getCheckItems() {
            jQuery.ajax(
                    {
                        type : "GET",
                        url : "/service/common/getSelfCheckItems",
                        cache:false,
                        data : "userid=" + userid+"&status="+status+"&kpMonth="+kpMonth,
                        success : function(res) {
                            var json = eval("(" + res + ")");
                            //alert(res);
                            if (json.flag == "-1") {
                                alert("数据查询错误");
                            } else {
                                jQuery.each(json,function(i) {
                                    addRow1();
                                    jQuery("#itemid_"+ rowindex1).val(json[i].id);
                                    jQuery("#kpjg_"+ rowindex1).html(json[i].companyName);
                                    jQuery("#kpjg_input_"+ rowindex1).val(json[i].companyId);
                                    jQuery("#kpjg_input_"+ rowindex1).hide();
                                    jQuery("#kpxm_"+ rowindex1).html(json[i].itemType);
                                    jQuery("#kpxm_input_"+ rowindex1).val(json[i].itemType);
                                    jQuery("#kpxm_input_"+ rowindex1).hide();
                                    jQuery("#kpnr_"+ rowindex1).html(json[i].itemDesc);
                                    jQuery("#kpnr_input_"+ rowindex1).val(json[i].itemDesc);
                                    jQuery("#kpnr_input_"+ rowindex1).hide();
                                    jQuery("#fssx_"+ rowindex1).html(json[i].maxScore);
                                    jQuery("#fssx_input_"+ rowindex1).val(json[i].maxScore);
                                    jQuery("#fssx_input_"+ rowindex1).hide();
                                    jQuery("#ysfs_"+ rowindex1).html(json[i].acceptType);
                                    jQuery("#ysfs_input_"+ rowindex1).val(json[i].acceptType);
                                    jQuery("#ysfs_input_"+ rowindex1).hide();
                                    var status = json[i].companyStatus;
                                    var statusStr="";
                                    if(status == "NEW") {
                                        statusStr = "未自评";
                                    }
                                    if(status != "NEW") {
                                        statusStr = "已自评";
                                        $("#zp_input_"+rowindex1).attr({"disabled":"disabled"});
                                    }
                                    jQuery("#zt_"+ rowindex1).html(statusStr);
                                    jQuery("#zt_input_"+ rowindex1).val(statusStr);
                                    jQuery("#zt_input_"+ rowindex1).hide();
                                    rowindex1++;
                                });
                            }
                        },
                        error : function(
                                e) {
                        }
                    });
        }

        function addRow1() {
            var table = jQuery('#oTable1');
            var row = jQuery("<tr></tr>");
            //选择框
            var xztd = jQuery("<td></td>");
            var xzHtml = "<input type='checkbox' id='itemid_"+ rowindex1+ "' name='itemid_"+ rowindex1+ "' onClick=unselectall("+ rowindex1+ ")>";
            xztd.append(xzHtml);
            row.append(xztd);

            //考评公司
            var kpjgtd = jQuery("<td></td>");
            var kpjgid = "kpjg_"+ rowindex1;
            var kpjgHtml = "<div  id='"+ kpjgid+ "' name='"+ kpjgid+ "' style='width=80%'>";
            kpjgtd.append(kpjgHtml);
            var kpjg_input_id = "kpjg_input_"+ rowindex1;
            var kpjg_input_html = "<nobr><input id='"+ kpjg_input_id+ "' name='"+ kpjg_input_id+ "' style='width=80%'>";
            kpjgtd.append(kpjg_input_html)
            row.append(kpjgtd);

            //考评项目
            var kpxmtd = jQuery("<td></td>");
            var kpxmid = "kpxm_"+ rowindex1;
            var kpxmHtml = "<div  id='"+ kpxmid+ "' name='"+ kpxmid+ "' style='width=80%'>";
            kpxmtd.append(kpxmHtml);
            var kpxm_input_id = "kpxm_input_"+ rowindex1;
            var kpxm_input_html = "<input id='"+ kpxm_input_id+ "' name='"+ kpxm_input_id+ "' style='width=80%'>";
            kpxmtd.append(kpxm_input_html)
            row.append(kpxmtd);

            //考评内容
            var kpnrtd = jQuery("<td></td>");
            var kpnrid = "kpnr_"+ rowindex1;
            var kpnrHtml = "<div id='"+ kpnrid+ "' name='"+ kpnrid+ "' style='width=80%'>";
            kpnrtd.append(kpnrHtml);
            var kpnr_input_id = "kpnr_input_"+ rowindex1;
            var kpnr_input_html = "<input id='"+ kpnr_input_id+ "' name='"+ kpnr_input_id+ "' style='width=80%'>";
            kpnrtd.append(kpnr_input_html);
            row.append(kpnrtd);

            var fssxtd = jQuery("<td></td>");
            var fssxid = "fssx_"+ rowindex1;
            var fssxHtml = "<div id='"+ fssxid+ "' name='"+ fssxid+ "' style='width=80%'>";
            fssxtd.append(fssxHtml);
            var fssx_input_id = "fssx_input_"+ rowindex1;
            var fssx_input_html = "<nobr><input id='"+ fssx_input_id+ "' name='"+ fssx_input_id+ "' style='width=80%'>";
            fssxtd.append(fssx_input_html);
            row.append(fssxtd);

            var ysfstd = jQuery("<td></td>");
            var ysfsid = "ysfs_"+ rowindex1;
            var ysfsHtml = "<div id='"+ ysfsid+ "' name='"+ ysfsid+ "' style='width=80%'>";
            ysfstd.append(ysfsHtml);
            var ysfs_input_id = "ysfs_input_"+ rowindex1;
            var ysfs_input_html = "<input id='"+ ysfs_input_id+ "' name='"+ ysfs_input_id+ "' style='width=80%'>";
            ysfstd.append(ysfs_input_html);
            row.append(ysfstd);

            var zttd = jQuery("<td></td>");
            var ztid = "zt_"+ rowindex1;
            var ztHtml = "<div id='"+ ztid+ "' name='"+ ztid+ "' style='width=80%'>";
            zttd.append(ztHtml);
            var zt_input_id = "zt_input_"+ rowindex1;
            var zt_input_html = "<input id='"+ zt_input_id+ "' name='"+ zt_input_id+ "' style='width=80%'>";
            zttd.append(zt_input_html);
            row.append(zttd);

            var zptd = jQuery("<td></td>");
            var zpid = "zp_"+ rowindex1;
            var zpHtml = "<div id='"+ zpid+ "' name='"+ zpid+ "' style='width=80%'>";
            zptd.append(zpHtml);
            var zp_input_id = "zp_input_"+ rowindex1;
            var zp_input_html = "<input type='button' value='点击自评' id='"+ zp_input_id+ "' name='"+ zp_input_id+ "' style='width=80%' onclick=doZp("+rowindex1+")>";
            zptd.append(zp_input_html);
            row.append(zptd);

            table.append(row);
        }
    });

    function onShowBrowser2(id, url, type1,
                            tmpindex) {
        var tmpids = "";
        var id1 = null;
        if (type1 == 8) {
            tmpids = $G("con" + id + "_value").value;
            id1 = window.showModalDialog(url
                    + "?projectids=" + tmpids);
        } else if (type1 == 9) {
            tmpids = $G("con" + id + "_value").value;
            id1 = window.showModalDialog(url
                    + "?documentids=" + tmpids);
        } else if (type1 == 1) {
            tmpids = $G("con" + id + "_value").value;
            id1 = window.showModalDialog(url
                    + "?resourceids=" + tmpids);
        } else if (type1 == 4) {
            tmpids = $G("con" + id + "_value").value;
            id1 = window.showModalDialog(url
                    + "?selectedids=" + tmpids
                    + "&resourceids=" + tmpids);
        } else if (type1 == 16) {
            tmpids = $G("con" + id + "_value").value;
            id1 = window.showModalDialog(url
                    + "?resourceids=" + tmpids);
        } else if (type1 == 7) {
            tmpids = $G("con" + id + "_value").value;
            id1 = window.showModalDialog(url
                    + "?resourceids=" + tmpids);
        } else if (type1 == 142) {
            tmpids = $G("con" + id + "_value").value;
            id1 = window.showModalDialog(url
                    + "?receiveUnitIds=" + tmpids);
        }
        //id1 = window.showModalDialog(url)
        if (id1 != null) {
            resourceids = wuiUtil
                    .getJsonValueByIndex(id1, 0);
            resourcename = wuiUtil
                    .getJsonValueByIndex(id1, 1);
            if (wuiUtil.getJsonValueByIndex(id1, 0) != "") {
                resourceids = resourceids.substr(1);
                resourcename = resourcename
                        .substr(1);
                $G("con" + id + "_valuespan").innerHTML = resourcename;
                jQuery(
                        "input[name=con" + id
                        + "_value]").val(
                        resourceids);
                jQuery(
                        "input[name=con" + id
                        + "_name]").val(
                        resourcename);
            } else {
                $G("con" + id + "_valuespan").innerHTML = "";
                $G("con" + id + "_value").value = "";
                $G("con" + id + "_name").value = "";
            }
        }
        if ($G("con" + id + "_value").value == "") {
            document.getElementsByName("check_con")[tmpindex * 1].checked = false;
        } else {
            document.getElementsByName("check_con")[tmpindex * 1].checked = true;
        }
    }

    function dosave() {
        if (!docheck()) {
            return false;
        }
    }

    function cancelRowData(id, row) {
        jQuery("#kpxm_" + row).show();
        jQuery("#kpxm_input_" + row).hide();
        jQuery("#kpnr_" + row).show();
        jQuery("#kpnr_input_" + row).hide();
        jQuery("#xmsm_" + row).show();
        jQuery("#xmsm_input_" + row).hide();
        jQuery("#kpfs_" + row).show();
        jQuery("#kpfs_input_" + row).hide();
        jQuery("#fssx_" + row).show();
        jQuery("#fssx_input_" + row).hide();
        jQuery("#kslb_" + row).show();
        jQuery("#kslb_input_" + row).hide();
        jQuery("#xssx_" + row).show();
        jQuery("#xssx_input_" + row).hide();
        jQuery("#updateRow_" + row).show();
        jQuery("#saveRow_" + row).hide();
        jQuery("#cancelRow_" + row).hide();
        jQuery("#departmentspan_" + row).hide();
        jQuery("#kpfenshu_input_" + row).hide();
        jQuery("#kpfenshu_" + row).show();
    }

    function updateRowData(id, row) {
        jQuery("#kpxm_" + row).hide();
        jQuery("#kpxm_input_" + row).show();
        jQuery("#kpnr_" + row).hide();
        jQuery("#kpnr_input_" + row).show();
        jQuery("#xmsm_" + row).hide();
        jQuery("#xmsm_input_" + row).show();
        jQuery("#kpfs_" + row).hide();
        jQuery("#kpfs_input_" + row).show();
        jQuery("#fssx_" + row).hide();
        jQuery("#fssx_input_" + row).show();
        jQuery("#kslb_" + row).hide();
        jQuery("#kslb_input_" + row).show();
        jQuery("#xssx_" + row).hide();
        jQuery("#xssx_input_" + row).show();
        jQuery("#updateRow_" + row).hide();
        jQuery("#saveRow_" + row).show();
        jQuery("#cancelRow_" + row).show();
        jQuery("#departmentspan_" + row).show();
        jQuery("#kpfenshu_input_" + row).show();
        jQuery("#kpfenshu_" + row).hide();
        changeKpfs(row);
    }

    function saveRowData(id, row) {
        jQuery("#kpxm_" + row).show();
        jQuery("#kpxm_input_" + row).hide();
        jQuery("#kpnr_" + row).show();
        jQuery("#kpnr_input_" + row).hide();
        jQuery("#xmsm_" + row).show();
        jQuery("#xmsm_input_" + row).hide();
        jQuery("#kpfs_" + row).show();
        jQuery("#kpfs_input_" + row).hide();
        jQuery("#fssx_" + row).show();
        jQuery("#fssx_input_" + row).hide();
        jQuery("#kslb_" + row).show();
        jQuery("#kslb_input_" + row).hide();
        jQuery("#xssx_" + row).show();
        jQuery("#xssx_input_" + row).hide();
        jQuery("#updateRow_" + row).show();
        jQuery("#saveRow_" + row).hide();
        jQuery("#departmentspan_" + row).hide();
        jQuery("#kpfenshu_input_" + row).hide();
        jQuery("#kpfenshu_" + row).show();

        var kpxm = jQuery("#kpxm_input_" + row)
                .val();
        var kpnr = jQuery("#kpnr_input_" + row)
                .val();
        var xmsm = jQuery("#xmsm_input_" + row)
                .val();
        var kpfs = jQuery("#kpfs_input_" + row)
                .val();
        var fssx = jQuery("#fssx_input_" + row)
                .val();
        var kslb = jQuery("#kslb_input_" + row)
                .val();
        var xssx = jQuery("#xssx_input_" + row)
                .val();
        var kpfenshu = jQuery(
                "#kpfenshu_input_" + row).val();

        if (parseFloat(kpfenshu) > parseFloat(fssx)) {
            alert("考评分数不能大于分数上限");
            var kpfenshu_o = jQuery(
                    "#kpfenshu_" + row).html();
            jQuery("#kpfenshu_input_" + row).val(
                    kpfenshu_o);
            updateRowData(id, row);
            return false;
        }
        jQuery
                .ajax({
                    type : "POST",
                    url : "ydkpOperation.jsp",
                    data : "id=" + id + "&kpxm="
                    + kpxm + "&kpfs="
                    + kpfs + "&maxValue="
                    + fssx
                    + "&departmentid="
                    + kslb + "&xssx="
                    + xssx + "&kpnr="
                    + kpnr + "&xmsm="
                    + xmsm + "&kpfenshu="
                    + kpfenshu,
                    success : function(res) {
                        alert("保存成功");
                        window.location.href = "ydkpList1.jsp";
                    },
                    error : function(e) {
                    }
                });
    }

    function onShowDepartment(row) {
        //2004-6-16 Edit by Evan :传sql参数给部门浏览页面
        url = encode("/hrm/company/MultiDepartmentBrowser.jsp?isedit=1&rightStr=HrmResourceAdd:Add&sqlwhere=&selectedids="
                + jQuery("#departmentid_" + row)
                        .val());
        data = window
                .showModalDialog("/systeminfo/BrowserMain.jsp?url="
                        + url);
        //2004-6-16 End Edit
        issame = false;
        if (data != null) {
            if (data.id != 0) {
                if (data.id == jQuery(
                                "#departmentid_" + row)
                                .val()) {
                    issame = true;
                }
                jQuery("#departmentspan_" + row)
                        .html(data.name);
                jQuery("#departmentid_" + row).val(
                        data.id);
            } else {
                jQuery("#departmentspan_" + row)
                        .html(
                                "<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("#departmentid_" + row).val(
                        "");
            }
            if (issame == false) {
                jQuery("#jobtitlespan")
                        .html(
                                "<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=jobtitle]").val(
                        "");
                //	costcenterspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
                //	resource.costcenterid.value=""
            }
        }
    }

    function encode(str) {
        return escape(str);
    }

    function changeKpfs(row) {
        var kpfs = $(
                "#kpfs_input_" + row
                + " option:selected").val();
        if (kpfs == 2) {
            $("#fssx_input_" + row).hide();
            $("#fssx_" + row).show();
            $("#kpfenshu_input_" + row).hide();
            $("#kpfenshu_" + row).show();
        } else {
            $("#fssx_input_" + row).show();
            $("#fssx_" + row).hide();
            $("#kpfenshu_input_" + row).show();
            $("#kpfenshu_" + row).hide();
        }
    }

    function docheck() {

    }

    function addNew() {
        window.location.href = "ydkpItemAdd.jsp";
    }

    var userid =<%=userid%>;
    var deptId =<%=deptId%>;
    var rowindex1 = 0;


    function doSearch() {
        var url = window.location.href;
        url = url.split("?")[0];
        var status = $("#statusSelect").val();
        var qingdanid = $("#qingdanSelect").val();
        var jd = $("#kpmonth").val();
        location.replace(url+"&status="+status);
        location.replace(url+"?status="+status+"&qingdanid="+qingdanid+"&kpmonth="+jd);
    }

    function getCheckItems() {
        var status = $("#statusSelect").val();
        var kpMonth = <%=kpMonth%>;
        jQuery.ajax(
                {
                    type : "GET",
                    url : "/service/common/getSelfCheckItems",
                    data : "userid=" + userid+"&status="+status+"&kpMonth="+kpMonth,
                    success : function(res) {
                        var json = eval("(" + res + ")");
                        //alert(res);
                        if (json.flag == "-1") {
                            alert("数据查询错误");
                        } else {
                            jQuery.each(json,function(i) {
                                addRow1();
                                jQuery("#kpjg_"+ rowindex1).html(json[i].companyName);
                                jQuery("#kpjg_input_"+ rowindex1).val(json[i].companyId);
                                jQuery("#kpjg_input_"+ rowindex1).hide();
                                jQuery("#itemid_"+ rowindex1).val(json[i].id);
                                jQuery("#kpxm_"+ rowindex1).html(json[i].itemType);
                                jQuery("#kpxm_input_"+ rowindex1).val(json[i].itemType);
                                jQuery("#kpxm_input_"+ rowindex1).hide();
                                jQuery("#kpnr_"+ rowindex1).html(json[i].itemDesc);
                                jQuery("#kpnr_input_"+ rowindex1).val(json[i].itemDesc);
                                jQuery("#kpnr_input_"+ rowindex1).hide();
                                jQuery("#fssx_"+ rowindex1).html(json[i].maxScore);
                                jQuery("#fssx_input_"+ rowindex1).val(json[i].maxScore);
                                jQuery("#fssx_input_"+ rowindex1).hide();
                                jQuery("#ysfs_"+ rowindex1).html(json[i].acceptType);
                                jQuery("#ysfs_input_"+ rowindex1).val(json[i].acceptType);
                                jQuery("#ysfs_input_"+ rowindex1).hide();
                                var status = json[i].companyStatus;
                                var statusStr="";
                                if(status == "NEW") {
                                    statusStr = "未自评";
                                }
                                if(status != "NEW") {
                                    statusStr = "已自评";
                                    $("#zp_input_"+rowindex1).attr({"disabled":"disabled"});
                                }

                                jQuery("#zt_"+ rowindex1).html(statusStr);
                                jQuery("#zt_input_"+ rowindex1).val(statusStr);
                                jQuery("#zt_input_"+ rowindex1).hide();
                                rowindex1++;
                            });
                        }
                    },
                    error : function(
                            e) {
                    }
                });
    }

    function addRow1() {
        var table = jQuery('#oTable1');
        var row = jQuery("<tr></tr>");
        //选择框
        var xztd = jQuery("<td></td>");
        var xzHtml = "<input type='checkbox' id='itemid_"+rowindex1+"' name='itemid_"+ rowindex1+ "' onClick=unselectall("+ rowindex1+ ")>";
        xztd.append(xzHtml);
        row.append(xztd);

        //考评公司
        var kpjgtd = jQuery("<td></td>");
        var kpjgid = "kpjg_"+ rowindex1;
        var kpjgHtml = "<nobr><div style=width:50%  id='"+ kpjgid+ "' name='"+ kpjgid+ "' style='width=80%'>";
        kpjgtd.append(kpjgHtml);
        var kpjg_input_id = "kpjg_input_"+ rowindex1;
        var kpjg_input_html = "<nobr><input id='"+ kpjg_input_id+ "' name='"+ kpjg_input_id+ "' style='width=80%'>";
        kpjgtd.append(kpjg_input_html)
        row.append(kpjgtd);

        //考评项目
        var kpxmtd = jQuery("<td></td>");
        var kpxmid = "kpxm_"+ rowindex1;
        var kpxmHtml = "<nobr><div style=width:50%  id='"+ kpxmid+ "' name='"+ kpxmid+ "' style='width=80%'>";
        kpxmtd.append(kpxmHtml);
        var kpxm_input_id = "kpxm_input_"+ rowindex1;
        var kpxm_input_html = "<nobr><input id='"+ kpxm_input_id+ "' name='"+ kpxm_input_id+ "' style='width=80%'>";
        kpxmtd.append(kpxm_input_html)
        row.append(kpxmtd);

        //考评内容
        var kpnrtd = jQuery("<td></td>");
        var kpnrid = "kpnr_"+ rowindex1;
        var kpnrHtml = "<nobr><div id='"+ kpnrid+ "' name='"+ kpnrid+ "' style='width=80%'>";
        kpnrtd.append(kpnrHtml);
        var kpnr_input_id = "kpnr_input_"+ rowindex1;
        var kpnr_input_html = "<input id='"+ kpnr_input_id+ "' name='"+ kpnr_input_id+ "' style='width=80%'>";
        kpnrtd.append(kpnr_input_html);
        row.append(kpnrtd);

        var fssxtd = jQuery("<td></td>");
        var fssxid = "fssx_"+ rowindex1;
        var fssxHtml = "<nobr><div id='"+ fssxid+ "' name='"+ fssxid+ "' style='width=80%'>";
        fssxtd.append(fssxHtml);
        var fssx_input_id = "fssx_input_"+ rowindex1;
        var fssx_input_html = "<nobr><input id='"+ fssx_input_id+ "' name='"+ fssx_input_id+ "' style='width=80%'>";
        fssxtd.append(fssx_input_html);
        row.append(fssxtd);

        var ysfstd = jQuery("<td></td>");
        var ysfsid = "ysfs_"+ rowindex1;
        var ysfsHtml = "<nobr><div id='"+ ysfsid+ "' name='"+ ysfsid+ "' style='width=80%'>";
        ysfstd.append(ysfsHtml);
        var ysfs_input_id = "ysfs_input_"+ rowindex1;
        var ysfs_input_html = "<input id='"+ ysfs_input_id+ "' name='"+ ysfs_input_id+ "' style='width=80%'>";
        ysfstd.append(ysfs_input_html);
        row.append(ysfstd);

        var zttd = jQuery("<td></td>");
        var ztid = "zt_"+ rowindex1;
        var ztHtml = "<nobr><div id='"+ ztid+ "' name='"+ ztid+ "' style='width=80%'>";
        zttd.append(ztHtml);
        var zt_input_id = "zt_input_"+ rowindex1;
        var zt_input_html = "<input id='"+ zt_input_id+ "' name='"+ zt_input_id+ "' style='width=80%'>";
        zttd.append(zt_input_html);
        row.append(zttd);

        var zptd = jQuery("<td></td>");
        var zpid = "zp_"+ rowindex1;
        var zpHtml = "<nobr><div id='"+ zpid+ "' name='"+ zpid+ "' style='width=80%'>";
        zptd.append(zpHtml);
        var zp_input_id = "zp_input_"+ rowindex1;
        var zp_input_html = "<input type='button' value='点击自评' id='"+ zp_input_id+ "' name='"+ zp_input_id+ "' style='width=80%' onclick=doZp("+rowindex1+")>";
        zptd.append(zp_input_html);
        row.append(zptd);

        table.append(row);
    }

    function doZp(rowindex) {
        var itemCompanyId = $("#itemCompanyId"+rowindex).val();
        var userid = "<%=userid%>";
        var companyid = $("#companyid"+rowindex).val();
        var itemid = $("#itemId"+rowindex).val();
        var kpMonth = $("#kpMonth"+rowindex).html();
        var zipingfsinput = $("#zipingfsinput"+rowindex).val();
        if(zipingfsinput == "" || isNaN(zipingfsinput)) {
            alert("考评分数不能为空且必须为数字");
            return false;
        }
        var maxscore = $("#maxScore"+rowindex).html();
        if(parseFloat(maxscore) < parseFloat(zipingfsinput)) {
            alert("自评分数必须小于分数上限");
            return false;
        }
        //var url = "http://188.1.100.166/workflow/request/AddRequest.jsp?workflowid=1601&isagent=0&beagenter=0&kpItemId="+itemId+"&kpCompanyId="+companyId;
        jQuery.ajax({
            type:"GET",
            url:"/service/common/doZp",
            cache:false,
            data:"userid=" + userid+"&fs="+zipingfsinput+"&itemCompanyId="+itemCompanyId+"&companyid="+companyid+"&itemid="+itemid+"&kpMonth="+kpMonth,
            success:function(res) {
                alert("自评成功");
                doSearch();
            }
        });
    }

</script>
</BODY>
</HTML>