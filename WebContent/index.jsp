<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="database.ProductDAO" %>
<%@ page import="database.ReviewDAO" %>
<%@ page import="model.Product" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<! DOCTYPE html>
<html>
<head>
    <script src="jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="semantic-ui/dist/semantic.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
        	$("#search-form input[name=search]").val(null);
            
            <%
                ReviewDAO reviewDAO = new ReviewDAO();
            %>
            <%--    String userName=null;

                if(session.getAttribute("user") != null)
	                userName = (String) session.getAttribute("user");
                
                /*Cookie[] cookies = request.getCookies();

                if(cookies !=null){
                        for(int i = 0; i < cookies.length; i++) {
                            Cookie c = cookies[i];
                            if (c.getName().equals("user")) {
                                foundCookie = true;
                            }
                        }
                }*/

                if (userName==null) { System.out.println("BROOM");
            %>
                    $('#welcome-menu').hide();
            <%
                } else { System.out.println("broom");
            %>
                    $('#login-menu').hide();
            <%
                }
            %>
 --%>
            updateCart();

            $('#logout').click(function(){
                $('#logout-form').submit();
            });

            $('#cart-button')
                    .popup({
//                        movePopup: false,
                        popup: $('#cart-popup'),
                        on: 'click'
                    })
            ;

            $('.rating')
	            .rating({
	              initialRating: 0,
	              maxRating: 5,
	              interactive: false
	            })
	        ;

            function updateCart(){
                <%
                if(session.getAttribute("item") != null){
                    int capacity =0;
                    float sum = 0;
                    Product prod = null;
                    ProductDAO dao = new ProductDAO();
                    try {
                        JSONArray arr = new JSONArray((String)session.getAttribute("item"));
                        prod = dao.getProductOnID(Integer.parseInt(arr.getJSONObject(arr.length()-1).getString("id")));
                        for (int i =0; i<arr.length(); i++){
                            Product temp = dao.getProductOnID(Integer.parseInt(arr.getJSONObject(i).getString("id")));
                            int itemp= arr.getJSONObject(i).getInt("quantity");
                            sum+=(temp.getPrice()*itemp);
                            capacity+= itemp;
                        }
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }

                    %>
                    $("#cart-button").attr("data-badge", "<%=capacity%>");
                    $("#total").html('<fmt:formatNumber value="<%=sum%>" type="currency" currencyCode="PHP"></fmt:formatNumber>');

                    $("#empty-cart").hide();

                    $("#cart-name").html("<%=StringEscapeUtils.escapeHtml4(prod.getName())%>");
                    $("#cart-subtotal").html('<fmt:formatNumber value="<%=prod.getPrice()%>" type="currency" currencyCode="PHP"></fmt:formatNumber>');
                    $("#cart-total").html('<fmt:formatNumber value="<%=sum%>" type="currency" currencyCode="PHP"></fmt:formatNumber>');

                    $("#cart-capacity").html("<%=capacity%> Item/s");
                <%
                }
                else{
                %>
                $("#recent-cart").hide();
                <%
                }
                %>
            }

            $(".add-cart").click(function () {
                var id = this.id;
                var ind = $(this).index('.add-cart');

                $.ajax({
                    url: "AddToCartServlet",
                    data: {"itemID": id},
                    type: "POST",
                    success: function(data){
                        $(".add-cart:eq("+ind+")").attr("class", "big link green add to cart icon add-cart");
                        updateCart();
                    }
                });

              //  $("#addtocart-form input[name=itemID]").val(id);
              //  $("#addtocart-form").submit();
            });



            $(".item-name").click(function ()
            {
                var id = this.id;
                $("#display-form input[name=itemID]").val(id);
                $("#display-form").submit();
            });

            $("#cat-boots").click(function () {
                $("#category-form input[name=cat]").val("Boots");
                $("#category-form").submit();
            });

            $("#cat-sandals").click(function () {
                $("#category-form input[name=cat]").val("Sandals");
                $("#category-form").submit();
            });

            $("#cat-shoes").click(function () {
                $("#category-form input[name=cat]").val("Shoes");
                $("#category-form").submit();
            });

            $("#cat-slippers").click(function () {
                $("#category-form input[name=cat]").val("Slippers");
                $("#category-form").submit();
            });

            $(".search").click(function(){
            	 var query = $("#searchQuery").val();
             	 $("#search-form input[name=search]").val(query);
                 $("#search-form").submit();
            });

            $("#searchQuery").keypress(function(e) {
                if(e.which == 13) {
                /*	 var query = $("#searchQuery").val();
                     $.ajax({
                         url: "IndexDisplayProductsServlet",
                         data: {"searchQuery": query,
                        	 	"isSearch": true,},
                         type: "GET",
                        success: function(data){


                         }
                     });*/

                     var query = $("#searchQuery").val();
                	$("#search-form input[name=search]").val(query);
                    $("#search-form").submit();
                }

            });

            $('#fullbackbtn').click(function(){
                var ind = +1;
                updateForm(ind);
            });

            $('#backbtn').click(function(){
                var ind = +${page};
                ind--;
                updateForm(ind);
            });

            $('#fullnextbtn').click(function(){
                var ind = +${max};
                updateForm(ind);
            });

            $('#nextbtn').click(function(){
                var ind = +${page};
                ind++;
                updateForm(ind);
            });

            $('.navbtn').click(function(){
                var ind = +$(this).html();
                updateForm(ind);
            });

            function updateForm(ind){
                alert(ind);
                $('#nav-form input[name=page]').val(ind);
                $('#nav-form').submit();
            }

        });
    </script>
