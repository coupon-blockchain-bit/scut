<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
//商家需登录之后才能修改xiangguan信息
String oldShopName = (String)request.getSession().getAttribute("shopName");	
if(oldShopName == null) { %>
	<script type="text/javascript" language="javascript">
		alert("You are not logged in yet! please sign in!");    // 弹出错误信息
		window.location.href="/bonusPointsExchange/login_shop.jsp" ;                             
	</script>	
<% }%>


<%
	String shopChangeResult = (String)request.getAttribute("shopChangeResult");  //获取修改商家信息是否成功
	if(shopChangeResult == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("The information was modified successfully!");                                    // 弹出错误信息
	</script>	
<% } else if(shopChangeResult == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("Information modification failed!");                                    
	</script>	
<% }%>

<%
String shopChangePwdResult = (String)request.getAttribute("shopChangePwdResult");  //获取修改商家密码是否成功
if(shopChangePwdResult == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("Password modification failed!");                                    
	</script>	
<% }%>

<%
	String uploadRes = (String)request.getAttribute("uploadRes");  //获取上传头像是否成功
	if(uploadRes == "Y") {
%>
	<script type="text/javascript" language="javascript">
		alert("Avatar was uploaded successfully!");                                    // 弹出错误信息
	</script>	
<% } else if(uploadRes == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("Avatar upload failed!");                                    
	</script>	
<% }%>

<%
String uploadTypeErr = (String)request.getAttribute("uploadTypeErr");  //上传图像类型错误
if(uploadTypeErr == "N") {%>
	<script type="text/javascript" language="javascript">
		alert("Can only upload images of jpg, png, gif, bmp type");                                   
	</script>	
<% }%>

<!doctype html>
<html>
<head>
<style type="text/css">
#mask{ 
	background-color:#ccc;
	opacity:0.5;
	filter: alpha(opacity=50); 
	position:absolute; 
	left:0;
	top:0;
	z-index:1000;
	}
</style>
<meta charset="utf-8">
<title>Merchant Center</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/personal.css">
<link href="jQueryAssets/jquery.ui.core.min.css" rel="stylesheet" type="text/css">
<link href="jQueryAssets/jquery.ui.theme.min.css" rel="stylesheet" type="text/css">
<link href="jQueryAssets/jquery.ui.accordion.min.css" rel="stylesheet" type="text/css">
<link href="jQueryAssets/jquery.ui.button.min.css" rel="stylesheet" type="text/css">
<script src="jQueryAssets/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="jQueryAssets/jquery-ui-1.9.2.accordion.custom.min.js" type="text/javascript"></script>
<script src="jQueryAssets/jquery-ui-1.9.2.button.custom.min.js" type="text/javascript"></script>
</head>
<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="personal">
  <div class="span7">
    <div id="Accordion1" class="nav" style="height:200px;">
      <h3><a href="#">Merchant information</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(1)">Modify information</a></p>
        <p><a href="javascript:showDiv(2)">Modify Password</a></p>
      </div>
 <!--
      <h3><a href="#">Commercialize</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(3)">Add an ad</a></p>
        <p><a href="javascript:showDiv(4)">Bonus Mall</a></p>
      </div>
