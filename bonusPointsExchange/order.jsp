·<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.bit.bonusPointsExchange.bean.Order"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="com.bit.bonusPointsExchange.bean.ShowBindInfo"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%List<ShowBindInfo> bindShops = (List<ShowBindInfo>)request.getAttribute("bindShops"); %>
<!-- 显示查询到的订单信息 -->
<% 

	List<Order> list = (List<Order>)request.getAttribute("orderInfo");//个人订单信息
	List<Order> orders = (List<Order>)request.getAttribute("orders");//按积分优先查询到的订单信息
	List<Order> AllOrderByRateList = (List<Order>)request.getAttribute("AllOrderByRate");//按比率优先查询到的订单信息
	List<Order> AllOrderByUntilDate = (List<Order>)request.getAttribute("AllOrderByUntilDate");//按时效优先查询到的订单信息
 %>
<%
  String releaseOrderRes = (String)request.getAttribute("releaseOrderResult");  //获取发布订单是否成功
  if(releaseOrderRes == "N") {
%>
  <script type="text/javascript" language="javascript">
    alert("Failed to issue the order.");                            
  </script> 
<% } else if(releaseOrderRes == "Y") {%>
  <script type="text/javascript" language="javascript">
    alert("The order was issued successfully.");                                      
  </script> 
<% }%>

<%
	String finishOrderRes = (String)request.getAttribute("finishOrderRes"); //兑换积分的返回信息
	if(finishOrderRes=="您未绑定目标商家！"){
%>
  <script type="text/javascript" language="javascript">
    alert("您未绑定目标商家！");                            
  </script> 
<%}else if(finishOrderRes=="您未绑定商家！") {%>
 <script type="text/javascript" language="javascript">
    alert("您未绑定商家！");                            
  </script> 
<%}else if(finishOrderRes=="您在商家的积分不够！"){ %>
 <script type="text/javascript" language="javascript">
    alert("您在商家的积分不够！");                            
  </script>   
<%}else if(finishOrderRes=="积分兑换成功！"){ 
 System.out.print(finishOrderRes);
%>
 <script type="text/javascript" language="javascript">
    alert("积分兑换成功!");                            
  </script>     
<%}else if(finishOrderRes=="积分兑换失败！"){ %>
 <script type="text/javascript" language="javascript">
    alert("积分兑换失败！");                            
  </script>    
 <%}else if(finishOrderRes=="连接blockchain失败，请检查网络！"){ %>
 <script type="text/javascript" language="javascript">
    alert("连接blockchain失败，请检查网络！");                            
  </script>   
<%} %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Release an order</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link rel="stylesheet" type="text/css" href="css/footer.css" >
<link rel="stylesheet" type="text/css" href="css/index.css">
<link rel="stylesheet" type="text/css" href="css/order.css">
</head>

