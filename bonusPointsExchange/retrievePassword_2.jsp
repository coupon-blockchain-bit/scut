<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<% String userName =request.getParameter("userName");
	userName= new String(userName.getBytes("ISO-8859-1"),"utf-8");

	%> 
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Forgot Password</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link href="css/regist.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
//表单验证
function checkForm() {
	// alert("ada");
	var userName = document.getElementById("userName").value;
	if (userName == "" || userName == null) {
		alert("UserName cannot be empty");
		return false;
	}
	
	var password = document.getElementById("password").value;
	if (password == "") {
		alert("Password cannnot be empty");
		return false;
	}
	
	var repassword = document.getElementById("repassword").value;
	if (repassword == "") {
		alert("Confirm password cannot be empty");
		return false;
	}
	if(password != repassword){
	    alert("The password input is inconsistent twice!");
	    return false;
	}
}
</script>
</head>

<body>
<!--header -->
	<%@ include file="header.jsp" %>
<!--header -->
<div class="repsw-form">
<div class="retrieve">
  <p class="title">Retrieve password&nbsp;&nbsp;&nbsp;&nbsp;<span class="title1">RETRIEVE PASSWORD</span> <span class="title1 right"><a href="login.jsp">Log in now</a>&nbsp;&nbsp;&nbsp;</span></p>
   <div><span id="step-title1" style="color:grey;">STEP1:safety verification</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="step-title2" style="color:blue;">STEP2:Reset password</span></div>
      <div id="step2">
      <form action="/bonusPointsExchange/actionServlet" method="post" onsubmit="return checkForm();">
      <table>
      	  <tr>
      	    <td>Account:</td>
            <td><input name="userName" type="userName" id="userName" value="<%=userName %>" maxlength="20"></td>
          </tr>	
          <tr>
            <td>New password</td>
            <td><input name="newPassword" type="password" id="password" maxlength="20"></td>
          </tr>
          <tr>
            <td>Password again:</td>
            <td><input name="rePassword" type="password" id="repassword" maxlength="20"></td>
          </tr> 
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
          </tr>
        </table>
        <input type="hidden" name="actionCode" value="resetPasswd">
        <input type="hidden" name="methodCode" value=<%=request.getParameter("method") %>>
        </form>
      </div>
    </div>
</div>
</
<!--footer -->
	<%@ include file="footer.jsp" %>
</body>
</html>
