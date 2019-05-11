<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
  String newOrder = (String)request.getAttribute("newOrder");  //是否有最新完成的一笔交易
  if(newOrder == "N") {
%>
  <script type="text/javascript" language="javascript">
    alert("The business you selected does not have the latest transaction history now!");                            
  </script> 
<% }%>

<%
//用户和商家需登录之后才能查看最新发布
String userName = (String)request.getSession().getAttribute("userName");
String shopName = (String)request.getSession().getAttribute("shopName");	
if(userName == null && shopName == null) { %>
	<script type="text/javascript" language="javascript">
		alert("You are not logged in yet! please sign in!");    // 弹出错误信息
		window.location.href="/bonusPointsExchange/login.jsp" ;                             
	</script>	
<% }%>

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Reference Price</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/order.css">
</head>

<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="referenceOrder">
  <div>
    <p class="title">Reference Price<span class="title1">&nbsp;&nbsp;&nbsp;REFERENCE PRICE</span></p>
  </div>
  <%if(request.getAttribute("shopName") == null) { %>
  <div> &nbsp;	
 	 <form action="/bonusPointsExchange/ReferencePriceServlet" method="post" onsubmit="return checkForm();">
      	Merchant name:<input name="search1" value="" type="text" id="search1" placeholder="Enter merchant name please"> &nbsp;&nbsp;&nbsp;
      	Target merchant name:<input name="search2" value="${wantedShop }" type="text" id="search2" placeholder="Enter merchant name please"> &nbsp;&nbsp;&nbsp;
      	<input name="submit2" type="submit" class="submitBtn" id="submit2" value="search">
      </form>
  </div>
  <% } else {%>
  <div> &nbsp;	
 	 <form action="/bonusPointsExchange/ReferencePriceServlet" method="post">
      	Merchant name:<input name="search1" value="${shopName }" type="text" id="search1" placeholder="Enter merchant name please"> &nbsp;&nbsp;&nbsp;
      	Target merchant name:<input name="search2" value="${wantedShop }" type="text" id="search2" placeholder="Enter merchant name please"> &nbsp;&nbsp;&nbsp;
      	<input name="submit2" type="submit" class="submitBtn" id="submit2" value="Search">
      </form>
  </div>
  <%} %>
    <%
	  String shopName1 = request.getParameter("search1");
	  String wantedShop1 = request.getParameter("search2");
	  System.out.println(shopName);
	  if(shopName1 != null && wantedShop1 !=null && newOrder != "N") {%>
  <div class="referenceInfo">
    <table>
      <tr>
        <td rowspan="3" class="table-td-img"><img src="images/shopLogo/${ShopImgURL }"/><p>${shopName }</p></td>
        <td>Latest ratio: ${latestRate }</td>
        <td rowspan="3" class="table-td-img"><img src="images/shopLogo/${wantedShopImgURL }"/><p>${wantedShop }</p></td>
      </tr>
      <tr><td>Provide Bonus: ${point }<img src="images/2.png"/> Exchange bonus: ${wantedPoint }</td></tr>
      <tr><td>Average ratio: ${averageRate }</td></tr>
    </table>
     <%}%>
  </div>
  <p>&nbsp;</p>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>
	
<script type="text/javascript">
function checkForm() {
	//商家名不能空
	var shopName = document.getElementById("search1").value;
	//alert(shopName);
	if (shopName == "") {
		alert("Merchant name cannot be empty");
		return false;
	}
	
	var wantedShop = document.getElementById("search2").value;
	if (wantedShop == "") {
		alert("Target merchant name cannot be empty");
		return false;
	}
 }
</script>
</body>
</html>
