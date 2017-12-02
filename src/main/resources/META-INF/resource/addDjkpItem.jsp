<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=GBK" %> <%@ include file="/systeminfo/init.jsp" %>
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />

<%!
    //2004-6-16 Edit by Evan:得到user的级别，总部的user可以看到所有部门，分部和部门级的user只能看到所属的部门
    private String getDepartmentSql(User user){
        String sql ="";
        String rightLevel = HrmUserVarify.getRightLevel("HrmResourceEdit:Edit",user);
        int departmentID = user.getUserDepartment();
        int subcompanyID = user.getUserSubCompany1();
        if(rightLevel.equals("2") ){
            //总部级别的，什么也不返回
        }else if (rightLevel.equals("1")){ //分部级别的
            sql = " WHERE subcompanyid1="+subcompanyID ;
        }else if (rightLevel.equals("0")){ //部门级别
            sql = " WHERE id="+departmentID ;
        }
        //System.out.println("sql = "+sql);
        return sql;
    }
//End Edit
%>



<HTML><HEAD>
    <STYLE>.SectionHeader {
        FONT-WEIGHT: bold; COLOR: white; BACKGROUND-COLOR: teal
    }
    </STYLE>
    <LINK href="/css/Weaver.css" type=text/css rel=STYLESHEET>
    <SCRIPT language="javascript" src="/js/weaver.js"></script>
    <SCRIPT language="javascript">
        function showAlert(msg){
            alert(msg);
        }
        function showConfirm(msg){
            return confirm(msg);
        }
        function checkPass(){
            saveBtn.disabled = true;
            document.resource.submit() ;
        }
    </script>
    <SCRIPT language="javascript" src="/js/chechinput.js"></script>
</HEAD>
<%

    int msgid = Util.getIntValue(request.getParameter("msgid"),-1);

    String imagefilename = "/images/hdMaintenance.gif";
    String titlename = SystemEnv.getHtmlLabelName(181511,user.getLanguage())+": "+ SystemEnv.getHtmlLabelName(181513,user.getLanguage());
    String needfav ="1";
    String needhelp ="";
    boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
    String ifinfo = Util.null2String(request.getParameter("ifinfo"));//检查loginid参数

    String itemId = Util.null2String(request.getParameter("itemId"));
//根据id获取参数
    if(StringUtils.isNotBlank(itemId)) {
        String sql = "select * from t_check_item where id=" + itemId;
        rs.execute(sql);
        rs.next();
    }

    String kpMonth = new SimpleDateFormat("yyyyMM").format(new Date());

    RecordSet qingdanRecordSet = new RecordSet();
    qingdanRecordSet.execute("select * from qingdan order by id");

%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp" %>
<%@ include file="/systeminfo/RightClickMenuConent.jsp" %>
<%
    RCMenu += "{保存,javascript:doSave(this),_TOP} " ;
    RCMenu += "{删除,javascript:doDel(),_Self}";
    RCMenuHeight += RCMenuHeightStep ;
%>
<%@ include file="/systeminfo/RightClickMenu.jsp" %>
<iframe id="checkHas" src="" style="display:none"></iframe>
<table width=100% height=100% border="0" cellspacing="0" cellpadding="0">
    <colgroup>
        <col width="10">
        <col width="">
        <col width="10">
        <tr style="height:0px">
            <td height="0" colspan="3"></td>
        </tr>
        <tr>
            <td ></td>
            <td valign="top">
                <TABLE class=Shadow>
                    <tr>
                        <td valign="top">
                                <%
