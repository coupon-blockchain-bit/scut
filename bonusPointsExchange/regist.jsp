<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>用户注册</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link href="css/regist.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
//表单验证
function checkForm() {
	// alert("ada");
	var userName = document.getElementById("userName").value;
	if (userName == "") {
		alert("Account name cannot be empty");
		return false;
	}
	
	var password = document.getElementById("password").value;
	if (password == "") {
		alert("Password cannot be empty.");
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
		alert("Confirm password cannot be empty.");
		return false;
	}
	if(password !=repassword){
	    alert("Password entered twice inconsistently");
	    return false;
	}
	
	var email = document.getElementById("email").value;
	if (email == "") {
		alert("E-mail cannot be empty");
		return false;
	}
	if(!checkEmail(email)) {
		alert("E-mail format is incorrect!");
		return false;
	}
	
	var fullName = document.getElementById("fullName").value;
	if (fullName == "") {
		alert("Full name cannot be empty");
		return false;
	}
	
	var phone = document.getElementById("phone").value;
	if (phone == "") {
		alert("Tel number cannot be empty");
		return false;
	}
	
}
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
</script>
</head>

<body>
	<%@ include file="header.jsp" %>
<!--header -->
<div class="regist-frame">
  <p class="title">&nbsp;&nbsp;User registration&nbsp;&nbsp;<span class="title1">USER REGISTER</span><span class="title1 right"><a href="regist_shop.jsp">Go to the merchant registration</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
  <div>
    <div class="span5">
      <form name="form_regist" action="/bonusPointsExchange/actionServlet" method="post" onsubmit="return checkForm();">
        <table>
          <tr>
            <td>Account:</td>
            <td><input name="userName" type="text" id="userName" maxlength="20"></td>
          </tr>
          <tr>
            <td>Password:</td>
            <td><input name="passwd" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td>Password again:</td>
            <td><input name="repassword" type="password" id="repassword" maxlength="20"></td>
          </tr>
          <tr>
            <td>E-mail:</td>
            <td><input name="email" type="text" id="email" maxlength="40"></td>
          </tr>
          <tr>
            <td>Fullname:</td>
            <td><input name="fullName" type="text" id="fullName" maxlength="20"></td>
          </tr>
          <tr>
            <td>Tel:</td>
            <td><input name="phone" type="text" id="phone" maxlength="20"></td>
          </tr>
          <tr>
            <td class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
            <td class="mid"><input name="reset" type="reset" class="submitBtn" id="reset" value="Reset"></td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="regist">
       
      </form>
    </div>
    <div class="span6">
      <div class="tips">
        <p class="tips-font1">Register and enjoy</p>
        Free exchange of Bonus
        <br/><br/>
        <p class="tips-font1">Already have an account?</p>
       Sign in now to experience points trading! <a href="login.jsp">Log in Now </a></div>
    </div>
  </div>
</div>

<!--footer -->
	<%@ include file="footer.jsp" %>
</body>
</html>
