<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="database.ProductDAO" %>
<%@ page import="database.ReviewDAO" %>
<%@ page import="model.Product" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<! DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">

    <script src="jquery-1.11.3.min.js"></script>
    <script src="semantic-ui/dist/semantic.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#error-login').hide();
            <%
                if(request.getAttribute("error")!=null){
                    %>
                    $('#error-msg').text("${error}");
                    $('#error-login').show();
                    <%
                }

            %>
            <%
                ReviewDAO reviewDAO = new ReviewDAO();

                String username=null;
                        UserDAO uDAO = new UserDAO();

                if(session.getAttribute("user") != null)
	                username = (String) session.getAttribute("user");


                String sessionID = request.getSession().getId();


                if(username!=null) {
                        User u = uDAO.getUser(username);
                        String uSessionID = uDAO.getUserSessionID(u);
                        if(uSessionID.equals(sessionID)){
                   %>
            $('#login-menu').hide();
            <%
                } else {
            uDAO.setUserSessionID(u, null);
         %>

            $('#welcome-menu').hide();
            <%
            }
            %>
            <%

                }else{
                    %>
            $('#welcome-menu').hide();

            <%
                }


            %>

            updateCart();
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

                $("#cart-name").html("<%=prod.getName()%>");
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
                <div class="ui sub header"> Welcome !</div>
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
                        <input id="searchQuery" name="query" placeholder="Search for products or categories" type="text" >
                        <i class="search link icon"></i>
                    </div>
                </div>

                <div class="five wide column middle aligned ">
                    <div class="ui grid sixteen wide column">
                        <div class="eight wide column right aligned"><i class="badge big link shop icon"
                                                                        id="cart-button" data-badge="0"></i></div>
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

<div class="ui container custom-container" >
	<div class="ui warning message">Please login or create an account to continue with your purchase</div>
    <div class="ui header" style="margin-top: 3%;">LOGIN OR CREATE AN ACCOUNT</div>
    <div class="ui segment very padded">
        <%--<form>--%>
            <div class="ui two column very relaxed stackable grid">
                <div class="column">
                    <div class="ui basic segment">

                        <form class="ui form" id="login-form" action="LoginServlet" method="post">
                            <div id="error-login" class="ui negative message">
                                <p id="error-msg">
                                    Wrong username/password!
                                </p>
                            </div>
                            <div class="field"><label>Username</label>
                                <div class="ui fluid left icon input">
                                    <i class="user icon"></i>
                                    <input type="text" name="username" id="username">
                                </div>
                            </div>
                            <div class="field"><label>Password</label>
                                <div class="ui fluid left icon input">
                                    <i class="lock icon"></i>
                                    <input type="password" name="password" id="password">
                                </div>
                            </div>
                            <input type="hidden" name="token" value="${token}"/>
                            <button class="ui blue submit button">Login</button>
                        </form>
                    </div>
                </div>
                <div class="ui vertical divider"> Or</div>
                <div class="center aligned column">
                    <a href="<%=response.encodeURL("sign-up.jsp") %>">
                        <div class="ui big green labeled icon button">
                            <i class="signup icon"></i>Sign Up
                        </div>
                    </a>
                </div>
            </div>
        <%--</form>--%>
    </div>
</div>
</body>
</html>