/*登录名冲突*/
if(msgid!=-1){
%>
                            <DIV>
                                <font color=red size=2>
                                    <%=SystemEnv.getErrorMsgName(msgid,user.getLanguage())%>
                                </font>
                            </DIV>
                                <%}%>
                                <%
      if(ifinfo.equals("y")){
      %>
                            <DIV>
                                <font color=red size=2>
                                        <%=SystemEnv.getHtmlLabelName(25170,user.getLanguage())%>
                            </div>
                                <%}%>
                            <FORM name=resource id=resource action="ydkpOperation.jsp" method=post>
                                <input class=inputstyle type=hidden name=operation value="addresourcebasicinfo">
                                <TABLE class=ViewForm>
                                    <TBODY>
                                    <TR>
                                        <TD vAlign=top>
                                            <TABLE width=100%>
    <COLGROUP>
        <COL width=30%>
        <COL width=70%>
    <TBODY>
    <TR class=Title>
        <TH colSpan=2><%=SystemEnv.getHtmlLabelName(1361,user.getLanguage())%></TH>
    </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
    <TR class=Spacing style="height:2px">
        <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR>
        <TD>考评清单</TD>
        <TD class=Field>
            <select id="qingdanSelect">
                <%while(qingdanRecordSet.next()) {
                    boolean selected = false;
                    String currentQingdanId = qingdanRecordSet.getString("id");
                    System.out.println("qingdanId:"+currentQingdanId);
                    if(StringUtils.isNotBlank(itemId)) {
                        String qingdanId = rs.getString("qingdanId");
                        if(StringUtils.equals(currentQingdanId, qingdanId)) {
                            selected = true;
                        }
                    }
                %>
                <option id="selectQingdan<%=qingdanRecordSet.getString("id")%>" value="<%=qingdanRecordSet.getString("id")%>" <%if(selected) { %>selected="selected"<%} %>><%=qingdanRecordSet.getString("qingdanmc")%></option>
                <%} %>
            </select>
        </TD>
    </TR>
    <TR class=Spacing style="height:2px">
        <TD class=Line1 colSpan=2></TD>
    </TR>
    <TR>
        <TD>考评内容</TD>
        <TD class=Field>
            <INPUT class=InputStyle maxLength=100 size=100 id="itemType" name="itemType" onchange="this.value=trim(this.value)" value="<%=StringUtils.isBlank(itemId)?"":rs.getString("itemtype") %>">
        </TD>
    </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
    <TR>
        <TD>考评方式</TD>
        <TD class=Field>
            <select class=InputStyle id="checkType" name="checkType" onchange="changeKpfs()">
                <option value="ADD" <%if(StringUtils.isNotBlank(itemId) && StringUtils.equals(rs.getString("checktype"), "ADD")){ %>selected<%} %>>加分</option>
                <option value="MINUS" <%if(StringUtils.isNotBlank(itemId) && StringUtils.equals(rs.getString("checktype"), "MINUS")){ %>selected<%} %>>减分</option>
                <option value="NO" <%if(StringUtils.isNotBlank(itemId) && StringUtils.equals(rs.getString("checktype"), "NO")){ %>selected<%} %>>一票否决</option>
            </select>
        </TD>
    </TR>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>
    <TR>
        <TD class="fname">评分部门</TD>
        <TD class="Field" >
            <%
                String deptnames = "";
                String departmentid = "";
                if(StringUtils.isNotBlank(itemId)) {
                    departmentid = rs.getString("pfbm");
                    if(StringUtils.isNotBlank(departmentid)) {
                        for(String deptid:departmentid.split(",")) {
                            if(StringUtils.isBlank(deptid)) {
                                continue;
                            }
                            deptnames += DepartmentComInfo.getDepartmentname(deptid)+",";
                        }
                        deptnames = deptnames.substring(0,deptnames.length()-1);
                    }
                }
            %>
            <BUTTON class=Browser type="button" id="checkDept" onclick="onShowDepartment()"></BUTTON>
				  <SPAN id=departmentspan>
					<%=deptnames%>
                      <!--IMG src="/images/BacoError.gif" align=absMiddle-->
				  </SPAN>
            <INPUT class=inputstyle id=departmentids type=hidden name=departmentid value=<%=departmentid%>>
        </TD>
    </TR>
    </TBODY>
    <TR style="height:1px"><TD class=Line colSpan=2></TD></TR>

    <TR class=Spacing style="height:2px">
        <TD class=Line1 colSpan=2></TD>
    </TR>
    </TBODY>

    <COLGROUP>
        <COL width=15%>
        <COL width=15%>
        <COL width=70%>
    </COLGROUP>
    <TBODY>
        <tr>
            <td><input type="button" value="添加考评明细" onclick="addItem()"></td>
            <td><input type="button" value="删除考评明细" onclick="doDel()"></td>
        </tr>
    </TBODY>

    <tbody>
    <tr>
        <td colspan="2">
            <table id="add_kplist_item"
                   class="ListStyle detailtable detailtableTopTable"
                   style="width: 100%" border="1" name="oTable1">
                <colgroup>
                    <COL width="5%">
                    <COL width="50%">
                    <COL width="30%">
                    <COL width="10%">
                    <COL width="10%">
                </colgroup>
                <tbody>
                <tr class="header detailtitle">
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9632" class="Label" name="label9634" value="选择"
                            disabled="true" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9632" class="Label" name="label9634" value="条款细则"
                            disabled="true" /></td>
                    <td class="detailtitle" align="center"><input
                            id="label9633" class="Label" name="label9635"
                            value="评分标准" disabled="true" /></td>
                    <td class="detailtitle" align="center"><input
                            id="label9633" class="Label" name="label9635"
                            value="分数上限" disabled="true" /></td>
                </tr>
                </tbody>
            </table>
        </td>
    </tr>
