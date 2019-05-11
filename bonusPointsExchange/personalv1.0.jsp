<%@page import="com.bit.bonusPointsExchange.bean.ShowBindInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
	String bindRes = (String)request.getAttribute("bindRes"); 
	if(bindRes == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("Bind the business successfully!");                                    // 弹出错误信息
	</script>		
<% } else if(bindRes == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("The binding merchant failed, you may not have registered with the merchant or you have already bound the merchant!");                                    // 弹出错误信息
	</script>
<% }else if(bindRes == "连接blockchain失败，请检查网络") {%>
	<script type="text/javascript" language="javascript">
		alert("连接blockchain失败，请检查网络");                                    // 弹出错误信息
	</script>		
<% }%>


<%
	String userChangeResult = (String)request.getAttribute("userChangeResult");  //获取修改用户信息是否成功
	if(userChangeResult == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("The information was modified successfully!");                                    // 弹出错误信息
	</script>	
<% } else if(userChangeResult == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("Information modification failed!");                                    
	</script>	
<% }%>

<%
	String pointTranRes = (String)request.getAttribute("pointTranRes"); 
	if(pointTranRes == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("Points are transferred from the merchant to the platform successfully!You own"+<%=request.getAttribute("userPoints")%>+"bonus in platform,and you own"+<%=request.getAttribute("shopPoints")%>+"bonus in Merchant." );                                    // 弹出错误信息
	</script>	
<% } else if(pointTranRes == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("Transfer failed!");                                    
	</script>	
<% }else if(pointTranRes == "连接blockchain失败，请检查网络") {%>
	<script type="text/javascript" language="javascript">
		alert("连接blockchain失败，请检查网络！");                                    
	</script>	
<% }%>


<%
	String pointToPshopRes = (String)request.getAttribute("pointToPshopRes"); 
	if(pointToPshopRes == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("Points are transferred from the platform to the merchant successfully!You own"+<%=request.getAttribute("userPoints")%>+"bonus in platform,And you own"+<%=request.getAttribute("shopPoints")%>+"Bonus in Merchant." );                                    // 弹出错误信息
	</script>	
<% } else if(pointToPshopRes == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("Transfer failed!");                                    
	</script>	
<% }%>

<%
	String userChangePasswd = (String)request.getAttribute("userChangePasswd");  //获取修改用户密码是否成功
	
	if(userChangePasswd == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("Failed to change password! The old password you entered is incorrect");                                    
	</script>	
<% }else if(userChangePasswd == "errorPasswd"){%>
	<script type="text/javascript" language="javascript">
		alert("The old password you entered is incorrect. Please re-enter");
	</script>
<% } %>
<!-- 显示查询到的绑定信息 -->
<% 
	List<ShowBindInfo> list = (List<ShowBindInfo>)request.getAttribute("bindInfo");
%>
 


