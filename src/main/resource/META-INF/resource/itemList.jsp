<%@page import="weaver.mobile.rest.gson.tingo.CheckItemDetailGson"%>
<%@page import="weaver.mobile.rest.gson.tingo.QingdanGson"%>
<%@page import="weaver.mobile.rest.gson.tingo.CheckItemGson"%>
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
    List<CheckItemGson> list = weaverClient.getCheckItemList(Integer.parseInt(qingdanId));
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
                            id="label9637" class="Label" name="label9637"
                            value="验收方式" disabled="true" style="width:100px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9637" class="Label" name="label9637"
                            value="评分部门" disabled="true" style="width:100px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9645" class="Label" name="label9639"
                            value="排序" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9645" class="Label" name="label9639"
                            value=" 编辑" disabled="true" style="width:60px;" /></td>
                </tr>
                </tbody>

                <%
                    int rowindex = 1;
                    for(CheckItemGson item:list) {
                %>
                <tr>
                    <td><div id="itemTitle<%=rowindex %>" name="itemTitle<%=rowindex %>" style='width=80%'><%=item.getQd() %></div></td>
                    <td rowspan="<%=item.getDetails().size() %>>"><div id="itemType<%=rowindex %>" name="itemType<%=rowindex %>" style='width=80%'><%=item.getKpnr() %></div></td>
                    <%

                        for(CheckItemDetailGson detail:item.getDetails()) {
                    %>
                    <td><div id="itemDesc<%=rowindex %>" name="itemDesc<%=rowindex %>" style='width=80%'><%=RecordSet.getString("itemDesc") %></div></td>
                    <td><div id="maxScore<%=rowindex %>" name="maxScore<%=rowindex %>" style='width=80%'><%=RecordSet.getString("maxScore") %></div></td>
                    <td><div id="pfbz<%=rowindex %>" name="pfbz<%=rowindex %>" style='width=80%'><%=RecordSet.getString("pfbz") %></div></td>
                    <td><div id="acceptType<%=rowindex %>" name="acceptType<%=rowindex %>" style='width=80%'><%=RecordSet.getString("acceptType") %></div></td>
                    <td><div id="pfbm<%=rowindex %>" name="pfbm<%=rowindex %>" style='width=80%'><%=deptnames %></div></td>
                    <td><div id="itemorder<%=rowindex %>" name="itemorder<%=rowindex %>" style='width=80%'><%=RecordSet.getString("itemorder") %></div></td>
                    <td><input type='button' value='编辑' onclick='onCheck(<%=rowindex %>)' id='edit<%=rowindex %>' name='edit<%=rowindex %>' style='width=80%'></td>
                    <input type="hidden" id="itemId<%=rowindex %>" value="<%=RecordSet.getString("id")%>">
                </tr>
                <%
                        }
                        rowindex++;
                    }
                %>
            </table>
        </td>
    </tr>
    </tbody>