</TABLE>
</FORM>
</td>
</tr>
</TABLE>
</td>
<td></td>
</tr>
<tr style="height:0px">
    <td height="0" colspan="3"></td>
</tr>
</table>
<script language=vbs>
sub onShowManagerID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	manageridspan.innerHtml = "<A href='HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	resource.managerid.value=id(0)
	else
	manageridspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	resource.managerid.value=""
	end if
	end if
end sub

sub onShowAssistantID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> "" then
	assistantidspan.innerHtml = "<A href='HrmResource.jsp?id="&id(0)&"'>"&id(1)&"</A>"
	resource.assistantid.value=id(0)
	else
	assistantidspan.innerHtml = ""
	resource.assistantid.value=""
	end if
	end if
end sub

sub onShowLocationID()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/location/LocationBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	locationidspan.innerHtml = id(1)
	resource.locationid.value=id(0)
	else
	locationidspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	resource.locationid.value=""
	end if
	end if
end sub

sub onShowJobcall()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/jobcall/JobCallBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	jobcallspan.innerHtml = id(1)
	resource.jobcall.value=id(0)
	else
	jobcallspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
	resource.jobcall.value=""
	end if
	end if
end sub

sub onShowJobType()
	id = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/jobtype/JobtypeBrowser.jsp")
	if (Not IsEmpty(id)) then
	if id(0)<> 0 then
	jobtypespan.innerHtml = id(1)
	resource.jobtype.value=id(0)
	else
	jobtypespan.innerHtml = ""
	resource.jobtype.value=""
	end if
	end if
end sub

</script>
<SCRIPT LANGUAGE="JavaScript">