<body>
<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="main">
  <div id="orderNav">
    <h3>Order center</h3>
    <p><a href="javascript:showDiv(1)">发布新订单</a> </p>
    <p><a href="javascript:showDiv(2)">查看个人订单</a></p>
    <p><a href="javascript:showDiv(3)">搜索所有订单</a></p>
  </div>
  <div id="orderContent">
    <div id="div1">
      <div class="releaseOrder">
        <p class="title">Release the new order<span class="title1">&nbsp;&nbsp;REALEASE ORDER</span><span class="title1 right"><a href="reference.jsp">前往参考价</a>&nbsp;&nbsp;&nbsp;&nbsp;</span></p>
        <form action="/bonusPointsExchange/actionServlet" method="post" onsubmit="return checkShop()&&checkPoint()&&checkNull();">
       
          <table>
            <tr>
              <td>Select the merchant:</td>
              <td><select  class="normal-font" name="shopName" id="shopName" onchange="queryValidPoints()" >
                  <option selected="selected">Select please-------</option>
                  <c:forEach items="${bindShops}" var="bindShops">
                    <option>${bindShops.shopName}</option>               
                  </c:forEach>
                </select></td>
            </tr>
             <tr>
              <td>The number of effective bonus:</td>
              <td><input name="platPoint" type="number" readonly id="platPoint"></td>
              <td><label id="tip1"></label></td>        
            </tr>
            <tr>
              <td>The number of bonus:</td>
              <td><input name="points" type="number"  id="points" min="0" value="0" onblur="checkPoint()"></td>
            </tr>
            <tr>
              <td>Select the Target merchant:</td>
              <td><select name="wantedShop"  class="normal-font" id="wantedShop" >
                  <option selected="selected">Select please-------</option>
                   <c:forEach items="${bindShops}" var="bindShops">
                    <option>${bindShops.shopName}</option>               
                  </c:forEach>
                </select></td>
            </tr>
            <tr>
              <td>The number of Target bonus:</td>
              <td><input name="wantedPoint" type="number"  id="wantedPoint" min="0" value="0"></td>
            </tr>
            <tr>
              <td>Deadline:</td>
              <td><div id="utilDate" name="utilDate" runat="server"></td>
              <input id="utilDate2" name="utilDate2" type="hidden">
             <!--  <div id="utilDate" name="utilDate" RUNAT=SERVER>
              <input name="utilDate" id="utilDate" type="text"> -->
            </tr>
            <tr class="mid">
              <td><input name="submit" type="submit" id="submit" value="Submit" ></td>
              <td><input name="reset" type="reset" id="reset" value="Reset"></td>
            </tr>
          </table>
          <input type="hidden" name="actionCode" value="order"/>
          <input type="hidden" name="methodCode" value="release_order"/>
        </form>
      </div>
    </div>
    <!-----个人订单--------->
    <div id="div2">
      <p class="title">View individual orders<span class="title1">&nbsp;&nbsp;PERSONAL ORDER</span></p>
      <div id="order-list" class="clearfix"> 
        <!---- 事例1------>        <div class="order-info clearfix">
          <ul >
          <% if(null != list) {
              System.out.println(list.size());
            for(int i = 0; i < list.size(); i++) {
              Order orderInfo = (Order)list.get(i);
          %>       
          <li class="shop-logo"><img src="images/shopLogo/<%=orderInfo.getShopLogo() %>"/></li>   
            <li class="myOrder-info">
              <table>
            	<tr>           	    
            		<td>Merchant:<%=orderInfo.getShopName() %></td>             		            		
              	</tr>
                <tr>
                  <td>Number of bonus:<%=orderInfo.getPoint() %></td>                
                </tr>
                <tr>
                  <td>Dealline:<%=orderInfo.getUntilDate() %></td>                 
                </tr>       
         	</table>
            </li>		
            <li  class="shop-logo"><img src="images/shopLogo/<%=orderInfo.getWantedShopLogo() %>"/></li> 
            <li class="myOrder-info">
              <table>
            	<tr>           	               		
            		<td>Target merchant:<%=orderInfo.getWantedShop() %></td>
              	</tr>
                <tr>
                   <td>Number of target bonus:<%=orderInfo.getWantedPoint() %></td>
                </tr>
                <tr>
                  <td></td>                
                </tr>       
         	</table>
            </li>	      			
            <%if(orderInfo.getOrderStatus() == 0) { %>
            <li class="operate">
              <input name="exchange" onclick="changOrderStatus(<%=orderInfo.getOrderID() %>)" type="button" class="submitBtn" id="exchange" value="Cancel">
            </li>
            <%} else if(orderInfo.getOrderStatus() == 1) {%>
             <li class="operate">
              <input name="exchange" type="button" class="submitBtn"  style="background:#EDEDED;" disabled="disabled" id="exchange" value="Completed">
            </li>
            <%} else if(orderInfo.getOrderStatus() == 2) {%>             <li class="operate" >
              <input name="exchange" type="button" class="submitBtn" style="background:#EDEDED;" disabled="disabled" id="exchange" value="Expired">
            </li>
            <%} %>         <%}
       }%>
          </ul>
        </div>
      </div>   
   </div>
    <!----------- 搜索订单------------------------------>
    <div id="div3">      <p class="title">View all orders<span class="title1">&nbsp;&nbsp;ALL ORDER</span></p>
      <div id="search">
      <form action="/bonusPointsExchange/actionServlet" method="post" onsubmit="return checkForm();">
        <table>
          <tr>
            <td>Merchant:&nbsp;</td><td><input name="shop" type="text" value="${shop }" id="shop"></td>
            <td>Bonus:&nbsp;</td><td><input name="point" type="number" value="${point}" id="point" min="1"></td>
          </tr>
          <tr>
          	<td>Target merchant:</td><td><input name="targetShop" type="text" value="${wantedShop }" id="targetShop"></td>
          	<td>Target Bonus:</td><td><input name="wantedPoint2" type="number" value="${wantedPoint}" id="wantedPoint2" min="1"></td>
            <td colspan="2" ><input name="submit" type="submit" class="submitBtn" id="submit" value="Search"></td> 
          </tr>
        </table>          
           Select the sorting method:
      <select name="selectSort"  id="selectSort">
    <c:if test="${selectID==null}">  
       <option selected="selected">Bonus First</option>               
        <option>Ratio First</option>
         <option>Aging First</option>
     </c:if>
      <c:if test="${selectID=='2'}">  
       <option>Bonus First</option>               
        <option selected="selected">Ratio First</option>
         <option>Aging First</option>     </c:if>
     <c:if test="${selectID=='3'}">    
    	 <option>Bonus First</option>              
     	 <option>Ratio First</option>
       	 <option selected="selected">Aging First</option>
     </c:if>
      </select>
      <input type="hidden" name="actionCode" value="order"/>
          <input type="hidden" name="methodCode" value="findAllOrder"/>
        </form>
      </div>      <div id="search-result">
      <table>
       <% if(null != AllOrderByRateList) {
             System.out.println(AllOrderByRateList.size());
            for(int i = 0; i < AllOrderByRateList.size(); i++) {
             Order orderInfo = (Order)AllOrderByRateList.get(i);
        %>
      <tr><form action="/bonusPointsExchange/actionServlet" method="post">
      <td><input type="hidden" name="orderID" value="<%=orderInfo.getOrderID()%>"/></td>
      <td class="shop-logo"> <img src="images/shopLogo/<%=orderInfo.getShopLogo()%>"/> <p><%=orderInfo.getWantedShop()%></p></td>
      <td><%=orderInfo.getWantedPoint() %>Bonus<img src="images/2.png"/><%=orderInfo.getPoint() %>Bonus</td>      
      <td class="shop-logo"><img src="images/shopLogo/<%=orderInfo.getWantedShopLogo() %>"/> <p><%=orderInfo.getShopName() %></p></td>      
      <td><p>Order publisher:<%=orderInfo.getUserName() %></p>
      <p>Transaction validity period:<%=orderInfo.getUntilDate() %></p></td>
      <td class="operate"><p>&nbsp;</p><input name="submit" type="submit" class="submitBtn" id="submit" value="Exchange"></td>
      <input type="hidden" name="actionCode" value="order"/>
      <input type="hidden" name="methodCode" value="finsh_order"/>
      </form>
      </tr>
         <%} %>
      <%} else if(null != AllOrderByUntilDate) {
            System.out.println(AllOrderByUntilDate.size());
            for(int i = 0; i < AllOrderByUntilDate.size(); i++) {
            Order orderInfo = (Order)AllOrderByUntilDate.get(i);
      %>
      <tr><form action="/bonusPointsExchange/actionServlet" method="post">
      <td><input type="hidden" name="orderID" value="<%=orderInfo.getOrderID()%>"/></td>
      <td class="shop-logo"> <img src="images/shopLogo/<%=orderInfo.getShopLogo()%>"/> <p><%=orderInfo.getWantedShop() %></p></td>
      <td><%=orderInfo.getWantedPoint() %>Bonus<img src="images/2.png"/><%=orderInfo.getPoint() %>Bonus</td>
      <td class="shop-logo"><img src="images/shopLogo/<%=orderInfo.getWantedShopLogo() %>"/> <p><%=orderInfo.getShopName() %></p></td>
      <td><p>Order publisher:<%=orderInfo.getUserName() %></p>
      <p>Transaction validity period:<%=orderInfo.getUntilDate() %></p></td>
      <td class="operate"><p>&nbsp;</p><input name="submit" type="submit" class="submitBtn" id="submit" value="Exchange"></td>
      <input type="hidden" name="actionCode" value="order"/>
      <input type="hidden" name="methodCode" value="finsh_order"/>
      </form>
      </tr>
       <%}%>
     <%} %>
	  <%
		String findRes = (String)request.getAttribute("findRes");
      	if(orders!=null&&orders.size()>0){ %>

      <c:forEach items="${orders}" var="order">
      <tr><form action="/bonusPointsExchange/actionServlet" method="post">
      		<td><input type="hidden" name="orderID" value="${order.orderID}"/></td>
        	<td class="shop-logo"> <img src="images/shopLogo/${order.shopLogo}"/> <p >${order.wantedShop}</p></td>
        	<td>${order.wantedPoint}Bonus<img src="images/2.png"/>${order.point}Bonus</td>
        	<td class="shop-logo"><img src="images/shopLogo/${order.wantedShopLogo}"/> <p>${order.shopName}</p></td>
        	<td><p>Order Publisher${order.userName}</p>
        	<p>Transaction validity period:${order.untilDate}</p></td>
        	<td class="operate"><p>&nbsp;</p><input name="submit" type="submit" class="submitBtn" id="submit" value="Exchange"></td>
			<input type="hidden" name="actionCode" value="order"/>
         	<input type="hidden" name="methodCode" value="finsh_order"/>
      	</form>
      </tr>
       </c:forEach>
       <%}else if(findRes=="true" && null == AllOrderByRateList && null == AllOrderByUntilDate){%> 
     		<br/><br/><br/><p align="center"><a href="javascript:recommend();">The result of searching is0!You can use smart recommendations to match your needs.</a></p>   
        <%} %>		                    
      </table>     
        </form>
      </div>
    </div>
  </div>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>

