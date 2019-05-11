<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Merchant registration</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link href="css/regist.css" rel="stylesheet" type="text/css">
</head>

<body>
	<%@ include file="header.jsp" %>
<!--header -->
<div class="regist-frame">
<p class="title">&nbsp;&nbsp;Merchant registration&nbsp;&nbsp;<span class="title1">USER REGISTER</span><span class="title1 right"><a href="regist.jsp">Go to user registration&nbsp;&nbsp;&nbsp;&nbsp;</a></span></p>
  <div>
    <div class="span5">
      <form onsubmit="return checkForm();" method="post" action="/bonusPointsExchange/RegistShopServlet">
        <table>
          <tr>
            <td>Merchant name:</td>
            <td><input name="shopName" type="text" id="shopName" maxlength="20"  onblur="checkShopName();"></td>
            <td><span id="hint" style="color:#FF0000; font-size:12px;" >&nbsp;&nbsp;&nbsp;</span></td>
          </tr>
          <tr>
            <td>Password:</td>
            <td><input name="password" type="password" id="password" maxlength="20"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>Confirm password:</td>
            <td><input name="repassword" type="password" id="repassword" maxlength="20"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>E-mail:</td>
            <td><input name="email" type="text" id="email" maxlength="40"></td>
            <td><span id="hint" style="color:#FF0000">&nbsp;</span></td>
          </tr>
          <tr>
            <td>Merchant record number:</td>
            <td><input name="number" type="text" id="number" maxlength="40"></td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
            <td class="mid"><input name="reset" type="reset" class="submitBtn" id="reset" value="Reset"></td>
          </tr>
        </table>
      </form>
    </div>
    <div class="span6">
      <div class="tips">
        <p class="tips-font1">Register and enjoy</p>
        View merchant bonus transactions
        <br/><br/>
        <p class="tips-font1">Already have an account?</p>
        Sign in now to trade bonus. <a href="login_shop.jsp"> Sign in to your Merchant now </a></div>
    </div>
  </div>
</div>

<!--footer -->
	<%@ include file="footer.jsp" %>

<!--js代码====================================================-->
<script type="text/javascript">

//邮箱格式校验
function checkEmail(email) {
	var str = email;
	var expression = /^[a-zA-Z0-9_-]+(\.([a-zA-Z0-9_-])+)*@[a-zA-Z0-9_-]+[.][a-zA-Z0-9_-]+([.][a-zA-Z0-9_-]+)*$/;
	var objExp = new RegExp(expression);
	if(objExp.test(str)) {
		return true;
	}
	else {
		return false;
	}
}

//表单验证
function checkForm() {
	// alert("ada");
	var shopName = document.getElementById("shopName").value;
	if (shopName == "") {
		alert("Merchant name cannot be empty");
		return false;
	}
	
	var password = document.getElementById("password").value;
	if (password == "") {
		alert("Password cannot be empty");
		return false;
	}
	
	//密码需在6位以上，只能为数字和字母的组合
	var Reg=/^[0-9A-Za-z]{6,}$/;
  	if(password!=""&&!Reg.test(password)){
     alert("The password can only be letters or numbers, length 6 and above!");
     return false;
	}
	
	var repassword = document.getElementById("repassword").value;
	if (repassword == "") {
		alert("Confirm password cannot be empty");
		return false;
	}

	if (password != repassword) {
		alert("The passwords are inconsistent twice!");
		return false;
	}
	
	var email = document.getElementById("email").value;
	if(!checkEmail(email)) {
		alert("E-mail format is incorrect!");
		return false;
	}
	//备案号问题待解决
	var number = document.getElementById("number").value;
	if (number == "") {
		alert("The record number cannot be empty!");
		return false;
	}
	return true;
}


var xmlHttp;
function createXmlHttp() {
	 //alert("dasdasd");//调试代码
	if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	} else {
		xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
}
function checkShopName() {
	createXmlHttp();
	var shopName;
	shopName = document.getElementById("shopName").value;
	//alert(shopName);//调试代码
	// 发送请求，设置属性，请求返回时交给回调函数处理
	//alert(userName);
	xmlHttp.open("post","/bonusPointsExchange/CheckShopName?shopName="+encodeURI(encodeURI(shopName)));
	//alert(userName);
	xmlHttp.onreadystatechange = checkShopNameBack;
	xmlHttp.send(null);
	
} 
function checkShopNameBack() {
	// 具体处理
	// 数据返回完毕
	if(xmlHttp.readyState == 4) {
		//alert(xmlHttp.status);
		// HTTP操作正常
		if(xmlHttp.status == 200) {
			//alert("Normal");
			var text = xmlHttp.responseText;
			if(text == "Y") {
				document.getElementById("hint").innerHTML = "";	
				document.getElementById("submit").disabled = "";
			}
			if(text == "N") {
				document.getElementById("hint").innerHTML = "Account already exists";	
				document.getElementById("submit").disabled = "disabled";
			}
		}
		
	}
}
</script>
</body>
</html>

