<%@ page contentType="text/html; charset=gb2312" %>
<%@ taglib uri="/struts-bean" prefix="bean" %>
<%@ taglib uri="/struts-html" prefix="html" %>
<%@ taglib uri="/struts-logic" prefix="logic" %>
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.base.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
<head>
<title><bean:message key="website.title"/></title>
<link href="CSS/stylesheet.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="JS/jsonrpc.js"></script>
</head>
<body class="body">
<table width="780" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF" style="border:1px; border-style:solid; border-color:#888888">
  <tr>
    <td width="20">&nbsp;</td>
    <TD height="50" align="right" valign="bottom">
		<IMG src="images/icon_login.gif" align=absMiddle> 
		<INPUT id="qKey" name="qKey" value="��Ʒ�ؼ���" onClick="this.value=''"> 
		<SELECT id="category" name="category">
			<option value="0">������Ʒ</option>
		</SELECT>
		<A href="javascript:QuickSearch()"><IMG src="images/icon_search.gif" align="absMiddle" border="0"></A>    </TD>
    <td width="20">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
        <TR align="center">
          <TD valign="top" width="9"><IMG src="images/icon02.gif"></TD>
          <TD class="header_menu" align="middle">
		  	<A href="mer.do?method=browseIndexMer"><span class="whiteTitle"><bean:message key="menu.item1"/></span></A>		  </TD>
          <TD background="images/Bule_06.gif" width="2"></TD>
          <TD class="header_menu" align="middle">
		  	<A href="cart.do?method=browseCart"><span class="whiteTitle"><bean:message key="menu.item2"/></span></A>		  </TD>
          <TD background="images/Bule_06.gif" width="2"></TD>
          <TD class="header_menu" align="middle">
		  	<A href="order.do?method=browseOrder"><span class="whiteTitle"><bean:message key="menu.item3"/></span></A>		  </TD>
          <TD background="images/Bule_06.gif" width="2"></TD>
          <TD class="header_menu" align="middle">
		  	<A href="mem.do?method=browseWord"><span class="whiteTitle"><bean:message key="menu.item4"/></span></A>		  </TD>
          <TD background="images/Bule_06.gif" width="2"></TD>
          <TD class="header_menu" align="middle">
		  	<A href="mem.do?method=loadMember"><span class="whiteTitle"><bean:message key="menu.item5"/></span></A>		  </TD>
          <TD vAlign=top width=7><IMG src="images/icon07.gif"></TD>
        </TR>
    </TABLE></td>
    <td>&nbsp;</td>
  </tr>
  
  <tr height="600">
��δ����      
  </tr>
  
  <tr>
    <td>&nbsp;</td>
    <td height="30" bgcolor="#4282CE" class="whiteText" align="center">
		<bean:message key="website.foot"/>	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td height="20">&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

<script language="javascript">
	//������Ʒ���������б�
	jsonrpc = new JSONRpcClient("JSON-RPC");
	var result = jsonrpc.ajax.getCategory();
	for (var i=0;i<result.length;i++){
		option =document.createElement("OPTION");
		option.value = result[i][0];
		option.text = result[i][1];
		document.all.category.options.add(option);
	}
	
	//������Ʒ
	function QuickSearch(){
		var url = "mer.do?method=searchMer&cateid="+document.all.category.value;
		var key = document.all.qKey.value;
		if (key !=null && key!="��Ʒ�ؼ���" && key.length>0)url = url+"&key="+key;
		window.location = url;
	}
	
	//�޸�ѡ������
	function modiNum(selid,newNum){
		if (jsonrpc.ajax.modiCart(selid,newNum)){
			var oldMoney = document.getElementById("money"+selid).innerText;
			var newMoney = newNum*document.getElementById("price"+selid).innerText;
			var diffMoney = newMoney - oldMoney;
			var newTotal = document.all.totalMoney.innerText*1+diffMoney;
			document.getElementById("money"+selid).innerText = Math.round(newMoney*100)/100;
			document.all.totalMoney.innerText = Math.round(newTotal*100)/100;
			alert("<bean:message key="cart.modi.suc"/>");
		}else{
			alert("<bean:message key="cart.modi.fail"/>");
		}
	}
	
	//ɾ��ѡ����¼
	function delCart(selid){
		var url = "cart.do?method=delCart&id="+selid;
		window.location = url;
	}
	
	//��չ��ﳵ
	function clearCart(){
		var url = "cart.do?method=clearCart";
		window.location = url;
	}
	
	//��������
	function continueBuy(){
		var url = "mer.do?method=searchMer&cateid=0";
		window.location = url;
	}

	//������һ��
	function next(){
		var url = "cart.do?method=checkOrder";
		window.location = url;
	}		
</script>
<logic:messagesPresent property="addCartStatus">
	<script language="javascript">
		alert('<html:errors property="addCartStatus"/>');
	</script>
</logic:messagesPresent>
<logic:messagesPresent property="delCartStatus">
	<script language="javascript">
		alert('<html:errors property="delCartStatus"/>');
	</script>
</logic:messagesPresent>
<logic:messagesPresent property="clearCartStatus">
	<script language="javascript">
		alert('<html:errors property="clearCartStatus"/>');}}
	</script>
</logic:messagesPresent>
</body>
</html>