</head>
<body>
<c:choose>
	<c:when test="${sessionScope.user == null }">
		<div id="login-menu" class="ui top attached menu">
		    <div class="right menu">
		        <div class="ui right aligned item top-nav">
		            <a href="<%=response.encodeURL("login.jsp")%>" id="login" class="item top-nav-item">login</a>
		            <a href="<%=response.encodeURL("sign-up.jsp")%>" class="item top-nav-item">sign up</a>
		        </div>
		    </div>
		</div>
	</c:when>
	<c:otherwise>
		<div id="welcome-menu" class="ui container">
		    <div class="ui right aligned basic segment">
		        <div class="ui grid middle aligned">
		            <div class="fourteen wide column">
		                <div class="ui sub header"> Welcome  <c:out value="${user}"></c:out>!</div>
		            </div>
		            <div class="two wide column">
		                <div class="ui tiny right aligned basic button" id="logout">Logout</div>
		
		                <form id="logout-form" action="LogoutServlet" method="post"></form>
		            </div>
		        </div>
		    </div>
		</div>
	</c:otherwise>
</c:choose>
<div id="menubar">
    <div class="ui  attached container">
        <div class=" ui basic inverted segment">
            <div class="ui grid">
                <div class="four wide column center aligned">
                    <div class="ui header center aligned">
                        <div class="content brand-container">
                            <a href="<%=response.encodeURL("index.jsp") %>">
                                <span>Talaria</span>
                                <div class="sub header">
                                    <span>Footwear Co.</span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="seven wide column center aligned">
                	
                	<form id="search-form" action="IndexDisplayProductsServlet" method="get">
			            <input name="search" type="hidden">
			        </form>
			        
                    <div class="ui icon input search-bar">
                        <input id="searchQuery" name="query" placeholder="Search for products or categories" type="text" >
                        <i class="search link icon"></i>
                    </div>
                </div>

                <div class="five wide column middle aligned ">
                    <div class="ui grid sixteen wide column">
                        <div class="eight wide column right aligned">
                        	<i class="badge big link shop icon" id="cart-button" data-badge="0"></i>
                       	</div>
                        <div class="eight wide column left aligned"><span id="total" class="price-label">0.00</span></div>
                    </div>
                </div>
            </div>
            <div class="ui custom flowing bottom center popup transition left aligned" id="cart-popup">
                <div id="empty-cart">
                    <div class="ui sub header left aligned">Add items to your cart!</div>
                </div>
                <div id="recent-cart">
                    <div class="ui sub header left aligned">Recently added:</div>
                    <div class="ui grid">
                        <div id="cart-name" class="eight wide column left aligned">Bababoots </div>
                        <div id="cart-subtotal" class="eight wide column right aligned">PHP 1,500.00</div>
                    </div>
                    <div class="ui divider"></div>

                    <div class="ui grid">
                        <div id="cart-capacity" class="eight wide column left aligned">5 Items</div>
                        <div class="eight wide column right aligned">
							<h4 id="cart-total" class="ui header">TOTAL: PHP 7,500.00</h4>
                        </div>
                    </div>

                    <div class="ui hidden divider"></div>
                    <div class="ui fluid large orange submit button">
                        <a href="view-cart.jsp">
                        	<span class="middle-align">CHECKOUT</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="ui container custom-container">
    <div class="ui four item pointing menu">
        <form id="category-form" action="SelectDisplayCategoryServlet" method="get">
            <input name="cat" type="hidden">
        </form>

        <c:choose>
	        <c:when test="${filter eq 'Boots'}">
	       		<a id="cat-boots" class="active item">
            </c:when>
            <c:otherwise>
            	<a id="cat-boots" class="item">
            </c:otherwise>
       </c:choose>
                <div class="ui grid">
                    <div class="sixteen wide column categ-label-container">
                        <img class="ui mini image middle aligned" src="assets/boots.png">
                    </div>
                    <div class="sixteen wide column categ-label-container"><span class="category-label">boots</span>
                    </div>
                </div>
            </a>
            <c:choose>
            	<c:when test="${filter eq 'Shoes'}">
            		<a id="cat-shoes" class="active item">
                </c:when>
                <c:otherwise>
                	<a id="cat-shoes" class="item">
                </c:otherwise>
            </c:choose>
                    <div class="ui grid">
                        <div class="sixteen wide column categ-label-container">
                            <img class="ui mini image middle aligned" src="assets/shoes.png">
                        </div>
                        <div class="sixteen wide column categ-label-container"><span class="category-label">shoes</span>
                        </div>
                    </div>
                </a>
          <c:choose>
          	<c:when test="${filter eq 'Sandals'}">
          		<a id="cat-sandals" class="active item">
          	</c:when>
            <c:otherwise>
                <a id="cat-sandals" class="item">
            </c:otherwise>
         </c:choose>
                	<div class="ui grid">
                         <div class="sixteen wide column categ-label-container">
                              <img class="ui mini image middle aligned" src="assets/sandals.png">
                          </div>
                          <div class="sixteen wide column categ-label-container">
                         		<span class="category-label">sandals</span>
                          </div>
                    </div>
               </a>
          <c:choose>
          	<c:when test="${filter eq 'Slippers'}">
          		<a id="cat-slippers" class="active item">
          	</c:when>
          	<c:otherwise>
          		<a id="cat-slippers" class="item">
          	</c:otherwise>
          </c:choose>
          		<div class="ui grid">
          			<div class="sixteen wide column categ-label-container">
          				<img class="ui mini image middle aligned" src="assets/slippers.png">
          			</div>
          			<div class="sixteen wide column categ-label-container">
          				<span class="category-label">slippers</span>
          			 </div>
          		</div>
            </a>
    </div>
