<%--
  Created by IntelliJ IDEA.
  User: rissa
  Date: 8/2/2016
  Time: 1:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="database.ProductDAO" %>
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

                $("#cart-name").html(" <%=StringEscapeUtils.escapeHtml4(prod.getName())%>");
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
            $('#cart-button')
                    .popup({
//                        movePopup: false,
                        popup: $('#cart-popup'),
                        on: 'click'
                    })
            ;

            $(".btnminus").click(function(){
                var index = $(this).index(".btnminus");
                var a = +$(".txtquantity:eq("+index+")").val();
                a--;

                updateTable(index, a);
            });

            Number.prototype.formatMoney = function(c, d, t){
                var n = this,
                        c = isNaN(c = Math.abs(c)) ? 2 : c,
                        d = d == undefined ? "." : d,
                        t = t == undefined ? "," : t,
                        s = n < 0 ? "-" : "",
                        i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "",
                        j = (j = i.length) > 3 ? j % 3 : 0;
                return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
            };

            function updateTable(index, a){
                $.ajax({
                    url: "UpdateCartQuantityServlet",
                    dataType : 'json',
                    data: {"index": index, "value": a },
                    type: "POST",
                    success: function(data){
                        if(data.subtotal==-1){
                            $("tr:eq(" + (index+1) + ")").remove();

                        }
                        else {
                            $(".txtquantity:eq(" + index + ")").val(a);
                            $(".row-subtotal:eq(" + index + ")").html("PHP" + (data.subtotal).formatMoney(2));
                            $("#table-total").html("Total: PHP" + (data.totalsum).formatMoney(2));
                        }
                        updateCart();
                    }
                });
            }
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

            $(".txtquantity").keyup(function(){
                var index = $(this).index(".txtquantity");
                var a = +$(this).val();
                updateTable(index, a);
            });

            $(".btnplus").click(function(){
                var index = $(this).index(".btnplus");
                var a = +$(".txtquantity:eq("+index+")").val();
                a++;
                updateTable(index, a);
            });


            $(".remove.icon").click(function(){
                var index = $(this).index(".remove.icon");
                var a = +0;
                updateTable(index, a);
//                console.log(index);
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
                            <a href="IndexDisplayProductsServlet">
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
        <a id="cat-boots" class="item">
            <div class="ui grid">
                <div class="sixteen wide column categ-label-container">
                    <img class="ui mini image middle aligned" src="assets/boots.png">
                </div>
                <div class="sixteen wide column categ-label-container"><span class="category-label">boots</span></div>
            </div>
        </a>
        <a id="cat-shoes" class="item">
            <div class="ui grid">
                <div class="sixteen wide column categ-label-container">
                    <img class="ui mini image middle aligned" src="assets/shoes.png">
                </div>
                <div class="sixteen wide column categ-label-container"><span class="category-label">shoes</span></div>
            </div>
        </a>
        <a id="cat-sandals" class="item">
            <div class="ui grid">
                <div class="sixteen wide column categ-label-container">
                    <img class="ui mini image middle aligned" src="assets/sandals.png">
                </div>
                <div class="sixteen wide column categ-label-container"><span class="category-label">sandals</span></div>
            </div>
        </a>
        <a id="cat-slippers" class="item">
            <div class="ui grid">
                <div class="sixteen wide column categ-label-container">
                    <img class="ui mini image middle aligned" src="assets/slippers.png">
                </div>
                <div class="sixteen wide column categ-label-container"><span class="category-label">slippers</span>
                </div>
            </div>
        </a>
    </div>
</div>
<div class="ui container segment">
    <h2 class="ui header">Your Cart
    </h2>

        <%
            if(session.getAttribute("item") != null) {

        %>
        <table class="ui single line basic table">
            <thead>
            <tr>
                <th>Item</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th></th>
            </tr>
            </thead>
        <tbody>
        <%
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

        <tr>
            <td>
                <h4 class="ui image header">
                    <img src="assets/bababoots.jpg" class="ui mini rounded image">
                    <div class="content">
                        <%=StringEscapeUtils.escapeHtml4(temp.getName())%>
                    </div>
                </h4></td>
            <td><fmt:formatNumber value="<%=temp.getPrice()%>" type="currency" currencyCode="PHP"></fmt:formatNumber></td>
            <td>

                <i class="btnminus minus link icon"></i>
                <div class="ui input">
                    <input type="number" class="txtquantity" name="quantity" value="<%=itemp%>">
                </div>
                <i class="btnplus plus link icon"></i></td>
            <td class="row-subtotal"><fmt:formatNumber value="<%=itemp*temp.getPrice()%>" type="currency" currencyCode="PHP"></fmt:formatNumber></td>
            <td><i class="link bordered inverted red remove icon"></i></td>
        </tr>
        <%
                }
            } catch (JSONException e) {
                e.printStackTrace();
            }
        %>

        </tbody>
        </table>

        <div class="ui basic right aligned segment">
            <h3 id="table-total" class="ui header table-total">Total: <fmt:formatNumber value="<%=sum%>" type="currency" currencyCode="PHP"></fmt:formatNumber></h3>
            <div class="ui large orange submit button">
            	<c:choose>
            		<c:when test="${user eq null}">
            			<a href="login.jsp">
            				<span class="middle-align">CHECKOUT</span>
                		</a>
            		</c:when>
            		<c:otherwise>
            			<a href="checkout_shipping.jsp">
            				<span class="middle-align">CHECKOUT</span>
                		</a>
            		</c:otherwise>
            	</c:choose>
            	
             
            </div>
        </div>

    <%
        }
    %>
</div>

</body>
</html>