<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Personal center</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/personal.css">
</head>
<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="personal">
  <div class="span7" id="Accordion1">
    <div  class="nav">
      <h3>Personal information</h3>
      <div class="index">
        <p><a href="javascript:showDiv(1)">Modify information</a></p>
        <p><a href="javascript:showDiv(2)">Modify password</a></p>
      </div>
      <h3>Bonus transfer</h3>
      <div class="index">
        <p><a href="javascript:showDiv(3)">Transfer Bonus to the platform</a></p>
        <p><a href="javascript:showDiv(4)">Transfer Bonus to the Merchant</a></p>
      </div>
      <h3>Binding merchant</h3>
      <div class="index">
        <p><a href="javascript:showDiv(5)">Bind a new merchant</a></p>
        <p><a href="javascript:showDiv(6)">Show bound merchants</a></p>
      </div>
    </div>
  </div>
  <div class="span8">
    <div id="div1">
      <p class="title">Personal information <span class="title1">USER INFOMATION</span></p>
      <form action="/bonusPointsExchange/actionServlet" method="post">
        <table>
        <!--  <tr>
            <td>Account</td>
            <td><input name="userName" type="text" id="userName" maxlength="40"></td>
          </tr>  -->
          <tr>
            <td>E-mail:</td>
            <td><input name="email" type="text" id="email" maxlength="40" value=<%=request.getAttribute("email") %> readonly></td>
          </tr>
          <tr>
            <td>Fullname</td>
            <td><input name="fullName" type="text" id="name" maxlength="40" value=<%=request.getAttribute("fullName") %>></td>
          </tr>
          <tr>
            <td>Tel:</td>
            <td><input name="phone" type="text" id="phone" maxlength="40" value=<%=request.getAttribute("phone") %>></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
              </td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="user" >
  		<input type="hidden" name="methodCode" value="alter_user_info">
      </form>
    </div>
    <div id="div2">
      <p class="title">Change Password <span class="title1">USER　PASSWORD</span></p>
      <form action="/bonusPointsExchange/actionServlet" onsubmit="return checkInputPasswd();">
        <table>
        <tr>
            <td>Account name:</td>
            <td><input name="name" readonly="readonly"  type="text" id="name" value="<%=session.getAttribute("userName")%>" maxlength="40" style="border:none;"></td>
          </tr>
          <tr>
            <td>Old password:</td>
            <td><input name="oldPassword" type="password" id="oldPassword" maxlength="20"></td>
          </tr>
          <tr>
            <td>New password</td>
            <td><input name="newPassword" type="password" id="newPassword" maxlength="20"></td>
          </tr>
          <tr>
            <td>Enter new password again:</td>
            <td><input name="reNewPassword" type="password" id="reNewPassword" maxlength="20" onblur="checkInputPasswd()"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="提交"></td>
              </td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="user">
        <input type="hidden" name="methodCode" value="alter_user_passwd">
      </form>
    </div>
    <div id="div3">
      <p class="title">Transfer Bonus to the platform <span class="title1">POINTS TRANSFER TO PLATFORM</span></p>
      <form action="/bonusPointsExchange/UserPointToplatformServlet"  method="post" onsubmit="return checkForm();">
        <table>
          <tr>
            <td>Select the platform:</td>
            <td><select  class="normal-font" name="shop" id="shop">
            <option selected="selected" ></option>
             <% if(null != list) {
             	System.out.println(list.size());
        		for(int i = 0; i < list.size(); i++) {
        		ShowBindInfo bindInfo = (ShowBindInfo)list.get(i);
      		 %>
             	<option><%=bindInfo.getShopName() %></option>
               <%}
        	 }%>
              </select></td>
          </tr>
           <tr>
            <td>User name registered in the merchant:</td>
            <td><input name="userName" onblur="queryUserPoints()" type="text" value="" id="userName">
            </td>
          </tr>
          <tr>
            <td>Bonus in merchant:</td>
            <td><input name="points" type="text" value="" readonly id="points" style="border:none;"> 
            </td>
          </tr>
          <tr>
            <td>Transfer Bonus:</td>
            <td><input name="transfer_points"  type="number" value="0" id="transfer_points">
            </td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
    <div id="div4">
      <p class="title">Transfer bonus to merchant<span class="title1">POINTS TRANSFER TO SHOP</span></p>
      <form action="/bonusPointsExchange/PlatformToUserServlet"  method="post" onsubmit="return checkForm();">
        <table>
          <tr>
            <td>Select merchant:</td>
            <td><select  class="normal-font" onchange="queryPointsAtPlatform()" name="shop2" id="shop2">
            <option selected="selected"></option>
              <% if(null != list) {
        			for(int i = 0; i < list.size(); i++) {
        				ShowBindInfo bindInfo = (ShowBindInfo)list.get(i);
      		 %>     			
             	<option><%=bindInfo.getShopName() %></option>
               <%}
        	 }%>
              </select></td>
          </tr>
           <tr>
            <td>User name registered in the merchant:</td>
            <td><input name="userName2" type="text" value="" id="userName2">
            </td>
          </tr>
          <tr>
            <td>Bonus in platform:</td>
            <td><input name="platformPoints" type="text" value="" readonly id="platformPoints" style="border:none;"></td>
          </tr>
          <tr>
            <td>Transfer Bonus:</td>
            <td><input name="transfer_points" type="number" value="0" id="transfer_points"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
              <td></td>
          </tr>
        </table>
      </form>
    </div>
    <div id="div5">
      <p class="title">Merchant binding<span class="title1">SHOP BIND</span></p>
      <form action="/bonusPointsExchange/BindShopQueryInfoServlet" method="post"  onsubmit="return checkBindForm();">
      <br/>
      <div> &nbsp;<span class="normal-font">Merchant name:</span>
      	<input name="search"  type="text" id="search" placeholder="Enter merchant name please"> &nbsp;&nbsp;&nbsp;
      	<input name="submit2" type="submit" class="submitBtn" id="submit2" value="Search">
      </div>
      <!------------table 中为查询结果--------每一行是一个商家---------------->
       <%
	  String shopName1 = request.getParameter("search");
	  if(shopName1 != null) {%>
      <table>
      	<tr><span id="hint" style="color:#FF0000"></span></tr>
          <tr class="normal-font">
            <td class="shop-logo"><img src="images/shopLogo/${imgURL }" alt="Merchant logo"/><p>${shopName}</p></td><td>${shopDec}</td>
            <td class="bindBtn"><a href="bindShop.jsp?shopName=${shopName}"><input name="bind" type="button" id="bind" class="buttonStyle1" value="Bind"></a></td>
          </tr>
       </table>
       <%} %>
      </form>
    </div>
    
    <div id="div6">
      <p class="title">View merchant <span class="title1">BOUND　SHOP</span></p>
      <form>
        <table>
        <% 	if(null != list) {
        	for(int i = 0; i < list.size(); i++) {
        		ShowBindInfo bindInfo = (ShowBindInfo)list.get(i);
        %>
          <tr>
            <td class="shop-logo"><img src="images/shopLogo/<%=bindInfo.getImgURL() %>" alt="Merchant's logo"/></td><td><%=bindInfo.getShopName() %></td>
            <td><input name="points" type="text" class="inputNum" id="points" value="<%=bindInfo.getPlatformPoints() %>" maxlength="20" readonly></td>
          </tr>
         <%}
          }%>
         
        </table>
      </form>
    </div>
  </div>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>

