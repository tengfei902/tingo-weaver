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
<jsp:useBean id="TrainResourceComInfo"
             class="weaver.hrm.train.TrainResourceComInfo" scope="page" />
<jsp:useBean id="TrainPlanComInfo"
             class="weaver.hrm.train.TrainPlanComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />

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

<BODY>
<%@ include file="/systeminfo/TopTitle.jsp"%>
<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
<%
    RCMenu += "{发布 ,javascript:publish(),_self} ";
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
                                            <font class="reqname">考评清单列表</font>
                                        </div>
                                        <table class="ViewForm maintable">
    <colgroup>
        <col width="10%"></col>
        <col width="40%"></col>
    </colgroup>
    <%

        out.print("");
    %>
</table></td>
</tr>
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
                    <COL width="65%">
                    <COL width="10%">
                    <COL width="10%">
                </colgroup>
                <tbody>
                <tr class="header detailtitle">
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9634" class="Label" name="label9634" value="选择"
                            disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9632" class="Label" name="label9634" value="考评清单"
                            disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9633" class="Label" name="label9634" value="是否可评分"
                            disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9635" class="Label" name="label9634" value="是否可自评"
                            disabled="true" /></td>
                </tr>
                </tbody>

                <%
                    int rowindex = 1;
                    while(RecordSet.next()) { %>
                <tr>
                    <td><input type='checkbox' id='qingdanId<%=rowindex %>' name='qingdanIdSelect') value='<%=RecordSet.getString("id")%>'></td>
                    <td><nobr><div style=width:50%  id='itemTitle<%=rowindex %>' name='itemTitle<%=rowindex %>' style='width=80%'><a href="itemList.jsp?qingdanId=<%=RecordSet.getString("id")%>"><%=RecordSet.getString("qingdanmc") %></a></div></td>
                    <%
                        String qingdanid = RecordSet.getString("id");
                        RecordSet rs1 = new RecordSet();
                        rs1.execute("select count(1) from t_item_dept_link where qingdanid="+qingdanid+" and kpmonth='"+new SimpleDateFormat("yyyyMM").format(new Date())+"'");
                        Integer rowCount = 0;
                        while(rs1.next()) {
                            rowCount = rs1.getInt(1);
                        }
                        if(rowCount==0) {
                    %>
                    <td>无明细</td>
                    <%
                    } else {
                        rs1.execute("select count(1) from t_item_dept_link where qingdanid="+qingdanid+" and kpmonth='"+new SimpleDateFormat("yyyyMM").format(new Date())+"' and isCanCheck='true'");
                        Integer canCheckCount = 0;
                        while(rs1.next()) {
                            canCheckCount = rs1.getInt(1);
                        }
                        if(canCheckCount>0) {

                    %>
                    <td><input type="button" value="停止评分" onclick="stopPingfen(<%=qingdanid%>)"> </td>
                    <%
                    }
                    else {

                    %>
                    <td>已停止评分</td>
                    <%}
                        rs1.execute("select count(1) from t_item_company_link where qingdanid="+qingdanid+" and kpmonth='"+new SimpleDateFormat("yyyyMM").format(new Date())+"' and isCanCheck='true'");
                        canCheckCount = 0;
                        while(rs1.next()) {
                            canCheckCount = rs1.getInt(1);
                        }
                        if(canCheckCount>0) {

                    %>
                    <td><input type="button" value="停止自评" onclick="stopZifen(<%=qingdanid%>)"> </td>
                    <%
                    }
                    else {
                    %>
                    <td>已停止自评</td>
                    <%}
                    }%>
                </tr>
                <%} %>
            </table>
        </td>
    </tr>
    </tbody>