<!-- 根据返回的index显示div -->
<script type="text/javascript" language="javascript">
  //alert("asdas");
  var index = ${index};
 // var index1 =  document.getElementById("index1111").value;
 // alert(index1);
  var show=parseInt(index);
  //alert(show);
  for(i=1;i<=3;i++){
    document.getElementById('div'+i).style.display = "none";
  }
  document.getElementById('div'+index).style.display = "block";
  //document.getElementById('div'+index1).style.display = "block";
</script>


<script type="text/javascript">
function showDiv(index){   
  var show=parseInt(index);

  for(i=1;i<=3;i++){
  document.getElementById('div'+i).style.display = "none";}
  document.getElementById('div'+index).style.display = "block";
  if(show == 1) {//查询绑定的商家
    location.href ="/bonusPointsExchange/actionServlet?actionCode=bindShop&methodCode=find_bindedShops";
  }
  if(show == 2) {
    //查询用户相关的订单信息
    location.href = "/bonusPointsExchange/QueryOrderInfo";
  }
}
//改变订单状态
function changOrderStatus(orderID) {
  //alert(orderID);
  location.href = "/bonusPointsExchange/ChangeOrderStaServlet?orderID="+orderID;
}
/*
function setValue(){
  var oTip = document.getElementById("tip1"); 
  var selected_val = document.getElementById("shopName").value;
  var bindShops = ${bindShops};
  var shops = [];
  var array = new Array();
  alert(bindShops.length);
  <c:forEach items="${bindShops}" var="shop"> 
      array.push(${shop}); //生成如 array.push(123)的字符串 这样前台拿到后就是js 
  </c:forEach> 

  var point =0; 
   for(var i=0;i<bindShops.length;i++){
      var shop ={};
      shop.shopName = list[i].shopName;
      shop.platfromPoint = list[i].platfromPoint;
      shops.push(shop);
  } 
  alert("der");
  for(var i=0;i<shops.length;i++){
    if(shops[i].shopName.equals(selected_val)){
      point=shops[i].platfromPoint;
    }
    break;
  } 
  alert(point);
  if(obj.value>point){
    oTip.innerHTML="The number of bonus entered has exceeded your number of bonus on the platform";
  }else{
    oTip.innerHTML="";
  } 
}
*/
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
//查询用户在平台数据库有多少有效的积分,即用户在平台的积分减去用户发布的未完成订单的积分和
function queryValidPoints() {
  var shopName = document.getElementById("shopName").value;
  //alert(shopName);//调试代码
  var url = "/bonusPointsExchange/QueryValidPointSerlvet?shop="+encodeURI(encodeURI(shopName));
  createXMLHttp();
  xmlHttp.onreadystatechange = queryValidPointsBack;
  xmlHttp.open("get", url, true);
  xmlHttp.send(null);
}
// 回调函数,处理服务器返回结果
function queryValidPointsBack() {
  //alert("aaaaaa");
  // 响应已完成
  if (xmlHttp.readyState == 4) {
    // 服务器正常的响应
    // alert(xmlHttp.status);
    if (xmlHttp.status == 200) {
      var returnMsg = xmlHttp.responseText; // 收取服务器端的响应信息(String)
      //alert(returnMsg);
      document.getElementById("platPoint").value = returnMsg;
    }
  }
}