</SCRIPT>
<script language="JavaScript">
    function onShowDepartment(){
//2004-6-16 Edit by Evan :传sql参数给部门浏览页面
        url=encode("/hrm/company/MultiDepartmentBrowser.jsp?isedit=1&rightStr=HrmResourceAdd:Add&sqlwhere=<%=getDepartmentSql(user)%>&selectedids="+jQuery("input[name=departmentid]").val()+"&supdepid=1");
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+url);
//2004-6-16 End Edit
        issame = false;
        if (data!=null){
            if (data.id != 0 ){
                if (data.id == jQuery("input[name=departmentid]").val()){
                    issame = true;
                }
                jQuery("#departmentspan").html(data.name);
                jQuery("input[name=departmentid]").val(data.id);
            }else{
                jQuery("#departmentspan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=departmentid]").val("");
            }
            if (issame == false){
                jQuery("#jobtitlespan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=jobtitle]").val("");
                //	costcenterspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
                //	resource.costcenterid.value=""
            }
        }
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

    function onShowCostCenter(){
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/CostcenterBrowser.jsp?sqlwhere= where departmentid="+jQuery("input[name=departmentid]").val());
        if (data!=null){
            if (data.id != 0 ){
                jQuery("#costcenterspan").html(data.name);
                jQuery("input[name=costcenterid]").val(data.id);
            }else{
                jQuery("#costcenterspan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=costcenterid]").val("");
            }
        }
    }

    function onShowJobtitle(){
        url=encode("/hrm/jobtitles/JobTitlesBrowser.jsp?sqlwhere= where jobdepartmentid="+jQuery("input[name=departmentid]").val()+"&fromPage=add");
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url="+url);
        if (data!=null){
            if (data.id != 0 ){
                jQuery("#jobtitlespan").html(data.name);
                jQuery("input[name=jobtitle]").val(data.id);
            }else{
                jQuery("#jobtitlespan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=jobtitle]").val("");
            }
        }
    }

    function onBelongto(){
        data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?from=add&sqlwhere=(accounttype is null or accounttype=0)");
        if (data!=null){
            if (data.id != ""){
                jQuery("#belongtospan").html("<A href='HrmResource.jsp?id="+data.id+"'>"+data.name+"</A>");
                jQuery("input[name=belongto]").val(data.id);
            }else{
                jQuery("#belongtospan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=belongto]").val("");
            }
        }
    }

    var saveBtn ;
    function encode(str){
        return escape(str);
    }
    function doSave(obj) {
        var details = [];

        var index = 0;

        $("#add_kplist_item").find('tr').each(function() {

            if(index == 0) {
                index = index+1;
                return true;
            }

            var fs;
            var tkxz;
            var pfbz;

            $(this).find("input[name='fs']").each(function() {
               fs = $(this).val();
            });

            $(this).find("textarea[name='tkxz']").each(function() {
                tkxz = encodeURI($(this).val(),"UTF-8");
            });

            $(this).find("textarea[name='pfbz']").each(function() {
                pfbz = encodeURI($(this).val(),"UTF-8");
            });

            if(isNaN(fs)) {
                alert("分数必须为数字");
                return false;
            }

            if(tkxz=="") {
                alert("条款细则不能为空");
                return false;
            }

            if(pfbz=="") {
                alert("评分标准不能为空");
                return false;
            }

            details.push({
                fs:fs,
                tkxz:tkxz,
                pfbz:pfbz
            });
        });

        var itemId = "<%=itemId%>";
        var qingdanid = $("#qingdanSelect").val();
        var itemType = encodeURI($("#itemType").val(),"UTF-8");
        var pfbm = $("#departmentids").val();
        var acceptType = encodeURI($("#acceptType").val(),"UTF-8");

        var obj = {"itemId":itemId,"qdId":qingdanid,"kpnr":itemType,"kpfs":acceptType,"pfbm":pfbm,"details":details};

        if(itemType=="") {
            alert("考评内容不能为空");
            return false;
        }

        if(pfbm == "") {
            alert("评分部门不能为空");
            return false;
        }

        <%--//保存列表数据--%>
        jQuery.ajax({
            type:"POST",
            url:"/service/common/saveCheckItems",
            contentType: "application/json",
            data:JSON.stringify(obj),
            success:function(res){
                alert("添加成功");
                window.location.href="itemList.jsp";
            },
            error:function(e){}
        });
    }

    function changeKpfs() {
        var kpfs = $('#checkType option:selected').val();
        if(kpfs == "NO") {
            $("#kpfsDiv").hide();
        } else {
            $("#kpfsDiv").show();
        }
    }

    //添加列表项
    function addItem(){
        var table_row	= "<tr>";
        table_row += "<td style='padding: 2px;'><input type='checkbox' name='chk_row'></></td>";
        table_row += "<td style='padding: 2px;'><textarea name='tkxz' style='width: 90%; overflow:hidden; height: 32px;'></textarea></td>";
        table_row += "<td style='padding: 2px;'><textarea name='pfbz' style='width: 90%; overflow:hidden; height: 32px;'></textarea></td>";
        table_row += "<td style='padding: 2px;'><input type='text' name='fs' style='width: 90%;height: 32px;'></></td>";
        table_row += "</tr>";
        $('#add_kplist_item').append(table_row);
    }

    //删除选定列表项
    function doDel(){
        var len = $("input[name='chk_row']").length;

        //倒序操作
        $("input[name='chk_row']").each(function(index){
            var cur = len - index - 1;
            if($("input[name='chk_row']").eq(cur).is(':checked')){
                $('#add_kplist_item tr').eq(cur+1).remove();
            }
        });
    }
