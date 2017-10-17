<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
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
<jsp:useBean id="SubCompanyComInfo" class="weaver.hrm.company.SubCompanyComInfo" scope="page" />
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
    String[] tmpList = {"245","251","253","263"};
    List<String> listTmp = Arrays.asList(tmpList);

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
            + SystemEnv.getHtmlLabelName(181522, user.getLanguage());
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
    String subcompanyid = Util.null2String(request.getParameter("subcompanyid"));
    if(subcompanyid.startsWith(",")) {
        subcompanyid = subcompanyid.substring(1,subcompanyid.length());
    }

    String qingdanId = request.getParameter("qingdanid");

    String status = request.getParameter("status");
    String kpMonth = Util.null2String(request.getParameter("kpmonth"));
    if(StringUtils.isBlank(kpMonth)){
        Calendar c = Calendar.getInstance();
        int currentMonth = c.get(Calendar.MONTH) + 1;
        kpMonth = String.valueOf(currentMonth/4+1);
    }

    String itemdesc = Util.null2String(request.getParameter("itemdesc"));

    String params = "t1.zipingrequestid,t2.pfbz,t1.qingdanmc,t1.id,t1.itemid,t1.deptid,t3.departmentname,t1.companyid,t4.subcompanyname, t2.itemtitle,t2.itemtype,t2.itemdesc,t2.maxscore,t2.accepttype,t1.status,t1.kpfenshu,t1.kpmonth,t1.zipingfs,t1.isCanCheck,t1.checktype,t1.qingdanid";
    String tablename = "t_item_dept_link t1,t_check_item t2,hrmdepartment t3,hrmsubcompany t4,t_dept_user_link t5";
    String whereClause = "t1.itemid = t2.id and t3.id = t1.deptid and t4.id = t1.companyid and t5.deptid=t1.deptid and t5.userid="+userid + " and t1.kpmonth='" + kpMonth + "'";
    //String orderBy = "t1.itemid,t1.companyid";
    String orderBy = "nvl(t1.kpfenshu,0) desc, t2.qingdanid,t2.showOrder,t2.itemorder,t1.kpfenshu desc";

    if(StringUtils.isNotBlank(status)) {
        whereClause += " and t1.status='"+status+"'";
    }

    if(StringUtils.isNotBlank(subcompanyid)) {
        whereClause += " and t1.companyid in ("+subcompanyid+")";
    }

    if(StringUtils.isNotBlank(qingdanId)){
        whereClause += " and t1.qingdanid="+qingdanId;
    }

    if(StringUtils.isNotBlank(itemdesc)){
        whereClause += " and t2.itemdesc like '%" + itemdesc + "%'";
    }

    String sql = "select "+params+" from "+tablename+" where "+whereClause+" order by "+orderBy;
    new BaseBean().writeLog(sql);
    RecordSet.execute(sql);
    RecordSet qingdanRecordSet = new RecordSet();
    qingdanRecordSet.execute("select * from qingdan order by id");