</table> <script>
    jQuery(document).ready(function(){
        var userid=<%=userid%>;
        var deptId=<%=deptId%>;
        var kpMonth=<%=kpMonth%>;
        var itemTitle=encodeURI($("#itemTitle").val(),"UTF-8");
        var rowindex1=0;

        //getYdkpItems();

        function getYdkpItems() {
            jQuery.ajax({
                type:"GET",
                url:"/service/common/getAllCheckItems",
                data:"userid="+userid+"&status=&companyids=&kpMonth="+kpMonth+"&itemTitle="+itemTitle,
                success:function(res){
                    var json = eval("("+res+")");
                    if(json.flag == "-1"){
                        alert("数据查询错误");
                    }else{
                        jQuery.each(json,function(i){
                            addRow1();
                            jQuery("#itemid_"+ rowindex1).val(json[i].id);
                            jQuery("#itemTitle_"+ rowindex1).html(json[i].itemTitle);
                            jQuery("#kpMonth_"+ rowindex1).html(json[i].kpMonth);
                            jQuery("#khjg_"+ rowindex1).html(json[i].companyName);
                            jQuery("#khjg_input_"+ rowindex1).val(json[i].companyId);
                            jQuery("#khjg_input_"+ rowindex1).hide();
                            jQuery("#pfbm_"+ rowindex1).html(json[i].deptName);
                            jQuery("#kpxm_"+ rowindex1).html(json[i].itemType);
                            jQuery("#kpnr_"+ rowindex1).html(json[i].itemDesc);
                            var checkType = json[i].checkType;
                            if(checkType == "NO") {
                                jQuery("#fssx_"+ rowindex1).html("否决");
                            } else {
                                jQuery("#fssx_"+ rowindex1).html(json[i].maxScore);
                            }
                            jQuery("#ysfs_"+ rowindex1).html(json[i].acceptType);

                            $("#pfbz_select_"+rowindex1).append( "<option value=>其他</option>" );
                            $("#pfbz_input_"+rowindex1).hide();
                            rowindex1++;
                        });
                    }
                },
                error:function(e){}
            });
        }

        function addRow1() {
            var table = jQuery('#oTable1');
            var row = jQuery("<tr></tr>");
            //选择框
            var xztd = jQuery("<td></td>");
            var xzHtml = "<input type='checkbox' id='itemid_"+ rowindex1+"' name='itemid_"+rowindex1+"' onClick=unselectall("+ rowindex1+ ")>";
            xztd.append(xzHtml);
            row.append(xztd);

            var itemTitletd = jQuery("<td></td>");
            var itemTitleid = "itemTitle_"+ rowindex1;
            var itemTitleHtml = "<nobr><div style=width:50%  id='"+ itemTitleid+ "' name='"+ itemTitleid+ "' style='width=80%'>";
            itemTitletd.append(itemTitleHtml);
            row.append(itemTitletd);

            var kpMonthtd = jQuery("<td></td>");
            var kpMonthid = "kpMonth_"+ rowindex1;
            var kpMonthHtml = "<nobr><div style=width:50%  id='"+ kpMonthid+ "' name='"+ kpMonthid+ "' style='width=80%'>";
            kpMonthtd.append(kpMonthHtml);
            row.append(kpMonthtd);

            //考评项目
            var khjgtd = jQuery("<td></td>");
            var khjgid = "khjg_"+ rowindex1;
            var khjgHtml = "<nobr><div style=width:50%  id='"+ khjgid+ "' name='"+ khjgid+ "' style='width=80%'>";
            khjgtd.append(khjgHtml);

            var khjg_input_id = "khjg_input_"+rowindex1;
            var khjg_input_html = "<input id='"+ khjg_input_id+ "' name='"+ khjg_input_id+ "' style='width=80%'>";
            khjgtd.append(khjg_input_html);
            row.append(khjgtd);

            var pfbmtd = jQuery("<td></td>");
            var pfbmid = "pfbm_"+ rowindex1;
            var pfbmHtml = "<nobr><div style=width:50%  id='"+ pfbmid+ "' name='"+ pfbmid+ "' style='width=80%'>";
            pfbmtd.append(pfbmHtml);
            row.append(pfbmtd);
            //考评项目
            var kpxmtd = jQuery("<td></td>");
            var kpxmid = "kpxm_"+ rowindex1;
            var kpxmHtml = "<nobr><div style=width:50%  id='"+ kpxmid+ "' name='"+ kpxmid+ "' style='width=80%'>";
            kpxmtd.append(kpxmHtml);
            row.append(kpxmtd);

            //考评内容
            var kpnrtd = jQuery("<td></td>");
            var kpnrid = "kpnr_"+ rowindex1;
            var kpnrHtml = "<nobr><div id='"+ kpnrid+ "' name='"+ kpnrid+ "' style='width=80%'>";
            kpnrtd.append(kpnrHtml);
            row.append(kpnrtd);

            var fssxtd = jQuery("<td></td>");
            var fssxid = "fssx_"+ rowindex1;
            var fssxHtml = "<nobr><div id='"+ fssxid+ "' name='"+ fssxid+ "' style='width=80%'>";
            fssxtd.append(fssxHtml);
            row.append(fssxtd);

            var ysfstd = jQuery("<td></td>");
            var ysfsid = "ysfs_"+ rowindex1;
            var ysfsHtml = "<nobr><div id='"+ ysfsid+ "' name='"+ ysfsid+ "' style='width=80%'>";
            ysfstd.append(ysfsHtml);
            row.append(ysfstd);

            var qrkptd = jQuery("<td></td>");
            var qrkpid = "qrkp_"+ rowindex1;
            var qrkpHtml = "<nobr><div id='"+ qrkpid+ "' name='"+ qrkpid+ "' style='width=80%'>";
            qrkptd.append(qrkpHtml);
            var qrkp_input_id = "qrkp_input_"+ rowindex1;
            var qrkp_input_html = "<input type='button' value='编辑' onclick='onCheck("+rowindex1+")' id='"+ qrkp_input_id+ "' name='"+ qrkp_input_id+ "' style='width=80%'>";
            qrkptd.append(qrkp_input_html);
            row.append(qrkptd);

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

    function onCheck(rowindex) {
        var itemId = $("#itemId"+rowindex).val();
        window.location.href="addDjkpItem.jsp?itemId="+itemId;
    }

    function addNew() {
        var id = <%=qingdanId%>;
        window.location.href = "addDjkpItem.jsp?qingdanId="+id;
    }

    var rowindex1 = 0;

    function doSearch() {
        var url = window.location.href;
        url = url.split("?")[0];
        var itemTitle = $("#itemTitle").val();
        location.replace(url+"?itemTitle="+itemTitle);
    }

    function onShowCompany(){
        //2004-6-16 Edit by Evan :传sql参数给部门浏览页面
        url=encode("/hrm/company/MutiSubcompanyBrowser.jsp?selectedids=");
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+url);
        //2004-6-16 End Edit
        issame = false;
        if (data!=null){
            if (data.id != 0 ){
                if (data.id == jQuery("input[name=checkedCompanyId]").val()){
                    issame = true;
                }
                jQuery("#checkedCompanyspan").html(data.name);
                jQuery("input[name=checkedCompanyId]").val(data.id);
            }else{
                jQuery("#checkedCompanyspan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=checkedCompanyId]").val("");
            }
            if (issame == false){
                jQuery("#jobtitlespan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=jobtitle]").val("");
                //	costcenterspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
                //	resource.costcenterid.value=""
            }
        }
    }

</script>
</BODY>
</HTML>