</script>


<script language="vbs">
sub onShowBrowser(id,id2,url,linkurl,type1,ismand)

	if type1= 2 or type1 = 19 then
		id1 = window.showModalDialog(url,,"dialogHeight:320px;dialogwidth:275px")
		document.all("span"+id2).innerHtml = id1
		document.all("dateField"+id).value=id1
	else
		if type1 <> 17 and type1 <> 18 and type1<>27 and type1<>37 and type1<>4 and type1<>167 and type1<>164 and type1<>169 and type1<>170 then
			id1 = window.showModalDialog(url)
		elseif type1=4 or type1=167 or type1=164 or type1=169 or type1=170 then
            tmpids = document.all("dateField"+id).value
			id1 = window.showModalDialog(url&"?selectedids="&tmpids)
		else
			tmpids = document.all("dateField"+id).value
			id1 = window.showModalDialog(url&"?resourceids="&tmpids)
		end if
		if NOT isempty(id1) then
			if type1 = 17 or type1 = 18 or type1=27 or type1=37 then
				if id1(0)<> ""  and id1(0)<> "0" then
					resourceids = id1(0)
					resourcename = id1(1)
					sHtml = ""
					resourceids = Mid(resourceids,2,len(resourceids))
					document.all("dateField"+id).value= resourceids
					resourcename = Mid(resourcename,2,len(resourcename))
					while InStr(resourceids,",") <> 0
						curid = Mid(resourceids,1,InStr(resourceids,",")-1)
						curname = Mid(resourcename,1,InStr(resourcename,",")-1)
						resourceids = Mid(resourceids,InStr(resourceids,",")+1,Len(resourceids))
						resourcename = Mid(resourcename,InStr(resourcename,",")+1,Len(resourcename))
						sHtml = sHtml&"<a href="&linkurl&curid&">"&curname&"</a>&nbsp"
					wend
					sHtml = sHtml&"<a href="&linkurl&resourceids&">"&resourcename&"</a>&nbsp"
					document.all("span"+id2).innerHtml = sHtml

				else
					if ismand=0 then
						document.all("span"+id2).innerHtml = empty
					else
						document.all("span"+id2).innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.all("dateField"+id).value=""
				end if

			else
			   if  id1(0)<>""   and id1(0)<> "0"  then
			        if linkurl = "" then
						document.all("span"+id2).innerHtml = id1(1)
					else
						document.all("span"+id2).innerHtml = "<a href="&linkurl&id1(0)&">"&id1(1)&"</a>"
					end if
					document.all("dateField"+id).value=id1(0)
				else
					if ismand=0 then
						document.all("span"+id2).innerHtml = empty
					else
						document.all("span"+id2).innerHtml ="<img src='/images/BacoError.gif' align=absmiddle>"
					end if
					document.all("dateField"+id).value=""
				end if
			end if
		end if
	end if
end sub
</script>
</BODY>
<SCRIPT language="javascript" defer="defer" src='/js/datetime.js?rnd="+Math.random()+"'></script>
<SCRIPT language="javascript" defer="defer" src='/js/JSDateTime/WdatePicker.js?rnd="+Math.random()+"'></script>
</HTML>