%>
<BODY>
<%@ include file="/systeminfo/TopTitle.jsp"%>
<%@ include file="/systeminfo/RightClickMenuConent.jsp"%>
<%
    RCMenu += "{查询,javascript:doSearch(),_self} ";
    RCMenu += "{评分,javascript:doCheck(),_self} ";
    RCMenuHeight += RCMenuHeightStep*2;
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
                                            <font class="reqname">党建考评</font>
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
        <TD class="fname">被考评公司</TD>
        <td class="fvalue">
            <BUTTON class=Browser type="button" id=kpbm onClick="onShowSubCompany()"></BUTTON>
              													<SPAN id=subcompanyspan>
                													<%=SubCompanyComInfo.getSubCompanyname(subcompanyid)%>
              													</SPAN>
            <INPUT class=inputstyle id=subcompanyid type=hidden name=subcompanyid value=<%=subcompanyid%>>
        </td>
        <TD class="fname">考评状态</TD>
        <td class="fvalue">
            <select id="selectStatus">
                <option value="" <%if(StringUtils.isBlank(status)){ %>selected="selected"<%} %>>全部</option>
                <option value="VALID" <%if(StringUtils.equals("VALID", status)) {%>selected="selected"<%} %>>未考评</option>
                <option value="INVALID" <%if(StringUtils.equals("INVALID", status)) {%>selected="selected"<%} %>>已考评</option>
            </select>
        </td>

    </tr>
    <tr>
        <TD class="fname">清单列表</TD>
        <td class="fvalue"><select id="qingdanSelect" onChange="doSearch()">
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
        <TD class="fname">考评日期</TD>
        <td class="fvalue">
            <select id="kpmonth">
                <%
                    Calendar c = Calendar.getInstance();
                    int currentMonth = c.get(Calendar.MONTH) + 1;
                    int jd = currentMonth/4+1;
                %>
                <option id="kpMonth1" value="<%=1%>" <%if(jd==1) { %>selected="selected"<%} %>>一季度</option>
                <option id="kpMonth2" value="<%=2%>" <%if(jd==2) { %>selected="selected"<%} %>>二季度</option>
                <option id="kpMonth3" value="<%=3%>" <%if(jd==3) { %>selected="selected"<%} %>>三季度</option>
                <option id="kpMonth4" value="<%=4%>" <%if(jd==4) { %>selected="selected"<%} %>>四季度</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="fname">条款细则</td>
        <td class="fvalue">
            <input type="text" id="itemdesc" name="itemdesc" value="<%=itemdesc %>" />
        </td>
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
        <td height="15" colspan="2"><input type="checkbox" id="allcheck" />全选</td>
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
                    <!-- <COL width="10%"> -->
                    <COL width="1%">
                    <COL width="10%">
                    <!-- <COL width="10%"> -->
                    <COL width="10%">
                    <COL width="15%">
                    <COL width="5%">
                    <COL width="5%">
                    <COL width="10%">
                    <COL width="5%">
                    <COL width="5%">
                    <COL width="5%">
                    <COL width="5%">
                    <COL width="5%">
                </colgroup>
                <tbody>
                <tr class="header detailtitle">
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9633" class="Label" name="label9635"
                            value="选择" disabled="true" style="width:80px;" /></td>
                    <!-- <td class="detailtitle" nowrap="nowrap" align="center"><input
                        id="label9633" class="Label" name="label9635"
                        value="清单名称" disabled="true" style="width:120px;" /></td> -->
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9633" class="Label" name="label9635"
                            value="被考评公司" disabled="true" style="width:80px;" /></td>
                    <!-- <td class="detailtitle" nowrap="nowrap" align="center"><input
                        id="label9633" class="Label" name="label9635"
                        value="评分部门" disabled="true" style="width:60px;" /></td> -->
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9635" class="Label" name="label9635"
                            value="内容" disabled="true" style="width:120px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9636" class="Label" name="label9636"
                            value="条款细则" disabled="true" style="width:120px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9637" class="Label" name="label9637"
                            value="分数上限" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9638" class="Label" name="label9638"
                            value="验收方式" disabled="true" style="width:120px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9643" class="Label" name="label9639"
                            value="评分标准" disabled="true" style="width:120px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9647" class="Label" name="label9639"
                            value="自评分数" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9647" class="Label" name="label9639"
                            value="资料" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9646" class="Label" name="label9639"
                            value="考评方式" disabled="true" style="width:60px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9644" class="Label" name="label9639"
                            value="分数" disabled="true" style="width:30px;" /></td>
                    <td class="detailtitle" nowrap="nowrap" align="center"><input
                            id="label9645" class="Label" name="label9639"
                            value="确认考评" disabled="true" style="width:60px;" /></td>
                </tr>
                </tbody>
                <%
                    int rowindex = 0;
                    while(RecordSet.next()) {
                        String itemid = RecordSet.getString("itemId");
                        String statusStr = RecordSet.getString("status");
                        String zipingrequestid = RecordSet.getString("zipingrequestid");
                        String biaoti = RecordSet.getString("itemDesc")+"-"+RecordSet.getString("subcompanyname")+"-"+RecordSet.getString("kpMonth");
                        String checktype = RecordSet.getString("checktype");
                %>
                <tr>
                    <td><input type="checkbox" value="<%=rowindex%>"></td>
                    <input type="hidden" id="itemDeptId<%=rowindex%>" value="<%=RecordSet.getString("id")%>">
                    <input type="hidden" id="itemId<%=rowindex%>" value="<%=RecordSet.getString("itemId")%>">
                    <input type="hidden" id="companyid<%=rowindex%>" value="<%=RecordSet.getString("companyid")%>">
                    <!-- <td><div id='qingdanmc<%=rowindex %>' name='qingdanmc<%=rowindex %>' style='width=80%'><%=RecordSet.getString("qingdanmc") %></div></td> -->
                    <td><div id='subcompanyname<%=rowindex %>' name='subcompanyname<%=rowindex %>' style='width=80%'><%=RecordSet.getString("subcompanyname") %></div></td>
                    <!-- <td><div id='departmentname<%=rowindex %>' name='departmentname<%=rowindex %>' style='width=80%'><%=RecordSet.getString("departmentname") %></div></td> -->
                    <td><div id='itemType<%=rowindex %>' name='itemType<%=rowindex %>' style='width=80%'><%=RecordSet.getString("itemType") %></div></td>
                    <td><div id='itemDesc<%=rowindex %>' name='itemDesc<%=rowindex %>' style='width=80%'><%=RecordSet.getString("itemDesc")%></div></td>
                    <td><div style='width=80%'>
                        <input type="hidden" id="maxScore<%=rowindex %>" name="maxScore<%=rowindex %>" value="<%=RecordSet.getString("maxScore")%>" />
                        <%
                            String maxScore = RecordSet.getString("maxScore");
                            String maxSource1 = maxScore;
                            if(StringUtils.equalsIgnoreCase(RecordSet.getString("qingdanid"),"4")){
                                maxScore =  (Integer.parseInt(maxScore) * -1) + "";
                            }else if(StringUtils.equalsIgnoreCase(RecordSet.getString("qingdanid"),"3")){
                                if(listTmp.contains(itemid)){
                                    maxScore = "0";
                                }
                            }
                        %>
                        <%=maxScore%>
                    </div></td>
                    <td><div id='acceptType<%=rowindex %>' name='acceptType<%=rowindex %>' style='width=80%'><%=RecordSet.getString("acceptType")%></div></td>
                    <td><div id='pfbz<%=rowindex %>' name='pfbz<%=rowindex %>' style='width=80%'><%=RecordSet.getString("pfbz")%></div></td>
                    <td><div id='zipingfs<%=rowindex %>' name='zipingfs<%=rowindex %>' style='width=80%'><%=RecordSet.getString("zipingfs") %></div></td>
                    <%
                        String companyid= RecordSet.getString("companyid");
                        String kpmonth= RecordSet.getString("kpMonth");
                        int qingdanxh = RecordSet.getInt("qingdanid");
                        String sql1 = "select count(*) from (select t2.id from zipinglog t1 left join user_ziping_view_log t2 on t1.id = t2.zipingid and t2.userid="+userid+" where t1.itemid = "+itemid+" and t1.companyid="+companyid+" and kpmonth = '"+kpmonth+"') where id is null";
                        RecordSet rs1 = new RecordSet();
                        rs1.execute(sql1);
                        Integer newCount = 0;
                        if(rs1.next()) {
                            newCount = rs1.getInt(1);
                        }
                        if(newCount == 0) {
                    %>
                    <td><div><a href="addZiping.jsp?biaoti=<%=biaoti%>&itemid=<%=RecordSet.getString("itemId")%>&companyid=<%=RecordSet.getString("companyid")%>&kpMonth=<%=RecordSet.getString("kpMonth")%>">资料</a></div></td>
                    <% } else {%>
                    <td><div><a href="addZiping.jsp?biaoti=<%=biaoti%>&itemid=<%=RecordSet.getString("itemId")%>&companyid=<%=RecordSet.getString("companyid")%>&kpMonth=<%=RecordSet.getString("kpMonth")%>"><font color="red">资料</font></a></div></td>
                    <%}%>
                    <%
                        boolean isCanCheck = Boolean.valueOf(RecordSet.getString("isCanCheck"));
                        if(StringUtils.equalsIgnoreCase(statusStr, "VALID") || isCanCheck) {
                    %>
                    <td>
                        <%
                            if(StringUtils.isBlank(checktype)){
                                if(qingdanxh == 1 || qingdanxh == 2 || qingdanxh == 3){
                                    checktype = "ADD";
                                }else if(qingdanxh == 4){
                                    if("0".equals(maxSource1)){
                                        checktype = "ADD";
                                    }else{
                                        checktype = "MINUS";
                                    }
                                }
                                System.out.println("---------"+checktype);
                            }
                        %>
                        <select id="kpfs<%=rowindex%>">
                            <option value="ADD" <%if(null == checktype || "ADD".equals(checktype)){%>selected="selected"<%}%> >加分</option>
                            <option value="MINUS" <%if("MINUS".equals(checktype)){%>selected="selected"<%}%>>减分</option>
                            <option value="NO" <%if("NO".equals(checktype)){%>selected="selected"<%}%>>否决</option>
                        </select>
                    </td>
                    <td>
                        <%

                            String kpfenshu_input = RecordSet.getString("kpfenshu");
                            if(StringUtils.isBlank(kpfenshu_input)){
                                if(qingdanxh == 1 || qingdanxh == 2 || qingdanxh == 4){
                                    kpfenshu_input = maxSource1;
                                }else if(qingdanxh == 3){
                                    if(listTmp.contains(itemid)){
                                        kpfenshu_input = "0";
                                    }else{
                                        kpfenshu_input = maxSource1;
                                    }
                                }
                            }
                        %>
                        <input type="text" style="width:30px;" id='kpfenshu<%=rowindex %>' name='kpfenshu<%=rowindex %>' style='width=80%' value="<%=kpfenshu_input %>">
                    </td>
                    <td><div id='pingfen<%=rowindex %>' name='pingfen<%=rowindex %>' style='width=80%'><input type="button" id="pingfenButton<%=rowindex%>" value="评分" onClick="onCheck(<%=rowindex%>)"></div></td>

                    <%} else {%>
                    <td><%if(null == checktype || "ADD".equals(checktype)) {%>加分<%}else if("MINUS".equals(checktype)) { %>减分<%} else { %>否决<%} %></td>
                    <td><div id='kpfenshu<%=rowindex %>' name='kpfenshu<%=rowindex %>' style='width=80%'><%=RecordSet.getString("kpfenshu") %></td>
                    <td><div id='pingfen<%=rowindex %>' name='pingfen<%=rowindex %>' style='width=80%'>已评分</div></td>
                    <%} %>
                </tr>
                <%
                        rowindex++;
                    } %>
            </table>
        </td>
    </tr>
    </tbody>