<!-- 根据返回的index显示div -->
<script type="text/javascript" language="javascript">
	var index = ${index};
	//alert(index);
	var show=parseInt(index);
	//alert(show);
	for(i=1;i<=6;i++){
		document.getElementById('div'+i).style.display = "none";
	}
	document.getElementById('div'+index).style.display = "block";
</script>


<script type="text/javascript">
/****
$(function() {
	$( "#Accordion1" ).accordion(); 
});
****/
var xmlHttp;
// 对象的创建
function createXMLHttp() {
	//alert("sasdad");//调试代码
	if (window.XMLHttpRequest) { // firefox
		xmlHttp = new XMLHttpRequest();
	} else { // ie
		xmlHttp = new ActiveXObject("microsoft.XMLHTTP");
	}
}
//=================================================//
//查询用户在商家那里有多少积分
function queryUserPoints() {
	//alert("sasdad");//调试代码
	var shopName = document.getElementById("shop").value;//此处应该是用户所属商家，后面可能要改代码
	var userName = document.getElementById("userName").value;//用户在商家注册的用户名
	//alert(userName);
	var url = "/bonusPointsExchange/QueryUserPoints?shop="+encodeURI(encodeURI(shopName))+"&userNameAtShop="+encodeURI(encodeURI(userName));
	createXMLHttp();
	xmlHttp.onreadystatechange = queryUserPointsBack;
	xmlHttp.open("get", url, true);
	xmlHttp.send(null);
}
// 回调函数,处理服务器返回结果
function queryUserPointsBack() {
	// alert(xmlHttp.readyState);
	// 响应已完成
	if (xmlHttp.readyState == 4) {
		// 服务器正常的响应
		// alert(xmlHttp.status);
		if (xmlHttp.status == 200) {
			var returnMsg = xmlHttp.responseText; // 收取服务器端的响应信息(String)
			//alert(returnMsg);
			document.getElementById("points").value = returnMsg;
		}
	}
}

//=================================================//
//查询用户在品台数据库有多少积分
function queryPointsAtPlatform() {
	var shopName = document.getElementById("shop2").value;
	//alert(shopName);//调试代码
	var url = "/bonusPointsExchange/QueryPointsAtPlatform?shop="+encodeURI(encodeURI(shopName));
	createXMLHttp();
	xmlHttp.onreadystatechange = queryPointsAtPlatformBack;
	xmlHttp.open("get", url, true);
	xmlHttp.send(null);
}
// 回调函数,处理服务器返回结果
function queryPointsAtPlatformBack() {
	//alert("aaaaaa");
	// 响应已完成
	if (xmlHttp.readyState == 4) {
		// 服务器正常的响应
		// alert(xmlHttp.status);
		if (xmlHttp.status == 200) {
			var returnMsg = xmlHttp.responseText; // 收取服务器端的响应信息(String)
			//alert(returnMsg);
			document.getElementById("platformPoints").value = returnMsg;
		}
	}
}

function showDiv(index) {   
var show=parseInt(index);
for(i=1;i<=6;i++){
		document.getElementById('div'+i).style.display = "none";
	}
	document.getElementById('div'+index).style.display = "block";
	if(show == 1){
		//查询用户个人信息
		location.href="/bonusPointsExchange/actionServlet?actionCode=user&methodCode=query_user_info&index="+1;
	}
	if(show == 3) {
		//查询用户绑定的商家的相关信息，显示在select中
		location.href = "/bonusPointsExchange/QueryBindedShopNameServlet?index="+3;
	}
	if(show == 4) {
		//查询用户绑定的商家的相关信息，显示在select中
		location.href = "/bonusPointsExchange/QueryBindedShopNameServlet?index="+4;
	}
	if(show == 5) {
		//location.href = "/bonusPointsExchange/QueryBindInfo";
	}
	if(show == 6) {
		location.href = "/bonusPointsExchange/QueryBindInfo";
	}
}
function checkInputPasswd(){
	var newPassword = document.getElementById("newPassword").value;
	var reNewPassword = document.getElementById("reNewPassword").value;
	if(newPassword!=reNewPassword){
		alert("The two new passwords you entered are inconsistent");
		return false;
	}else return true;
	
}

function checkForm() {
	
	var shop = document.getElementById("shop").value;
	var shop2 = document.getElementById("shop2").value;
	//alert(shopName);
	if (shop == "" && shop2 == "") {
		alert("Select the merchant please");
		return false;
	}
	
	//商家名不能空
	var userName = document.getElementById("userName").value;
	var userName2 = document.getElementById("userName2").value;
	//alert(shopName);
	if (userName == "" && userName2=="" ) {
		alert("The name registered in the Merchant cannot be empty!");
		return false;
	}
	
	var transfer_points = document.getElementById("transfer_points").value;
	if (transfer_points == "") {
		alert("Transfer Bonus cannot be empty!");
		return false;
	}
 }
 
 function checkBindForm() {
	var shop2 = document.getElementById("search").value;
	//alert(shopName);
	if (shop2 == "") {
		alert("Enter the Merchant name please!");
		return false;
	}
}
</script>
</body>
</html>
