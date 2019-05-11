<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%	String LaunchTranscationRes = (String)request.getAttribute("LaunchTranscationRes"); 
 	 if(LaunchTranscationRes=="unBindShop"){
 %>
	<script type="text/javascript" language="javascript">
		alert("You haven't already bound the merchant, please bind the merchant first.");                            
	</script>
<%	} %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Welcome to BonusExchange platform Home page</title>
<link rel="stylesheet" type="text/css" href="css/main.css">
<link href="css/footer.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="css/index.css">
</head>
<body>

<!--这是top-->
	<%@ include file="header.jsp" %>
<!--这是main_page-->
<div class="index clearfix">
  <div class="index1">
    <ul>
      <li>Bank</li>
      <li>Airline</li>
      <li>Suprmarket</li>
      <li>Restaurant</li>
      <li>MegaMalls</li>
      <li style="border:none">Other</li>
    </ul>
  </div>
  <div class="index2">
    <div>
      <p class="title">Merchant<span class="more title1"><a href="#">More</a></span></p>
    </div>
    <div id="shop-list"  class="clearfix">
      <ul>
        <li><a><img src="images/shopLogo/beifanghangkong.jpg"/>
          <p class="shopName">HaiyingAirlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/changanhangkong.jpg"/>
          <p class="shopName">BITAirlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/changchenghangkong.jpg"/>
          <p class="shopName">YulongAirlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/dongfanghangkong.jpg"/>
          <p class="shopName">AncAirlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/shanghaihangkong.jpg"/>
          <p class="shopName">HuAirlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/shenzhenhangkong.jpg"/>
          <p class="shopName">YuanDaAirlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/sichuanhangkong.jpg"/>
          <p class="shopName">KMAirlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/wuhanhangkong.jpg"/>
          <p class="shopName">VDAirlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/xiamenhangkong.jpg"/>
          <p class="shopName">636Airlines</p>
          </a></li>
        <li><a><img src="images/shopLogo/zhongguoguoji.jpg"/>
          <p class="shopName">CunAirlines</p>
          </a></li>
      </ul>
    </div>
    <div>
      <p class="title">Newly released<span class="more title1"><a href="#">More</a></span></p>
    </div>
    <div id="order-list" class="clearfix"> 
      <!---- 事例1------>
      <div class="order-info clearfix">
        <ul >
          <li class="shop-logo"><img src="images/shopLogo/dongfanghangkong.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>Merchant:AncAirlines</td>
                <td>Target merchant:636Airlines</td>
              </tr>
              <tr>
                <td>Number of bonus:100</td>
                <td>Number of Target bonus:120</td>
              </tr>
              <tr>
                <td>Deadline:2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
  	 <form action="/bonusPointsExchange/ReferencePriceServlet" method="post">
        <input name="exchange" type="button" class="submitBtn" id="exchange" value="Exchange">
      </form>           
          </li>
        </ul>
      </div>
      <!-----事例2------>
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="images/shopLogo/changanhangkong.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>Merchant:AncAirlines</td>
                <td>Target merchant:636Airlines</td>
              </tr>
              <tr>
                <td>Number of bonus:100</td>
                <td>Number of Target bonus:120</td>
              </tr>
              <tr>
                <td>Deadline:2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="Exchange">
          </li>
        </ul>
      </div>
      <!------事例3------->
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="images/shopLogo/changchenghangkong.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>Merchant:AncAirlines</td>
                <td>Target merchant:636Airlines</td>
              </tr>
              <tr>
                <td>Number of bonus:100</td>
                <td>Number of target bonus:120</td>
              </tr>
              <tr>
                <td>Deadline:2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="Exchange">
          </li>
        </ul>
      </div>
            <!------事例4------->
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="images/shopLogo/dongfanghangkong.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>Merchant:AncAirlines</td>
                <td>Target merchant:636Airlines</td>
              </tr>
              <tr>
                <td>Number of bonus100</td>
                <td>Number of Target bonus120</td>
              </tr>
              <tr>
                <td>Deadline:2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="Exchange">
          </li>
        </ul>
      </div>
            <!------事例5------->
      <div class="order-info clearfix " >
        <ul>
          <li class="shop-logo"><img src="images/shopLogo/shanghaihangkong.jpg"/></li>
          <li class="info">
            <table>
              <tr>
                <td>Merchant:AncAirlines</td>
                <td>TargetAirlines:636Airlines</td>
              </tr>
              <tr>
                <td>Number of bonus:100</td>
                <td>Number of target bonus:120</td>
              </tr>
              <tr>
                <td>Deadline:2016-11-20</td>
                <td></td>
              </tr>
            </table>
          </li>
          <li class="operate">
            <input name="exchange" type="button" class="submitBtn" id="exchange" value="Exchange">
          </li>
        </ul>
      </div>
    </div>
  </div>
</div>
<!--这是bottom-->
	<%@ include file="footer.jsp" %>
</body>
</html>
