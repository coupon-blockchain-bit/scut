<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!--这是top-->
<div class="header">
  <div class="span1">
    <div class="logo"><img src="images/logo.png" alt="Bonus exchange platform"/></div>
  </div>
  <div class="span2">
    <div class="mainNav">
      <ul>
        <li><a href="index.jsp">Homepage</a></li>
        <li><a href="reference.jsp">Reference price</a></li>
        <li><a href="/bonusPointsExchange/QueryLatestOrder">Newly released</a></li>
        <li><a href="/bonusPointsExchange/actionServlet?actionCode=bindShop&methodCode=find_bindedShops">Initiate transaction</a></li>
    <%
	String isUserLogin = (String)session.getAttribute("userName"); 
	String isShopLogin = (String)session.getAttribute("shopName"); 
	if(isUserLogin == null && isShopLogin == null) {
	%>
	<li><a href="login.jsp">My account</a> </li>
<% } else if(isUserLogin != null && isShopLogin == null){%>
	 <li  style="font-size:24px;">
	<a href="/bonusPointsExchange/actionServlet?actionCode=user&methodCode=query_user_info"><%=session.getAttribute("userName") %></a><a href="/bonusPointsExchange/actionServlet?actionCode=log&methodCode=logout&logType=user"><span style="font-size:24px;">|Logout</span></a></li>	
	 <% } else if(isShopLogin != null && isUserLogin == null){%>
	 <li style="font-size:24px;">
	<a href="/bonusPointsExchange/QueryShopInfoServlet"><%=session.getAttribute("shopName") %></a><a href="/bonusPointsExchange/actionServlet?actionCode=log&methodCode=logout&logType=shop"><span style="font-size:24px;">|Logout</span></a></li>	
<% }%>

     </ul>
    </div>
  </div>
</div>