function checkPoint(){//判断用户输入积分数是否超过用户在平台的积分数
  var platPoint = document.getElementById("platPoint").value;
  var points = document.getElementById("points").value;
  
  if(Number(points)>Number(platPoint)){
    alert("The number of bonus entered has exceeded your number of bonus on the platform");
    return false;
  }else return true;
}
function checkShop(){//判断积分所属商家与期望兑换商家是否相同
  var shopName = document.getElementById("shopName").value;
  var wantedShop = document.getElementById("wantedShop").value;
  if(shopName==wantedShop){
    alert("The merchants of the bonus cannot be the same as the merchants who wish to redeem");
    return false;
  }
  else return true;
}
function realSysTime(utilDate){//设置订单有效期
  var now = new Date();//创建Date对象
  var year = now.getFullYear();//获取年份
  var month = now.getMonth();//获取月份
  var date = now.getDate();//获取日期
  month=month+2;
  if(month>12){
    month=1;
    year=year+1;
  }
  if(month<=9){
    month="0"+month;
      
  }
  if(date<=9){
    date="0"+date;
  }
  var time = year+"-"+month+"-"+date;//显示时间
  utilDate.innerHTML=time;
  document.getElementById("utilDate2").value=time;
}
window.onload=function(){//页面载入时执行
  window.setInterval("realSysTime(utilDate)");
  
}

