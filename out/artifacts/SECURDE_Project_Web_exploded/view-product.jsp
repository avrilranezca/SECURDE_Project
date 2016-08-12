<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="database.ProductDAO" %>
<%@ page import="database.ReviewDAO" %>
<%@ page import="database.UserDAO" %>
<%@ page import="model.Product" %>
<%@ page import="org.apache.commons.lang3.StringEscapeUtils" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<! DOCTYPE html>
<html>
<head>
    <script src="resources/jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="resources/semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="resources/style.css">
    <script src="resources/semantic-ui/dist/semantic.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#search-form input[name=search]").val(null);
            <%
                String userName=null;
                UserDAO userDAO = new UserDAO();
                ReviewDAO reviewDAO = new ReviewDAO();
                ProductDAO productDAO = new ProductDAO();
                boolean foundCookie = false;
                if(session.getAttribute("user") != null){

	                userName = (String) session.getAttribute("user");
	                foundCookie=true;
                }
                            Cookie[] cookies = request.getCookies();

                            if(cookies !=null){
                                    for(int i = 0; i < cookies.length; i++) {
                                        Cookie c = cookies[i];
                                        if (c.getName().equals("user")) {
                                            foundCookie = true;
                                        }
                                    }
                            }

                            if (!foundCookie || userName==null) {
            %>

            updateCart();

            $('#review-form').hide();
            $('#error-review-buy').hide();
            $('#welcome-menu').hide();
            <%
                } else {
            %>
            $('#login-menu').hide();
            $('#error-review-login').hide();
            <%
                    Product resultBean = (Product) request.getAttribute("product");
                    System.out.println(request.getAttribute("productID"));

                    boolean bool = reviewDAO.hasBought(userDAO.getUser(userName),  resultBean );
                    if(bool){
                        %>
            $('#error-review-buy').hide();
                    <%
                    }
                    else{
                    %>
            $('#review-form').hide();

            <%
                    }
                }
            %>

            $("#btnminus").click(function () {
                var a = +$("#quantity").val();
                if (a > 1) $("#quantity").val(a - 1);
            });

            $("#btnplus").click(function () {
                var a = +$("#quantity").val();
                $("#quantity").val(a + 1);
            });

            $('.rating')
                    .rating({
                        initialRating: 0,
                        maxRating: 5,
                        interactive: false
                    })
            ;

            $('.editable.rating')
                    .rating({
                        initialRating: 0,
                        maxRating: 5,
                        interactive: true
                    })
            ;
            $('.editable.rating')
                    .click(function () {
                        $('#reviewbtn').attr("class", "ui right floated orange submit button");
                        $('#rate').val($(this).rating('get rating'));
                    })
            ;

            function updateCart() {
                <%
                if(session.getAttribute("item") != null){
                    int capacity =0;
                    float sum = 0;
                    Product prod  ;prod = null;
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

            $('#addtocart').click(function () {
                alert("heere");
                var id = ${product.id};
                var a = +$("#quantity").val();

                $.ajax({
                    url: "AddToCartQuantityServlet",
                    data: {"index": id, "value": a},
                    type: "GET",
                    success: function (data) {
//                        alert("no error");
                        updateCart();
//                        alert("wut")
                        $('#addtocart').attr("class", "ui fluid large green submit button");
//                        alert("the");

                        $('#carttext').html("ADDED TO CART");
//                        alert("hell");
                    }
                });

            });

            $('#reviewbtn').click(function () {
                var prod =${product.id};
                var review = $('#reviewtext').val();
                var rate = $('#rate').val();
                $.ajax({
                    url: "AddReviewServlet",
                    data: {"product": prod, "reviewtext": review, "rate": rate},
                    type: "POST",
                    success: function (data) {
                        $('#reviewbtn').attr("class", "ui right floated disabled orange submit button");
                        $('#reviewtext').val("");
                        $('.editable.rating').rating('set rating', 0);
//                        var temp = jQuery();
                        $('#actualcomments').prepend('<div class="comment"> <div class="content"> <a class="author"><%=StringEscapeUtils.escapeHtml4(userName)%></a> <div class="metadata"> <div class="ui star rating"></div> </div><div class="text"></div> </div> </div>');
                        $('#actualcomments').find('.text:first').text(review);
                    }
                });
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

            $('#cart-button')
                    .popup({
//                        movePopup: false,
                        popup: $('#cart-popup'),
                        on: 'click'
                    })
            ;

            $(".search").click(function () {
                var query = $("#searchQuery").val();
                $("#search-form input[name=search]").val(query);
                $("#search-form").submit();
            });

            $("#searchQuery").keypress(function (e) {
                if (e.which == 13) {
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
        });
    </script>
</head>
<body>
<div id="login-menu" class="ui top attached menu">
    <div class="right menu">
        <div class="ui right aligned item top-nav">
            <a href="<%=response.encodeURL("login.jsp") %>" id="login" class="item top-nav-item">login</a>
            <a href="<%=response.encodeURL("sign-up.jsp") %>" class="item top-nav-item">sign up</a>
        </div>
    </div>
</div>
<div id="welcome-menu" class="ui container">
    <div class="ui right aligned basic segment">
        <div class="ui grid middle aligned">
            <div class="fourteen wide column">
                <div class="ui sub header"> Welcome <c:out value="${user}"></c:out>!</div>
            </div>
            <div class="two wide column">
                <div class="ui tiny right aligned basic button" id="logout">Logout</div>

                <form id="logout-form" action="LogoutServlet" method="post"></form>
            </div>
        </div>
    </div>
</div>
<div id="menubar">
    <div class="ui  attached container">
        <div class=" ui basic inverted segment">
            <div class="ui grid">
                <div class="four wide column center aligned">
                    <div class="ui header center aligned">
                        <div class="content brand-container">
                            <a href="<%=response.encodeURL("/index") %>">

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
                        <input id="searchQuery" name="query" placeholder="Search for products or categories"
                               type="text">
                        <i class="search link icon"></i>
                    </div>
                </div>

                <div class="five wide column middle aligned ">
                    <div class="ui grid sixteen wide column">
                        <div class="eight wide column right aligned"><i class="badge big link shop icon"
                                                                        id="cart-button" data-badge="0"></i></div>
                        <div class="eight wide column left aligned"><span id="total" class="price-label">0.00</span>
                        </div>
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
                        <div id="cart-name" class="eight wide column left aligned">

                            Bababoots
                        </div>
                        <div id="cart-subtotal" class="eight wide column right aligned">

                            PHP 1,500.00
                        </div>
                    </div>
                    <div class="ui divider"></div>

                    <div class="ui grid">
                        <div id="cart-capacity" class="eight wide column left aligned">

                            5 Items
                        </div>
                        <div class="eight wide column right aligned">

                            <h4 id="cart-total" class="ui header">TOTAL: PHP 7,500.00</h4>
                        </div>
                    </div>

                    <div class="ui hidden divider"></div>
                    <div class="ui fluid large orange submit button">
                        <a href="view-cart.jsp"><span class="middle-align">CHECKOUT</span>
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
                        <img class="ui mini image middle aligned" src="resources/assets/boots.png">
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
                            <img class="ui mini image middle aligned" src="resources/assets/shoes.png">
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
                                <img class="ui mini image middle aligned" src="resources/assets/sandals.png">
                            </div>
                            <div class="sixteen wide column categ-label-container"><span
                                    class="category-label">sandals</span></div>
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
                                    <img class="ui mini image middle aligned" src="resources/assets/slippers.png">
                                </div>
                                <div class="sixteen wide column categ-label-container"><span class="category-label">slippers</span>
                                </div>
                            </div>
                        </a>
    </div>
</div>
<%
    Product p =(Product) request.getAttribute("product");
    int i = reviewDAO.getAverageRating(p).intValue();
%>
<div class="ui container segment">
    <div class="ui grid">
        <div class="nine wide column">
            <img class="ui fluid image" src="resources/assets/bababoots.jpg">
        </div>
        <div class="seven wide column">
            <h1 class="ui header"><c:out value="${product.name}"></c:out>
                <div class="sub header">
                    <div class="ui grid">
                        <div class="eight wide column">
                            <div class="price-label">PHP<c:out value="${product.price}"></c:out></div>
                        </div>
                        <div class="eight wide column right aligned">
                            <a href="#comments">

                                <div class="ui star rating" data-rating="<%=i%>"></div>
                            </a>
                        </div>
                    </div>
                </div>
            </h1>

            <p>${product.description}</p>

            <div class="ui divider"></div>

            <div class="ui form" method="post">
                <div class="inline field">
                    <label>Quantity</label>
                    <!--<button class="ui icon button middle">-->
                    <i id="btnminus" class="minus link icon"></i>
                    <!--</button>-->
                    <input type="text" id="quantity" name="quantity" value="1">
                    <!--<button class="ui icon button middle">-->
                    <i id="btnplus" class="plus link icon"></i>
                    <!--</button>-->
                </div>

                <button id="addtocart" class="ui fluid large orange submit button">
                    <div><i class="big shop icon element"></i><span id="carttext"
                                                                    class="middle-align">ADD TO CART</span>
                    </div>
                </button>
            </div>
        </div>
    </div>
    <div class="ui grid">
        <div class="sixteen wide column">
            <div id="comments" class="ui comments">

                <div class="ui dividing header">Recent Customer Reviews</div>
                <!--show this if the user still hasn't logged in--->
                <div id="error-review-login" class="ui info message">
                    Please login to review this product.
                </div>
                <div id="error-review-buy" class="ui info message">
                    Purchase the product to give a review.
                </div>
                <div class="ui form" method="post" id="review-form">
                    <div class="field">
                        <label><%=userName%></label>
                        <div class="ui editable huge star rating" style="margin-bottom: 10px;"></div>
                        <textarea rows="2" id="reviewtext" placeholder="Enter review here.."></textarea>
                    </div>
                    <input type="hidden" id="rate" name="rate">
                    <div class="ui basic clearing segment">
                        <button class="ui disabled right floated orange submit button" id="reviewbtn">
                            <span class="middle-align">SUBMIT REVIEW</span>
                        </button>
                    </div>
                </div>
                <div id="actualcomments">
                    <c:forEach var="review" items="${reviews}">
                        <div class="comment">
                            <div class="content">
                                <a class="author"><c:out value="${review.user_name}"></c:out></a>
                                <div class="metadata">
                                    <div class="ui star rating" data-rating="${review.rating}"></div>
                                </div>
                                <div class="text"><c:out value="${review.review}"></c:out></div>

                            </div>
                        </div>

                    </c:forEach>
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>