-->
      <h3><a href="#">Intelligent analysis</a></h3>
      <div class="index">
        <p><a href="javascript:showDiv(3)">User volume analysis</a></p>
        <p><a href="javascript:showDiv(4)">Bonus change analysis</a></p>
      </div>
    </div>
  </div>
  <div class="span8">
    <div id="div1">
      <p class="title">Merchant's information <span class="title1">USER INFOMATION</span></p>
        <table>
         <tr>
            <td>Merchant Icon:</td>
            <td class="mid">            
             <form id="icon" enctype="multipart/form-data" method="post" action="/bonusPointsExchange/UploadIconServlet">
             	<img alt="头像" src="images/shopLogo/<%=request.getAttribute("imageURL") %>" width="80px" height="60px" />                
                 <input style="display: none;" type="file" title="上传头像" name="fileField" id="fileField" onchange="fileSelected();">
                 <input type="submit" id="uploadBtn" hidefocus="true" value="Upload" />
             </form>                                          
			</td>
          </tr>
         <form onsubmit="return checkForm();" action="/bonusPointsExchange/ShopChangeInfo" method="post">
          <tr>
            <td>Merchant's name</td>
            <td><input name="name" readonly="readonly"  type="text" id="name" value="<%=session.getAttribute("shopName")%>" maxlength="40" style="border:none;"></td>
          </tr>
          <tr>
            <td>E-mail:</td>
            <td><input name="email" type="text" id="email" value="<%=request.getAttribute("email")%>" maxlength="40"></td>
          </tr>
          <tr>
            <td>Tel:</td>
            <td><input name="phone" type="text" id="phone" value="<%=request.getAttribute("telephone")%>" maxlength="40"></td>
          </tr>
          <tr>
            <td>Introduction：</td>
            <td><input name="description" type="textarea" id="description" value="<%=request.getAttribute("shopDec")%>" maxlength="40"></td>
          </tr>
          <tr>
            <td colspan="2"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td   
          ></tr>
          </form>
        </table>
      
    </div>
    <div id="div2">
      <p class="title">Change password <span class="title1">SHOP　PASSWORD</span></p>
      <form onsubmit="return changePawcheckFrom();" method="post" action="/bonusPointsExchange/ShopChangePwdServlet">
        <table>
          <tr>
            <td>Account:</td>
            <td><input name="userName" type="text" class="no-border" id="userName" value="<%=session.getAttribute("shopName")%>" maxlength="20" readonly></td>
          </tr>
         <!--<tr>
            <td>Old password</td>
            <td><input name="oldPassword" type="password" id="oldPassword" maxlength="20"></td>
          </tr>
          -->
          <tr>
            <td>New password</td>
            <td><input name="newPassword" type="password" id="newPassword" maxlength="20"></td>
          </tr>
          <tr>
            <td>Enter the new password again:</td>
            <td><input name="reNewPassword" type="password" id="reNewPassword" maxlength="20"></td>
          </tr>
          <tr>
            <td colspan="2" ><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
<!--
    <div id="div3">
      <p class="title">Add an ad<span class="title1">ADD ADVERTISEMENT</span></p>
      <form>
        <table>
          <tr>
            <td>Ad Headline</td>
            <td><input name="adName" type="text" class="adName" id="adName"  maxlength="40"></td>
          </tr>
          <tr>
            <td>Ad picture&nbsp;：</td>
            <td class="mid"><input name="selectImage" type="submit" class="submitBtn" id="selectImage" value="Select"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
    <div id="div4">
      <p class="title">Bonus Mall<span class="title1">POINTS SHOP</span></p>
      <form>
        <table>
          <tr>
            <td>Mall URL:</td>
            <td><input name="url" type="text" class="inputUrl" id="url"></td>
          </tr>
          <tr>
            <td colspan="2" class="mid"><input name="submit" type="submit" class="submitBtn" id="submit" value="Submit"></td>
              </td>
          </tr>
        </table>
      </form>
    </div>
-->
    <div id="div3">
      <p class="title">User volume analysis<span class="title1">USER AMOUNT ANALYSIS</span></p>
      <h3 style="text-align: center">User change line chart weekly</h3>

    </div>
    <div id="div4">
      <p class="title">Bonus change analysis<span class="title1">POINTS ANALYSIS</span></p>
      <table>
          <td>Today's points(in):</td>
          <td><input name="inPoint" type="text" id="inPoint" class="no-border" value="0" maxlength="40" readonly></td>
        </tr>
        <tr>
          <td>Today's points(out):</td>
          <td><input name="outPoint" type="text" id="outPoint" class="no-border" value="0" maxlength="40" readonly></td>
        </tr>
      </table>
      <h3 style="text-align: center">Bonus change table</h3>
    </div>
  </div>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>