</table> <script>
    jQuery(document).ready(function(){
        var userid=<%=userid%>;
        var deptId=<%=deptId%>;
        var kpMonth=<%=kpMonth%>;
        var rowindex1=0;

        //getYdkpItems();

        function getYdkpItems() {
            jQuery.ajax({
                type:"GET",
                url:"/service/common/getAllKpDx",
                cache:false,
                data:"userid="+userid+"&status=&companyids=&kpMonth="+kpMonth,
                success:function(res){
                    var json = eval("("+res+")");
                    if(json.flag == "-1"){
                        alert("数据查询错误");
                    }else{
                        jQuery.each(json,function(i){
                            addRow1();
                            var itemTitle = encodeURI(json[i].itemTitle,"UTF-8");
                            jQuery("#itemTitle_"+ rowindex1).html("<a href='itemList.jsp?itemTitle="+json[i].itemTitle+"'>"+json[i].itemTitle+"</a>");
                            jQuery("#itemTitle_input_"+ rowindex1).val(json[i].itemTitle);
                            jQuery("#kpMonth_"+ rowindex1).html(json[i].kpMonth);
                            jQuery("#kpMonth_input_"+ rowindex1).val(json[i].kpMonth);
                            jQuery("#khjg_"+ rowindex1).html(json[i].companyName);
                            jQuery("#kpxm_"+ rowindex1).html(json[i].itemType);

                            var khyf = parseInt(json[i].kpMonth);
                            var mbyf = khyf+1;
                            jQuery("#mbyf_input_"+rowindex1).val(mbyf);
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
            var itemtitle_input_id = "itemTitle_input_"+ rowindex1;
            var itemtitle_input_html="<input type='hidden' id='"+itemtitle_input_id+"'>";
            itemTitletd.append(itemtitle_input_html);
            row.append(itemTitletd);

            var kpMonthtd = jQuery("<td></td>");
            var kpMonthid = "kpMonth_"+ rowindex1;
            var kpMonthHtml = "<nobr><div style=width:50%  id='"+ kpMonthid+ "' name='"+ kpMonthid+ "' style='width=80%'>";
            kpMonthtd.append(kpMonthHtml);
            var kpMonthinputid = "kpMonth_input_"+ rowindex1;
            var kpMonthinputHtml = "<input type='hidden' id='"+kpMonthinputid+"'>";
            kpMonthtd.append(kpMonthinputHtml);
            row.append(kpMonthtd);

            //考评项目
            var khjgtd = jQuery("<td></td>");
            var khjgid = "khjg_"+ rowindex1;
            var khjgHtml = "<nobr><div style=width:50%  id='"+ khjgid+ "' name='"+ khjgid+ "' style='width=80%'>";
            khjgtd.append(khjgHtml);
            row.append(khjgtd);

            //考评项目
            var kpxmtd = jQuery("<td></td>");
            var kpxmid = "kpxm_"+ rowindex1;
            var kpxmHtml = "<nobr><div style=width:50%  id='"+ kpxmid+ "' name='"+ kpxmid+ "' style='width=80%'>";
            kpxmtd.append(kpxmHtml);
            row.append(kpxmtd);

            var mbyftd = jQuery("<td></td>");
            var mbyfid = "mbyf_"+ rowindex1;
            var mbyfHtml = "<input type='text' id='mbyf_input_"+rowindex1+"'>";
            mbyftd.append(mbyfHtml);
            row.append(mbyftd);

            var fftd = jQuery("<td></td>");
            var ffid = "ff_"+ rowindex1;
            var ffHtml = "<input type='button' value='发放' onclick=doPublish("+rowindex1+") id='ff_input_"+rowindex1+"'>";
            fftd.append(ffHtml);
            row.append(fftd);

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

    function onShowDepartment() {
        //2004-6-16 Edit by Evan :传sql参数给部门浏览页面
        url = encode("/hrm/company/MultiDepartmentBrowser.jsp?isedit=1&rightStr=HrmResourceAdd:Add&sqlwhere=&selectedids="+ jQuery("#departmentids").val());
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+ url);
        //2004-6-16 End Edit
        issame = false;
        if (data != null) {
            if (data.id != 0) {
                if (data.id == jQuery("#departmentids").val()) {
                    issame = true;
                }
                jQuery("#departmentspan").html(data.name);
                jQuery("#departmentids").val(data.id);
            } else {
                jQuery("#departmentspan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("#departmentids").val("");
            }
            if (issame == false) {
                jQuery("#jobtitlespan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=jobtitle]").val("");
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
        var itemid = $("#itemid_"+rowindex).val();
        window.location.href="addDjkpItem.jsp?itemId="+itemid;
    }

    function addNew() {
        window.location.href = "addDjkpItem.jsp";
    }

    var rowindex1 = 0;

    function doSearch() {
        $("#oTable1  tr").empty();
        var status = $("#statusSelect").val();
        var companyids = $("#checkedCompanyId").val();
        var kpMonth = $("#kpMonth").val();
        jQuery.ajax({
            type:"GET",
            url:"/service/common/getAllKpDx",
            cache:false,
            data:"userid="+userid+"&status="+status+"&companyids="+companyids+"&kpMonth="+kpMonth,
            success:function(res){
                var json = eval("("+res+")");
                if(json.flag == "-1"){
                    alert("数据查询错误");
                }else{
                    jQuery.each(json,function(i){
                        addRow1();
                        var itemTitle = encodeURI(json[i].itemTitle,"UTF-8");
                        jQuery("#itemTitle_"+ rowindex1).html("<a href='itemList.jsp?itemTitle="+json[i].itemTitle+"'>"+json[i].itemTitle+"</a>");
                        jQuery("#itemTitle_input_"+ rowindex1).val(json[i].itemTitle);
                        jQuery("#kpMonth_"+ rowindex1).html(json[i].kpMonth);
                        jQuery("#kpMonth_input_"+rowindex1).val(json[i].kpMonth);
                        jQuery("#khjg_"+ rowindex1).html(json[i].companyName);
                        jQuery("#kpxm_"+ rowindex1).html(json[i].itemType);
                        var khyf = parseInt(json[i].kpMonth);
                        var mbyf = khyf+1;
                        jQuery("#mbyf_input_"+rowindex1).val(mbyf);
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
        var itemtitle_input_id = "itemTitle_input_"+ rowindex1;
        var itemtitle_input_html="<input type='hidden' id='"+itemtitle_input_id+"'>";
        itemTitletd.append(itemtitle_input_html);
        row.append(itemTitletd);

        var kpMonthtd = jQuery("<td></td>");
        var kpMonthid = "kpMonth_"+ rowindex1;
        var kpMonthHtml = "<nobr><div style=width:50%  id='"+ kpMonthid+ "' name='"+ kpMonthid+ "' style='width=80%'>";
        kpMonthtd.append(kpMonthHtml);
        var kpMonthinputid = "kpMonth_input_"+ rowindex1;
        var kpMonthinputHtml = "<input type='hidden' id='"+kpMonthinputid+"'>";
        kpMonthtd.append(kpMonthinputHtml);
        row.append(kpMonthtd);

        //考评项目
        var khjgtd = jQuery("<td></td>");
        var khjgid = "khjg_"+ rowindex1;
        var khjgHtml = "<nobr><div style=width:50%  id='"+ khjgid+ "' name='"+ khjgid+ "' style='width=80%'>";
        khjgtd.append(khjgHtml);
        row.append(khjgtd);

        //考评项目
        var kpxmtd = jQuery("<td></td>");
        var kpxmid = "kpxm_"+ rowindex1;
        var kpxmHtml = "<nobr><div style=width:50%  id='"+ kpxmid+ "' name='"+ kpxmid+ "' style='width=80%'>";
        kpxmtd.append(kpxmHtml);
        row.append(kpxmtd);

        var mbyftd = jQuery("<td></td>");
        var mbyfid = "mbyf_"+ rowindex1;
        var mbyfHtml = "<input type='text' id='mbyf_input_"+rowindex1+"'>";
        mbyftd.append(mbyfHtml);
        row.append(mbyftd);

        var fftd = jQuery("<td></td>");
        var ffid = "ff_"+ rowindex1;
        var ffHtml = "<input type='button' value='发放' onclick='doPublish("+rowindex1+")' id='ff_input_"+rowindex1+"'>";
        fftd.append(ffHtml);
        row.append(fftd);

        table.append(row);
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

    function doPublish(rowindex) {
        var userid=<%=userid%>;
        var mbyf = $("#mbyf_input_"+rowindex).val();
        if(mbyf==null || isNaN(mbyf)) {
            alert("目标月份格式错误");
            return false;
        }
        var itemTitle = encodeURI($("#itemTitle_input_"+rowindex).val(),"UTF-8");
        if(itemTitle == null) {
            alert("清单不可为空");
            return false;
        }
        var oldkpMonth = jQuery("#kpMonth_input_"+rowindex).val();
        jQuery.ajax({
            type:"GET",
            url:"/service/common/doPublish",
            cache:false,
            data:"userid="+userid+"&itemTitle="+itemTitle+"&kpMonth="+mbyf+"&oldkpMonth="+oldkpMonth,
            success:function(res){
                alert(res);
            },
            error:function(e){}
        });
    }

    function publish() {
        var spCodesTemp = "";
        $('input:checkbox[name=qingdanIdSelect]:checked').each(function(i){
            if(0==i){
                spCodesTemp = $(this).val();
            }else{
                spCodesTemp += (","+$(this).val());
            }
        });
        if(spCodesTemp == "") {
            alert("请选择需要发布的清单");
            return false;
        }

        var checkedCompanyId = $("#checkedCompanyId").val();
        if(checkedCompanyId=="") {
            alert("请选择考核公司");
            return false;
        }

        var kpMonth = $("#kpMonth").val();
        if(kpMonth == "") {
            alert("考评月份不能为空");
            return false;
        }
        var userId = "<%=userid%>";

        alert(spCodesTemp);
        alert(checkedCompanyId);
        alert(kpMonth);

        //保存列表数据
        jQuery.ajax({
            type:"POST",
            url:"/service/common/doPublish2",
            cache:false,
            data:"userid="+userid+"&qingdanids="+spCodesTemp+"&companyids="+checkedCompanyId+"&kpMonth="+kpMonth,
            success:function(res){
                alert(res);
                window.location.href="itemList.jsp";
            },
            error:function(e){}
        });
    }

    function stopPingfen(qingdanId) {
        if(qingdanId == "") {
            alert("系统错误");
            return false;
        }
        jQuery.ajax({
            type:"GET",
            url:"/service/common/stopPingfen",
            cache:false,
            data:"qingdanid="+qingdanId,
            success:function(res){
                refreshPage();
            },
            error:function(e){}
        });

    }

    function stopZifen(qingdanId){
        if(qingdanId == "") {
            alert("系统错误");
            return false;
        }
        jQuery.ajax({
            type:"GET",
            url:"/service/common/stopZiping",
            cache:false,
            data:"qingdanid="+qingdanId,
            success:function(res){
                refreshPage();
            },
            error:function(e){}
        });
    }

    function refreshPage() {
        var url = window.location.href;
        url = url.split("?")[0];
        location.replace(url);
    }
</script>
</BODY>
</HTML>