</table> <script>
    jQuery(document).ready(function(){
        var userid=<%=userid%>;
        var deptId=<%=deptId%>;
        var rowindex1=0;

        //getYdkpItems();

        function getYdkpItems() {
            jQuery.ajax({
                type:"GET",
                url:"/service/common/getCheckItems",
                data:"userid="+userid,
                success:function(res){
                    var json = eval("("+res+")");
                    if(json.flag == "-1"){
                        alert("数据查询错误");
                    }else{
                        jQuery.each(json,function(i){
                            addRow1();
                            jQuery("#itemid_"+ rowindex1).val(json[i].id);
                            jQuery("#khjg_"+ rowindex1).html(json[i].companyName);
                            jQuery("#khjg_input_"+ rowindex1).val(json[i].companyId);
                            jQuery("#khjg_input_"+ rowindex1).hide();
                            jQuery("#kpxm_"+ rowindex1).html(json[i].itemType);
                            jQuery("#kpnr_"+ rowindex1).html(json[i].itemDesc);
                            jQuery("#fssx_"+ rowindex1).html(json[i].maxScore);
                            jQuery("#ysfs_"+ rowindex1).html(json[i].acceptType);
                            var checkTypeArray = json[i].checkType;
                            if(checkTypeArray=="ADD" || checkTypeArray=="MINUS") {
                                $("#kpfs_select_"+rowindex1).append( "<option value=ADD>加分</option>" );
                                $("#kpfs_select_"+rowindex1).append( "<option value=MINUS>减分</option>" );
                            }else {
                                $("#kpfs_select_"+rowindex1).append( "<option value=MINUS>一票否决</option>" );
                            }
                            jQuery.each(json[i].checkTypes,function(j){
                                var id = json[i].checkTypes[j].id;
                                var checkType = json[i].checkTypes[j].checkType;
                                var itemType = json[i].itemType;
                                $("#pfbz_select_"+rowindex1).append( "<option value="+id+">"+checkType+"</option>" );
                            });
                            $("#kpfs_input_"+rowindex1).hide();
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

            //考评项目
            var khjgtd = jQuery("<td></td>");
            var khjgid = "khjg_"+ rowindex1;
            var khjgHtml = "<div style=  id='"+ khjgid+ "' name='"+ khjgid+ "' style='width=80%'>";
            khjgtd.append(khjgHtml);

            var khjg_input_id = "khjg_input_"+rowindex1;
            var khjg_input_html = "<input id='"+ khjg_input_id+ "' name='"+ khjg_input_id+ "' style='width=80%'>";
            khjgtd.append(khjg_input_html);
            row.append(khjgtd);

            //考评项目
            var kpxmtd = jQuery("<td></td>");
            var kpxmid = "kpxm_"+ rowindex1;
            var kpxmHtml = "<div style= id='"+ kpxmid+ "' name='"+ kpxmid+ "' style='width=80%'>";
            kpxmtd.append(kpxmHtml);
            row.append(kpxmtd);

            //考评内容
            var kpnrtd = jQuery("<td></td>");
            var kpnrid = "kpnr_"+ rowindex1;
            var kpnrHtml = "<div id='"+ kpnrid+ "' name='"+ kpnrid+ "' style='width=80%'>";
            kpnrtd.append(kpnrHtml);
            row.append(kpnrtd);

            var fssxtd = jQuery("<td></td>");
            var fssxid = "fssx_"+ rowindex1;
            var fssxHtml = "<div id='"+ fssxid+ "' name='"+ fssxid+ "' style='width=80%'>";
            fssxtd.append(fssxHtml);
            row.append(fssxtd);

            var ysfstd = jQuery("<td></td>");
            var ysfsid = "ysfs_"+ rowindex1;
            var ysfsHtml = "<div id='"+ ysfsid+ "' name='"+ ysfsid+ "' style='width=80%'>";
            ysfstd.append(ysfsHtml);
            row.append(ysfstd);

            var pfbztd = jQuery("<td></td>");
            var pfbzid = "pfbz_"+ rowindex1;
            var pfbzHtml = "<div id='"+ pfbzid+ "' name='"+ pfbzid+ "' style='width=80%'>";
            pfbztd.append(pfbzHtml);

            var pfbz_input_id = "pfbz_input_"+ rowindex1;
            var pfbz_input_html = "<input id='"+ pfbz_input_id+ "' name='"+ pfbz_input_id+ "' style='width=80%'>";
            pfbztd.append(pfbz_input_html);

            var pfbz_select_id = "pfbz_select_"+rowindex1;
            var pfbz_select_html = "<select id='"+ pfbz_select_id+ "' name='"+ pfbz_select_id+ "' style='width=80%'>";
            pfbztd.append(pfbz_select_html);
            row.append(pfbztd);

            var kpfstd = jQuery("<td></td>");
            var kpfsid = "kpfs_"+ rowindex1;
            var kpfsHtml = "<div id='"+ kpfsid+ "' name='"+ kpfsid+ "' style='width=80%'>";
            kpfstd.append(kpfsHtml);

            var kpfs_input_id = "kpfs_input_"+ rowindex1;
            var kpfs_input_html = "<input id='"+ kpfs_input_id+ "' name='"+ kpfs_input_id+ "' style='width=80%'>";
            kpfstd.append(kpfs_input_html);

            var kpfs_select_id = "kpfs_select_"+rowindex1;
            var kpfs_select_html = "<select id='"+ kpfs_select_id+ "' name='"+ kpfs_select_id+ "' style='width=80%'>";
            kpfstd.append(kpfs_select_html);
            row.append(kpfstd);

            var fstd = jQuery("<td></td>");
            var fsid = "fs_"+ rowindex1;
            var fsHtml = "<div id='"+ fsid+ "' name='"+ fsid+ "' style='width=80%'>";
            fstd.append(fsHtml);
            var fs_input_id = "fs_input_"+ rowindex1;
            var fs_input_html = "<input id='"+ fs_input_id+ "' name='"+ fs_input_id+ "' style='width:60px;'>";
            fstd.append(fs_input_html);
            row.append(fstd);

            var qrkptd = jQuery("<td></td>");
            var qrkpid = "qrkp_"+ rowindex1;
            var qrkpHtml = "<div id='"+ qrkpid+ "' name='"+ qrkpid+ "' style='width=80%'>";
            qrkptd.append(qrkpHtml);
            var qrkp_input_id = "qrkp_input_"+ rowindex1;
            var qrkp_input_html = "<input type='button' value='确认考评' onclick='onCheck("+rowindex1+")' id='"+ qrkp_input_id+ "' name='"+ qrkp_input_id+ "' style='width=80%'>";
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
                                "#departmentid").val()) {
                    issame = true;
                }
                jQuery("#departmentspan").html(data.name);
                jQuery("#departmentid").val(data.id);
            } else {
                jQuery("#departmentspan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("#departmentid").val("");
            }
            if (issame == false) {
                jQuery("#jobtitlespan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("input[name=jobtitle]").val(
                        "");
                //	costcenterspan.innerHtml = "<IMG src='/images/BacoError.gif' align=absMiddle>"
                //	resource.costcenterid.value=""
            }
        }
    }

    function onShowSubCompany(row){
        url = encode("/hrm/company/MutiSubcompanyBrowser.jsp?isedit=1&rightStr=HrmResourceAdd:Add&sqlwhere=&selectedids=");
        data = window
                .showModalDialog("/systeminfo/BrowserMain.jsp?url="
                        + url);
        //2004-6-16 End Edit
        issame = false;
        if (data != null) {
            if (data.id != 0) {
                if (data.id == jQuery(
                                "#departmentid").val()) {
                    issame = true;
                }
                jQuery("#subcompanyspan").html(data.name);
                jQuery("#subcompanyid").val(data.id);
            } else {
                jQuery("#subcompanyspan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
                jQuery("#subcompanyid").val("");
            }
            if (issame == false) {
                jQuery("#jobtitlespan").html("<IMG src='/images/BacoError.gif' align=absMiddle>");
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

    function doCheck() {
        var count = 0;
        $("input[type=checkbox][checked]").each(function(){
            count++;
            var val = $(this).val()
            onCheck1(val);
        });

        if(count == 0) {
            alert("请选择需要评分的选项");
            return false;
        }
        doSearch();
    }

    function onCheck1(rowindex) {
        $("#qrkp_input_"+rowindex).attr({"disabled":"disabled"});
        var id = $("itemDeptId"+rowindex).val();
        var userid = <%=userid%>;
        var kpfs = $("#kpfs"+rowindex).val();
        var kpfenshu = $("#kpfenshu"+rowindex).val();
        var itemid = $("#itemId"+rowindex).val();
        var companyid = $("#companyid"+rowindex).val();
        var id =$("#itemDeptId"+rowindex).val();
        //var maxScore = $("#maxScore"+rowindex).html();
        var maxScore = $("#maxScore" + rowindex).val();

        if(parseFloat(maxScore) < parseFloat(kpfenshu)) {
            alert("考评分数必须小于分数上限");
            return false;
        }

        var kpMonth = "<%=kpMonth%>"
        if(kpfs == "NO") {
            kpfenshu = 0;
        }else {
            if(!kpfenshu) {
                alert("分数不能为空");
                return false;
            }
            if(isNaN(kpfenshu)) {
                alert("分数格式错误");
                return false;
            }
        }

        jQuery.ajax({
            type:"POST",
            url:"/service/common/markItem",
            async:false,
            data:"userid="+userid+"&pfbz=&kpfs="+kpfs+"&fs="+kpfenshu+"&itemid="+itemid+"&companyId="+companyid+"&id="+id+"&kpMonth="+kpMonth,
            success:function(res){

            },
            error:function(e){
                alert(e);
            }
        });
    }

    function onCheck(rowindex) {
        $("#qrkp_input_"+rowindex).attr({"disabled":"disabled"});
        var id = $("itemDeptId"+rowindex).val();
        var userid = <%=userid%>;
        var kpfs = $("#kpfs"+rowindex).val();
        var kpfenshu = $("#kpfenshu"+rowindex).val();
        var itemid = $("#itemId"+rowindex).val();
        var companyid = $("#companyid"+rowindex).val();
        var id =$("#itemDeptId"+rowindex).val();
        //var maxScore = $("#maxScore"+rowindex).html();
        var maxScore = $("#maxScore" + rowindex).val();

        if(parseFloat(maxScore) < parseFloat(kpfenshu)) {
            alert("考评分数必须小于分数上限");
            return false;
        }

        var kpMonth = "<%=kpMonth%>"
        if(kpfs == "NO") {
            kpfenshu = 0;
        }else {
            if(!kpfenshu) {
                alert("分数不能为空");
                return false;
            }
            if(isNaN(kpfenshu)) {
                alert("分数格式错误");
                return false;
            }
        }

        jQuery.ajax({
            type:"POST",
            cache: false,
            url:"/service/common/markItem",
            data:"userid="+userid+"&pfbz=&kpfs="+kpfs+"&fs="+kpfenshu+"&itemid="+itemid+"&companyId="+companyid+"&id="+id+"&kpMonth="+kpMonth,
            success:function(res){
                alert(res);
                doSearch();
            },
            error:function(e){
                alert(e);
            }
        });
    }

    function addNew() {
        window.location.href = "ydkpItemAdd.jsp";
    }

    var rowindex1 = 0;
    var userid=<%=userid%>;
    function doSearch() {
        var url = window.location.href;
        url = url.split("?")[0];
        var status = $("#selectStatus").val();
        var subcompanyid = $("#subcompanyid").val();
        var qingdanid = $("#qingdanSelect").val();
        var kpmonth = $("#kpmonth option:selected").val();
        var itemdesc = $("#itemdesc").val();
        location.replace(url+"?status="+status+"&subcompanyid="+subcompanyid+"&qingdanid="+qingdanid+"&kpmonth="+kpmonth+"&itemdesc="+itemdesc);
    }



    function getYdkpItems(status) {
        jQuery.ajax({
            type:"GET",
            url:"/service/common/getCheckItems",
            data:"userid="+userid+"&status="+status,
            success:function(res){
                var json = eval("("+res+")");
                if(json.flag == "-1"){
                    alert("数据查询错误");
                }else{
                    jQuery.each(json,function(i){
                        addRow1();
                        jQuery("#itemid_"+ rowindex1).val(json[i].id);
                        jQuery("#khjg_"+ rowindex1).html(json[i].companyName);
                        jQuery("#khjg_input_"+ rowindex1).val(json[i].companyId);
                        jQuery("#khjg_input_"+ rowindex1).hide();
                        jQuery("#kpxm_"+ rowindex1).html(json[i].itemType);
                        jQuery("#kpnr_"+ rowindex1).html(json[i].itemDesc);
                        jQuery("#fssx_"+ rowindex1).html(json[i].maxScore);
                        jQuery("#ysfs_"+ rowindex1).html(json[i].acceptType);
                        var checkTypeArray = json[i].checkType;
                        if(checkTypeArray=="ADD" || checkTypeArray=="MINUS") {
                            $("#kpfs_select_"+rowindex1).append( "<option value=ADD>加分</option>" );
                            $("#kpfs_select_"+rowindex1).append( "<option value=MINUS>减分</option>" );
                        }else {
                            $("#kpfs_select_"+rowindex1).append( "<option value=NO>一票否决</option>" );
                        }
                        jQuery.each(json[i].checkTypes,function(j){
                            var id = json[i].checkTypes[j].id;
                            var checkType = json[i].checkTypes[j].checkType;
                            var itemType = json[i].itemType;
                            $("#pfbz_select_"+rowindex1).append( "<option value="+id+">"+checkType+"</option>" );
                        });
                        $("#kpfs_input_"+rowindex1).hide();
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

        //考评项目
        var khjgtd = jQuery("<td></td>");
        var khjgid = "khjg_"+ rowindex1;
        var khjgHtml = "<nobr><div style=width:50%  id='"+ khjgid+ "' name='"+ khjgid+ "' style='width=80%'>";
        khjgtd.append(khjgHtml);

        var khjg_input_id = "khjg_input_"+rowindex1;
        var khjg_input_html = "<input id='"+ khjg_input_id+ "' name='"+ khjg_input_id+ "' style='width=80%'>";
        khjgtd.append(khjg_input_html);
        row.append(khjgtd);

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

        var pfbztd = jQuery("<td></td>");
        var pfbzid = "pfbz_"+ rowindex1;
        var pfbzHtml = "<nobr><div id='"+ pfbzid+ "' name='"+ pfbzid+ "' style='width=80%'>";
        pfbztd.append(pfbzHtml);

        var pfbz_input_id = "pfbz_input_"+ rowindex1;
        var pfbz_input_html = "<input id='"+ pfbz_input_id+ "' name='"+ pfbz_input_id+ "' style='width=80%'>";
        pfbztd.append(pfbz_input_html);

        var pfbz_select_id = "pfbz_select_"+rowindex1;
        var pfbz_select_html = "<select id='"+ pfbz_select_id+ "' name='"+ pfbz_select_id+ "' style='width=80%'>";
        pfbztd.append(pfbz_select_html);
        row.append(pfbztd);

        var kpfstd = jQuery("<td></td>");
        var kpfsid = "kpfs_"+ rowindex1;
        var kpfsHtml = "<nobr><div id='"+ kpfsid+ "' name='"+ kpfsid+ "' style='width=80%'>";
        kpfstd.append(kpfsHtml);

        var kpfs_input_id = "kpfs_input_"+ rowindex1;
        var kpfs_input_html = "<input id='"+ kpfs_input_id+ "' name='"+ kpfs_input_id+ "' style='width=80%'>";
        kpfstd.append(kpfs_input_html);

        var kpfs_select_id = "kpfs_select_"+rowindex1;
        var kpfs_select_html = "<select id='"+ kpfs_select_id+ "' name='"+ kpfs_select_id+ "' style='width=80%'>";
        kpfstd.append(kpfs_select_html);
        row.append(kpfstd);

        var fstd = jQuery("<td></td>");
        var fsid = "fs_"+ rowindex1;
        var fsHtml = "<nobr><div id='"+ fsid+ "' name='"+ fsid+ "' style='width=80%'>";
        fstd.append(fsHtml);
        var fs_input_id = "fs_input_"+ rowindex1;
        var fs_input_html = "<input id='"+ fs_input_id+ "' name='"+ fs_input_id+ "' style='width=80%'>";
        fstd.append(fs_input_html);
        row.append(fstd);

        var qrkptd = jQuery("<td></td>");
        var qrkpid = "qrkp_"+ rowindex1;
        var qrkpHtml = "<nobr><div id='"+ qrkpid+ "' name='"+ qrkpid+ "' style='width=80%'>";
        qrkptd.append(qrkpHtml);
        var qrkp_input_id = "qrkp_input_"+ rowindex1;
        var qrkp_input_html = "<input type='button' value='确认考评' onclick='onCheck("+rowindex1+")' id='"+ qrkp_input_id+ "' name='"+ qrkp_input_id+ "' style='width=80%'>";
        qrkptd.append(qrkp_input_html);
        row.append(qrkptd);

        table.append(row);
    }

    $("#allcheck").click(function(){
        var checked = $(this).is(":checked");
        $("input[type='checkbox']").each(function() {
            $(this).not("#allcheck").attr("checked",checked);
        });
    });
</script>
</BODY>
</HTML>