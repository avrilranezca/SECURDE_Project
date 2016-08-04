<%@ page import="database.ProductDAO" %>
<%@ page import="database.ReviewDAO" %>
<%@ page import="model.Product" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

    
<! DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="semantic-ui/dist/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="style.css">
        
        <script src="jquery-1.11.3.min.js"></script>
        <script src="semantic-ui/dist/semantic.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                <%

                ReviewDAO reviewDAO = new ReviewDAO();
                String userName=null;

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
                $('#welcome-menu').hide();
                <%
                    } else {
                %>
                $('#login-menu').hide();
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
                            popup : $('#cart-popup'),
                            on    : 'click'
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
        
        
        <div class="ui container custom-container">
            <div class="ui header">Create new account</div>
            <div class="ui segment">
                <form data-abide class="ui form" method="POST" action="SignUpServlet" id="signup-form">
                    <div class="ui grid">
                        <div class="seven wide computer sixteen wide tablet column">
                            <h4 class="ui dividing header">Basic Information</h4>
                            <div class="ui grid middle aligned">
                                <div class="six wide column"><label>Firstname</label></div>
                                <div class="ten wide column"><input placeholder="Juan" name="firstname" type="text"></div>
                            </div>
                            <div class="ui grid middle aligned">
                                <div class="six wide column"><label>Middle Initial</label></div>
                                <div class="ten wide column"><input placeholder="A." name="middleInitial" type="text"></div>
                            </div>
                            <div class="ui grid middle aligned">
                                <div class="six wide column"><label>Lastname</label></div>
                                <div class="ten wide column"><input placeholder="Dela Cruz" name="lastname" type="text"></div>
                            </div>
                             <div class="ui grid middle aligned">
                                <div class="six wide column"><label>Email</label></div>
                                <div class="ten wide column"><input placeholder="example@abc.com" name="email" type="email"></div>
                            </div>
                             <div class="ui grid middle aligned">
                                <div class="six wide column"><label>Username</label></div>
                                <div class="ten wide column"><input placeholder="exampleABC" name="username" type="text"></div>
                            </div>
                             <div class="ui grid middle aligned">
                                <div class="six wide column"><label>Password</label></div>
                                <div class="ten wide column"><input placeholder="*******" name="password" type="password"></div>
                            </div>
                        </div>
                        <div class="nine wide computer sixteen wide tablet column">
                            <div class="column">
                                <h4 class="ui dividing header">Billing Address</h4>
                                <div class="ui grid">
                                    <div class="eight wide computer sixteen wide tablet column">
                                        <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>House No.</label></div>
                                            <div class="ten wide column"><input placeholder="123" name="bHouseNo" type="number"></div>
                                        </div>
                                         <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>Subdivision</label></div>
                                            <div class="ten wide column"><input placeholder="subdivi" name="bSubdivision" type="text"></div>
                                        </div>
                                        <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>Postal Code</label></div>
                                            <div class="ten wide column"><input placeholder="1440" name="bPostalCode" type="number"></div>
                                        </div>
                                    </div>
                                    <div class="eight wide computer sixteen wide tablet column">
                                        <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>Street</label></div>
                                            <div class="ten wide column"><input placeholder="Santo Domingo" name="bStreet" type="text"></div>
                                        </div>
                                         <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>City</label></div>
                                            <div class="ten wide column"><input placeholder="Quezon City" name="bCity" type="text"></div>
                                        </div>
                                        <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>Country</label></div>
                                            <div class="ten wide column"><input placeholder="Philippines" name="bCountry" type="text"></div>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                            
                            <div class="column" style="padding-top: 15px;">
                                <h4 class="ui dividing header">Shipping Address</h4>
                                <div class="ui grid">
                                    <div class="eight wide computer sixteen wide tablet column">
                                        <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>House No.</label></div>
                                            <div class="ten wide column"><input placeholder="123" name="sHouseNo" type="number"></div>
                                        </div>
                                         <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>Subdivision</label></div>
                                            <div class="ten wide column"><input placeholder="subdivi" name="sSubdivision" type="text"></div>
                                        </div>
                                        <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>Postal Code</label></div>
                                            <div class="ten wide column"><input placeholder="1440" name="sPostalCode" type="number"></div>
                                        </div>
                                    </div>
                                    <div class="eight wide computer sixteen wide tablet column">
                                        <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>Street</label></div>
                                            <div class="ten wide column"><input placeholder="Santo Domingo" name="sStreet" type="text"></div>
                                        </div>
                                         <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>City</label></div>
                                            <div class="ten wide column"><input placeholder="Quezon City" name="sCity" type="text"></div>
                                        </div>
                                        <div class="ui grid middle aligned">
                                            <div class="six wide column"><label>Country</label></div>
                                            <div class="ten wide column"><input placeholder="Philippines" name="sCountry" type="text"></div>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    <div class="ui grid">
                        <div class=" six wide computer sixteen wide tablet column right floated">
                             <button type="submit" class="ui blue button" style="width: 100%;" form="signup-form">REGISTER</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
    </body>
</html>