<script type="text/javascript">
/****
$(function() {
	$( "#Accordion1" ).accordion(); 
});
***/
function showDiv(index){   
var show=parseInt(index);
for(i=1;i<=4;i++){
	document.getElementById('div'+i).style.display = "none";}
	document.getElementById('div'+index).style.display = "block";
} 

//修改密码的表单验证
function changePawcheckFrom() {
	
	var oldPassword = document.getElementById("oldPassword").value;
	if (oldPassword == "") {
		alert("Old password cannot be empty");
		return false;
	}
	
	
	var newPassword = document.getElementById("newPassword").value;
	if (newPassword == "") {
		alert("New password cannot be empty");
		return false;
	}
	//密码需在6位以上，只能为数字和字母的组合
	var Reg=/^[0-9A-Za-z]{6,}$/;
  	if(newPassword!=""&&!Reg.test(newPassword)){
     alert("Passwords can only be entered as letters or numbers, length6or more!");
     return false;
	}
	
	var reNewPassword = document.getElementById("reNewPassword").value;
	if (reNewPassword == "") {
		alert("Confirm password(Again password)cannot be empty");
		return false;
	}

	if (newPassword != reNewPassword) {
		alert("The password must be the same twice!");
		return false;
	}
	return true;
}



//修改商家信息的表单验证
function checkForm() {
	
	//商家名不能空
	var shopName = document.getElementById("name").value;
	//alert(shopName);
	if (shopName == "") {
		alert("Merchant's name cannot be empty.");
		return false;
	}
	//邮箱格式要正确
	var email = document.getElementById("email").value;
	//alert(email);
	var expression = /^[a-zA-Z0-9_-]+(\.([a-zA-Z0-9_-])+)*@[a-zA-Z0-9_-]+[.][a-zA-Z0-9_-]+([.][a-zA-Z0-9_-]+)*$/;
	var objExp = new RegExp(expression);
	if(!objExp.test(email)) {
		alert("E-mail format is incorrect!");
		return false;
	}
	//电话号码格式要正确
	/*验证固定电话号码
 	 0\d{2,3}   代表区号   
 	 [0\+]\d{2,3}   代表国际区号
	 \d{7,8} 代表7－8位数字(表示电话号码)
 	正确格式：区号-电话号码-分机号(全写|只写电话号码)
	*/
	var reg=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)?(\d{7,8})(-(\d{3,}))?$/; 
	var telephone = document.getElementById("phone").value;
	//alert(telephone);
	if(telephone != ""&&!reg.test(telephone)){
 		alert('The phone number format is entered incorrectly!');
 		return false;
	}
	return true;
}
//弹出一个网页，以对话框的形式弹出
function openwindow(){ 
        window.showModalDialog("uploadBox.jsp",window,"dialogWidth:360px;dialogHeight:200px");
      }     

function openNew(){
	/*//获取页面的高度和宽度
	var sWidth=document.body.scrollWidth;
	var sHeight=document.body.scrollHeight;
	//获取页面的可视区域高度和宽度
	var wHeight=document.documentElement.clientHeight;
	//遮罩层
	var oMask=document.createElement("div");
		oMask.id="mask";
		oMask.style.height=sHeight+"px";
		oMask.style.width=sWidth+"px";
		document.body.appendChild(oMask);
	//弹出文件选择对话框
	document.getElementById("fileField").click();
	
	//点击遮罩层，取消遮罩	
	oMask.onclick=function(){
		document.body.removeChild(oMask);
	};
	//关闭文件对话框关闭遮罩,这里不知道怎么获取文件打开对话框关闭的事件，所以取消了遮罩这部分
	document.getElementById("fileField").ondestroy=function(){
		document.body.removeChild(oMask);
	};*/
	
	document.getElementById("fileField").click();
}

window.onload=function(){
		var oBtn=document.getElementById("uploadBtn");
			//点击shangchuan按钮
			oBtn.onclick=function(){
				openNew();
				return false;
		}
}

 function fileSelected() {
  	//var str = document.getElementById("fileField").value;//选择的文件路径
 	document.getElementById("icon").submit();
 }
</script>
</body>
</html>


