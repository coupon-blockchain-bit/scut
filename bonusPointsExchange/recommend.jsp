<%@page import="com.bit.bonusPointsExchange.bean.Shop"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%@page import="com.bit.bonusPointsExchange.bean.Order"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%
	Vector<Vector<Integer>> recOrderIdList = (Vector<Vector<Integer>>)request.getAttribute("recOrderIdList");//智能推荐的所有可能路径的所有orderId
//	String shopName = (String)request.getAttribute("shopName");
//	String wantedShop = (String)request.getAttribute("wantedShop");
	List<Integer> recPoints =(List<Integer>)request.getAttribute("recPoints");
	List<Integer> recWantedPoints =(List<Integer>)request.getAttribute("recWantedPoints");	
	Shop recShop = (Shop)request.getAttribute("recShop");
	Shop recWantShop = (Shop)request.getAttribute("recWantShop");
%>
<%
	String finishOrderRes = (String)request.getAttribute("finishOrderRes"); //兑换积分的返回信息
	if(finishOrderRes=="您未绑定目标商家！"){
%>
  <script type="text/javascript" language="javascript">
    alert("您未绑定目标商家！请绑定目标商家！"); 
	location.href="/bonusPointsExchange/QueryBindedShopNameServlet?index="+5;  
  </script> 
<%}else if(finishOrderRes=="您未绑定商家！") {%>
 <script type="text/javascript" language="javascript">
    alert("您未绑定商家！请绑定商家！");     
   location.href="/bonusPointsExchange/QueryBindedShopNameServlet?index="+5;                      
  </script> 
<%}else if(finishOrderRes=="您在商家的积分不够！"){ %>
 <script type="text/javascript" language="javascript">
    alert("您在商家的积分不够！请转移积分到平台！");          
    location.href="/bonusPointsExchange/QueryBindedShopNameServlet?index="+3;    
  </script>   
<%}else if(finishOrderRes=="积分兑换成功！"){ %>
 <script type="text/javascript" language="javascript">
    alert("积分兑换成功!");                            
    location.href="/bonusPointsExchange/actionServlet?actionCode=order&methodCode=findAllOrder&selectSort=null";
  </script>     
<%}else if(finishOrderRes=="积分兑换失败！"){ %>
 <script type="text/javascript" language="javascript">
    alert("积分兑换失败！");                            
    location.href="/bonusPointsExchange/actionServlet?actionCode=order&methodCode=findAllOrder&selectSort=null";
  </script>    
 <%}else if(finishOrderRes=="连接blockchain失败，请检查网络！"){ %>
 <script type="text/javascript" language="javascript">
    alert("连接blockchain失败，请检查网络！");            
    location.href="/bonusPointsExchange/actionServlet?actionCode=order&methodCode=findAllOrder&selectSort=null";
  </script>   
<%} else if(finishOrderRes=="需要绑定中间商家"){
		String recBindShops = (String)request.getAttribute("recBindShops");
		System.out.println("jsp"+recBindShops);%>
 <script type="text/javascript" language="javascript">
 var recBindShops1= "<%=recBindShops%>";
    alert("推荐您绑定"+recBindShops1+"才能完成此交易！");            
    location.href="/bonusPointsExchange/QueryBindedShopNameServlet?index="+5;
  </script>   
<%} %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Intelligent Recommendation</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/order.css">
</head>

<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="exchangeOrder">
    <p class="title">System recommended order<span class="title1">&nbsp;&nbsp;&nbsp;RECOMMEND ORDER</span><span class="title1 right"><a href="order.jsp">Return to the order center</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
  <div id="order-list" class="clearfix"> 
    <!---- 事例1------>
    <div class="order-info clearfix">
    <!-- 每次需要获得两个订单的详细信息-->
     <% if(null != recOrderIdList) {
             //System.out.println(latestOrderInfoList.size());
            for(int i = 0; i < recOrderIdList.size(); i++) {
           	 Vector<Integer> recOrderIds = (Vector<Integer>)recOrderIdList.get(i);
      %>
      <!-- 以上需要修改 -->
    <form action= "/bonusPointsExchange/actionServlet" method="post" onsubmit="return checkShop();">
      <ul class="clearfix">
        <li class="shop-logo"><img src="images/shopLogo/<%=recShop.getImgUrl()%>"/></li>
        <li class="exchangeOrder-info">
        <!-- table 中是用户最终交易需要的积分-->
          <table>
            <tr>
              <td>Merchant:<%=recShop.getShopName() %></td>
            </tr>
            <tr>
              <td>Number of Bonus:<%=recPoints.get(i) %></td>
            </tr>
            <tr>
             <td>Order party:<%=recOrderIds.size()+1 %>方</td>
            </tr> 
          </table>
        </li>  
        <li><img src="images/2.png"/></li>
        <li>&nbsp;&nbsp;</li>
        <li class="shop-logo" rowspan="3"><img src="images/shopLogo/<%=recWantShop.getImgUrl()%>"/></li>
        <li class="exchangeOrder-info">
        <!-- table 中是用户最终交易获得的积分-->
          <table>
            <tr>
              <td>Target merchant:<%=recWantShop.getShopName() %></td>
            </tr>
            <tr>
              <td>Number of target bonus<%=recWantedPoints.get(i) %></td>
            </tr>
            <tr>
              <td></td>
            </tr> 
          </table>
        </li>          
         <li class="operate">
          <input name="exchange" type="submit" class="submitBtn"  id="exchange" value="Deal">
        </li>
    
        <input type="hidden" name="recOrderIds" value="<%=recOrderIds%>"/>
        <input type="hidden" name="actionCode" value="order"/>
      	<input type="hidden" name="methodCode" value="finsh_order_muliti"/>     	
      </ul>
     </form>
    <%} %>
  <%} else {%>
       <br/><br/><br/><p align="center">  Search results are 0!</p>
 <%} %>
    </div>
  </div>
  
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>
</body>

<script type="text/javascript">
function checkShop() {
	var shop = document.getElementById("session").value;
	if (shop != "null") {
		alert("Merchant type account can not be traded, please change the user type account and login!");
		return false;
	}
}

function getJson()
</script>
-->
</html>
