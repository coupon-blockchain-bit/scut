<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.bit.bonusPointsExchange.bean.Order"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	List<Order> latestOrderInfoList = (List<Order>)request.getAttribute("latestOrderInfo");//最新发布的订单
%>

<%
  String exchangeRes = (String)request.getAttribute("exchangeRes");  //获取积分兑换是否成功
  if(exchangeRes == "false") {
%>
  <script type="text/javascript" language="javascript">
    alert("Exchange of bonus failed.");                            
  </script> 
<% } else if(exchangeRes == "true") {%>
  <script type="text/javascript" language="javascript">
    alert("The exchange of bonus succeed!");                                      
  </script> 
<% }else if(exchangeRes == "连接blockchain失败，请检查网络") {%>
  <script type="text/javascript" language="javascript">
    alert("连接blockchain失败，请检查网络！");                                      
  </script> 
<% }%>
<%
  String isBindShopName = (String)request.getAttribute("isBindShopName");  //获取商家是否绑定
  if(isBindShopName == "false") {
%>
  <script type="text/javascript" language="javascript">
    alert("No merchant was bound.");                            
  </script> 
<% }%>
<%
  String isBindWantedShop = (String)request.getAttribute("isBindWantedShop");  //获取目标商家是否绑定
  if(isBindWantedShop == "false") {
%>
  <script type="text/javascript" language="javascript">
    alert("You're not bound to the target merchant.");                            
  </script> 
<% }%>
<%
  String isPointEnough = (String)request.getAttribute("isPointEnough");  //获取商家积分是否足够用来交易
  if(isPointEnough == "no") {
%>
  <script type="text/javascript" language="javascript">
    alert("Your bonus in the merchant isn't enough!");                            
  </script> 
<% }%>

<%
//用户和商家需登录之后才能查看最新发布
String userName = (String)request.getSession().getAttribute("userName");
String shopName = (String)request.getSession().getAttribute("shopName");	
if(userName == null && shopName == null) { %>
	<script type="text/javascript" language="javascript">
		alert("You have not log on.Please log on first.");    // 弹出错误信息
		window.location.href="/bonusPointsExchange/login.jsp" ;                             
	</script>	
<% } %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Latest deal</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/order.css">
</head>

<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="exchangeOrder">
    <p class="title">Recently released<span class="title1">&nbsp;&nbsp;&nbsp;REALEASE RECENTLY</span></p>
  <div id="order-list" class="clearfix"> 
    <!---- 事例1------>
    <div class="order-info clearfix">
     <% if(null != latestOrderInfoList) {
             //System.out.println(latestOrderInfoList.size());
            for(int i = 0; i < latestOrderInfoList.size(); i++) {
           	 Order orderInfo = (Order)latestOrderInfoList.get(i);
      %>
    <form action= "/bonusPointsExchange/FinishLatestOrder" method="post" onsubmit="return checkShop();">
      <ul class="clearfix">
        <li class="shop-logo"><img src="images/shopLogo/defaultIcon.jpg"/></li>
        <li class="exchangeOrder-info">
          <table>
            <tr>
              <td>Merchant&nbsp;:<%=orderInfo.getShopName()%></td>
            </tr>
            <tr>
              <td>amount of bonus:<%=orderInfo.getPoint()%></td>
            </tr>
            <tr>
             <td>publisher of order:<%=orderInfo.getUserName() %></td>
            </tr> 
          </table>
        </li>  
        <li><img src="images/2.png"/></li>
        <li>&nbsp;&nbsp;</li>
        <li class="shop-logo" rowspan="3"><img src="images/shopLogo/defaultIcon.jpg"/></li>
        <li class="exchangeOrder-info">
          <table>
            <tr>
              <td>merchant in target:<%=orderInfo.getWantedShop()%></td>
            </tr>
            <tr>
              <td>amount of bonus in target:<%=orderInfo.getWantedPoint()%></td>
            </tr>
            <tr>
              <td>Deadline:<%=orderInfo.getUntilDate()%></td>
            </tr> 
          </table>
        </li>        
        <%if(orderInfo.getUserName().equals(isUserLogin)) { %>
        <li class="operate">
          <input name="exchange" type="button" style="background:#EDEDED;" disabled="disabled" class="submitBtn"  id="exchange" value="Deal">
        </li>
        <%} else {%>
         <li class="operate">
          <input name="exchange" type="submit" class="submitBtn"  id="exchange" value="Deal">
        </li>
        <%} %>
        <input type="hidden" name="orderID" value="<%=orderInfo.getOrderID()%>"/>
        <input type="hidden" name="actionCode" value="order"/>
      	<input type="hidden" name="methodCode" value="finsh_order"/>     	
      </ul>
     </form>
    <%} %>
  <%} else {%>
       <br/><br/><br/><p align="center"> Search result is 0! </p>
 <%} %>
    </div>
  </div>
   <input type="hidden" name="session" id="session" value="<%=session.getAttribute("shopName") %>"/>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>
</body>

<script type="text/javascript">
function checkShop() {
	var shop = document.getElementById("session").value;
	if (shop != "null") {
		alert("Merchant type account cannot carry out a transaction.Please replace the user type account.");
		return false;
	}
}
</script>
-->
</html>