function checkNull(){
  var shopName = document.getElementById("shopName").value;
  var platPoint =document.getElementById("platPoint").value;
  var points = document.getElementById("points").value;
  var wantedShop= document.getElementById("wantedShop").value;
  var wantedPoint = document.getElementById("wantedPoint").value;
  if(shopName=="请选择-------"){
    alert("The merchant cannot be empty");
    return false;
  }else if(Number(platPoint)==0){
    alert("The business bonus you selected are 0. Please transfer the bonus to the platform first!");
    return false;
  }else if(Number(points)<=0){
    alert("The number of bonus must be greater than 0");
    return false;
  }else if(wantedShop=="请选择-------"){
    alert("Target merchant cannot be empty");
    return false;
  }else if(Number(wantedPoint)<=0){
    alert("Target bonus must be greater than0");
    return false;
  }else return true;
}


function checkForm() {
	//商家名不能空
	var shopName = document.getElementById("shop").value;
	//alert(shopName);
	if (shopName == "") {
		alert("Marchent's name cannot be empty");
		return false;
	}
	
	var wantedShop = document.getElementById("targetShop").value;
	if (wantedShop == "") {
		alert("Name of target merchant cannot be empty");
		return false;
	}
	
	var point = document.getElementById("point").value;
	//alert(shopName);
	if (point == "") {
		alert("Number of bonus cannot be empty");
		return false;
	}
	
	var wantedPoint = document.getElementById("wantedPoint2").value;
	//alert(shopName);
	if (wantedPoint == "") {
		alert("Number of target bonus cannot be empty");
		return false;
	}
 }

//智能推荐
function recommend() {
  	var shopName = document.getElementById("shop").value;
	var point = document.getElementById("point").value;
	var targetShop = document.getElementById("targetShop").value;
	var wantedPoint = document.getElementById("wantedPoint2").value;
  	window.location = "/bonusPointsExchange/actionServlet?actionCode=recommend&shopName="+encodeURI(encodeURI(shopName))+"&point="+point+"&targetShop="+encodeURI(encodeURI(targetShop))+"&wantedPoint="+wantedPoint;
 	
 	
}
</script>

<body></body>
</html>