</div>
<div class="ui container segment">

	<c:choose>
		<c:when test="${search ne null}">
			<div class="ui hidden divider"></div>
		    <div id="search-banner">
		        <div class="ui basic segment">
		
		            <!--<div class="content">-->
		                <div class="ui sub header">Search Results:</div>
		                <em><c:out value="${searchQuery}"></c:out></em> / ${fn:length(products)} found
		            <!--</div>-->
		        </div>
		    </div>
		    <div class="ui hidden divider"></div>
		</c:when>
	</c:choose>


   
    <c:choose>
    	<c:when test="${products.size() > 0}">
    		<div class="ui four column grid">
    			<c:forEach var="item" items="${products}">
		            <%
		
		                Product p =(Product) pageContext.getAttribute("item");
		                System.out.println("reviewww"+p);
		                int i = reviewDAO.getAverageRating(p).intValue();
		            %>
		            <div class="column">
		                <div class="ui fluid card">
		                    <div class="image">
		                        <img src="assets/bababoots.jpg">
		                    </div>
		                    <div class="content">
		                        <div class="ui grid">
		                            <div class="twelve wide column">
		                                <a id="cart-${item.id}" class="item-name">
		                                	<c:out value="${item.name}"></c:out>
		                                </a>
		                                <div class="meta">
		                                	<span class="price-label">
		                                		<fmt:formatNumber value="${item.price}"
		                                                          type="currency"
		                                                          currencyCode="PHP">
		                                       	</fmt:formatNumber>
		                                    </span>
		                                </div>
		                                <br>
		
		                                <div class="ui tiny star rating"  data-rating="<%=i%>"></div>
		                            </div>
		                            <div class="four wide column middle aligned center aligned" >
		
		                                <form id="display-form" action="DisplaySpecificItemServlet" method="get">
		                                    <input name="itemID" type="hidden">
		                                </form>
		
		
		                                <form id="addtocart-form" action="AddToCartServlet" method="post">
		                                    <input name="itemID" type="hidden">
		                                </form>
		
		                                <i id="cart-${item.id}" class="big link add to cart icon add-cart"></i>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </c:forEach>
	        </div>
   		</c:when>
   		<c:otherwise>
   			<div class ="ui header center aligned">No Products</div>
   		</c:otherwise>
   	</c:choose>
    
    <div class="container pagination-container ">
        <c:choose>
            <c:when test="${products.size() ne 0}">
                <c:choose>
                    <c:when test="${filter ne 'All'}">
                        <form id = "nav-form" action="SelectDisplayCategoryServlet" method="Get">
                            <input type="hidden" name="page">
                            <input type="hidden" name="cat" value="${filter}">
                        </form>
                    </c:when>
                    <c:when test="${search ne null}">
                        <form id = "nav-form" action="IndexDisplayProductsServlet" method="Get">
                            <input type="hidden" name="page">
                            <input type="hidden" name="search" value="<c:out value="${search}"></c:out>">
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form id = "nav-form" action="IndexDisplayProductsServlet" method="Get">
                            <input type="hidden" name="page">
                        </form>
                    </c:otherwise>
                </c:choose>
                <div class="ui pagination menu">
                    <c:choose>
                        <c:when test="${fullbackbtn}">
                            <a id="fullbackbtn" class="icon item mnavbtn"><i class="left arrow icon"></i></a>
                        </c:when>
                    </c:choose>

                    <c:choose>
                        <c:when test="${backbtn}">
                            <a id="backbtn" class="icon item mnavbtn"><i class="left arrow icon"></i></a>
                        </c:when>
                    </c:choose>
                    <c:forEach var="currpage" items="${pages}">
                        <c:choose>
                            <c:when test="${currpage eq '..'}">
                                <a class="disabled item navbtn"><c:out value="${currpage}"/></a>
                            </c:when>
                            <c:when test="${currpage eq page}">
                                <a class="  item navbtn"><c:out value="${currpage}"/></a>
                            </c:when>
                            <c:otherwise>
                                <a class="item navbtn"><c:out value="${currpage}"/></a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:choose>
                        <c:when test="${nextbtn}">
                            <a id="nextbtn mnavbtn" class="icon item"><i class="right arrow icon"></i></a>
                        </c:when>
                    </c:choose>

                    <c:choose>
                        <c:when test="${fullnextbtn}">
                            <a id="fullnextbtn mnavbtn" class="icon item"><i class="right arrow icon"></i></a>
                        </c:when>
                    </c:choose>
                </div>
            </c:when>
        </c:choose>
    </div>
</div>

</body>
</html>