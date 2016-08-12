<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="database.ProductDAO" %>
<%@ page import="model.Product" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.JSONException" %>
<%@ page import="org.json.JSONObject" %>
<! DOCTYPE html>
<html>
<head>
    <script src="jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="semantic-ui/dist/semantic.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            <%
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

            $('#cart-button')
                    .popup({
//                        movePopup: false,
                        popup: $('#cart-popup'),
                        on: 'click'
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
            
            $('.ui.form')
	            .form({
	              fields: {
	            	  card: {
	            		  identifier  : 'card',
	            		  rules: [
	            		          {
	            		        	  type   : 'creditCard',
	            		        	  prompt : 'Please enter a valid credit card'
	            		          }
	            		         ]
	            		},
	                bHouseNo: {
	                  identifier: 'bHouseNo',
	                  rules: [
	                    {
	                      type   : 'integer',
	                      prompt : 'Please enter your Billing House Number'
	                    }
	                  ]
	                },
	                bSubdivision: {
	                  identifier: 'bSubdivision',
	                  rules: [
	                    {
	                      type   : 'empty',
	                      prompt : 'Please enter your Billing Subdivision'
	                    }
	                  ]
	                },
	                bPostalCode: {
	                  identifier: 'bPostalCode',
	                  rules: [
	                    {
	                      type   : 'integer',
	                      prompt : 'Please enter your Billing House Postal Code'
	                    }
	                  ]
	                },
	                bStreet: {
	                  identifier: 'bStreet',
	                  rules: [
	                    {
	                      type   : 'empty',
	                      prompt : 'Please enter your Billing House Street'
	                    }
	                  ]
	                },
	                bCity: {
	                  identifier: 'bCity',
	                  rules: [
	                    {
	                      type   : 'empty',
	                      prompt : 'Please enter your Billing House City'
	                    }
	                  ]
	                },
	                bCountry: {
	                  identifier: 'bCountry',
	                  rules: [
	                    {
	                      type   : 'empty',
	                      prompt : 'Please enter your Billing Country'
	                    }
	                  ]
	                }
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
                <div class="ui sub header"> Welcome  ${user}!</div>
            </div>
            <div class="two wide column">
                <div class="ui tiny right aligned basic button">Logout</div>
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
                    <div class="ui icon input search-bar">
                        <input placeholder="Search for products or categories" type="text">
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
<div class="ui container grid custom-container">

    <div class="ui hidden divider"></div>
    <!--<div class="ui grid">-->
    <div class="ten wide computer sixteen wide tablet column">
        <div class="ui segment">
            <div class="ui mini steps">
                  <div class="step">
                      <i class="truck icon"></i>
                      <div class="content">
                          <div class="title">Shipping</div>
                          <!--<div class="description">Choose your shipping options</div>-->
                      </div>
                  </div>
                  <div class="active step">
                      <i class="payment icon"></i>
                      <div class="content">
                          <div class="title">Billing</div>
                          <!--<div class="description">Enter billing information</div>-->
                      </div>
                  </div>
                  <div class="disabled step">
                      <i class="info icon"></i>
                      <div class="content">
                          <div class="title">Confirm Order</div>
                          <!--<div class="description">Verify order details</div>-->
                      </div>
                  </div>
              </div>

            <!--<h3 class="ui header">Payment</h3>-->
            <div class="ui form">
            	<form action="CheckoutBillingServlet" method="POST">
		            <h3 class="ui dividing header">Payment</h3>
		            <div class="grouped fields">
		                <div class="field">
		                    <div class="ui radio checkbox">
		                        <input type="radio" id="cash" name="payment" checked="checked">
		                        <label>Cash</label>
		                    </div>
		                </div>
		                <div class="field">
		                    <div class="ui radio checkbox">
		                        <input type="radio" id="card" name="payment">
		                        <label>Card
		                            <div class="ui field">
		                                <input name="card" maxlength="16" placeholder="Card #" type="text">
		                            </div>
		                        </label>
		                    </div>
		                </div>
		            </div>
		
		            <h3 class="ui dividing header">Billing Address</h3>
		            <div>
		                <div class="ui grid middle aligned field">
		                    <div class="four wide column"><label>House No.</label></div>
		                    <div class="twelve wide column">
		                    	<input placeholder="123" name="bHouseNo" type="number" value="${address.getHouse_no()}">
		                    </div>
		                </div>
		                <div class="ui grid middle aligned field">
		                    <div class="four wide column"><label>Subdivision</label></div>
		                    <div class="twelve wide column">
		                    	<input placeholder="subdivi" name="bSubdivision" type="text" value="${address.getSubdivision()}">
		                    </div>
		                </div>
		                <div class="ui grid middle aligned field">
		                    <div class="four wide column"><label>Postal Code</label></div>
		                    <div class="twelve wide column">
		                    	<input placeholder="1440" name="bPostalCode" type="number" value="${address.getPostal_code()}">
		                    </div>
		                </div>
		                <div class="ui grid middle aligned field">
		                    <div class="four wide column"><label>Street</label></div>
		                    <div class="twelve wide column">
		                    	<input placeholder="Santo Domingo" name="bStreet" type="text" value="${address.getStreet()}">
		                    </div>
		                </div>
		                <div class="ui grid middle aligned field">
		                    <div class="four wide column"><label>City</label></div>
		                    <div class="twelve wide column">
		                    	<input placeholder="Quezon City" name="bCity" type="text" value="${address.getCity()}">
		                    </div>
		                </div>
		                <div class="ui grid middle aligned field">
		                    <div class="four wide column"><label>Country</label></div>
		                    <div class="twelve wide column">
		                    	<input placeholder="Philippines" name="bCountry" type="text" value="${address.getCountry()}">
		                    </div>
		                </div>
		            </div>
		            <h4 class="ui hidden divider"></h4>
		            <div class="ui basic right aligned segment">
		                <button class="ui  large blue submit button">Confirm Billing Information</button>
		            </div>
	            </form>
	        </div>
        </div>
    </div>
    <div class="six wide computer sixteen wide tablet column ">

        <div class="ui secondary segment">

            <h3 class="ui dividing header">Cart</h3>

            <%
                if(session.getAttribute("item") != null) {


                int capacity = 0;
                float sum = 0;
                Product prod = null;
                ProductDAO dao = new ProductDAO();
                try {
                    JSONArray arr = new JSONArray((String) session.getAttribute("item"));
                    prod = dao.getProductOnID(Integer.parseInt(arr.getJSONObject(arr.length() - 1).getString("id")));
                    for (int i = 0; i < arr.length(); i++) {
                        Product temp = dao.getProductOnID(Integer.parseInt(arr.getJSONObject(i).getString("id")));
                        int itemp = arr.getJSONObject(i).getInt("quantity");
                        sum += (temp.getPrice() * itemp);
                        capacity += itemp;


            %>

            <div class="ui two column grid middle aligned">
                <div class="ten wide column">
                    <h5 class="ui header">

                        <div class="ui tiny image">
                            <div class="floating ui circular orange label"><%=itemp%></div>
                            <img src="assets/bababoots.jpg">
                        </div>
                        <%=temp.getName()%></h5>
                </div>
                <div class="six wide column right aligned">

                    <h5 class="ui header"><fmt:formatNumber value="<%=itemp*temp.getPrice()%>" type="currency" currencyCode="PHP"></fmt:formatNumber></h5>
                </div>
            </div>
            <%
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }

            %>

            <div class="ui divider"></div>


            <div class="ui basic segment right aligned">
                <h3 class="ui header">Total: <fmt:formatNumber value="<%=sum%>" type="currency" currencyCode="PHP"></fmt:formatNumber></h3>
            </div>

            <%
                }
            %>
        </div>
    </div>
    <!--</div>-->


</div>

</body>
</html>