<<<<<<< HEAD
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="database.UserDAO" %>
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
                            Cookie[] cookies = request.getCookies();
                            boolean foundCookie = false;

                            if(cookies !=null){
                                    for(int i = 0; i < cookies.length; i++) {
                                        Cookie c = cookies[i];
                                        if (c.getName().equals("user")) {
                                            foundCookie = true;
                                        }
                                    }
                            }
                            if (!foundCookie) {
                        %>
            $('#welcome-menu').hide();
            <%
                } else {
            %>
            $('#login-menu').hide();
            <%
                }
            %>

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
                        <div class="eight wide column left aligned"><span class="price-label">0.00</span></div>
                    </div>


                </div>
            </div>
            <div class="ui custom flowing bottom center popup transition left aligned" id="cart-popup">
                <div class="ui sub header left aligned">Recently added:</div>
                <div class="ui grid">
                    <div class="eight wide column left aligned">

                        Bababoots
                    </div>
                    <div class="eight wide column right aligned">

                        PHP 1,500.00
                    </div>
                </div>
                <div class="ui divider"></div>

                <div class="ui grid">
                    <div class="eight wide column left aligned">

                        5 Items
                    </div>
                    <div class="eight wide column right aligned">

                        <h4 class="ui header">TOTAL: PHP 7,500.00</h4>
                    </div>
                </div>

                <div class="ui hidden divider"></div>
                <div class="ui fluid large orange submit button">
                    <div><span class="middle-align">CHECKOUT</span>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>


<div class="ui container custom-container" style="padding-top: 5%;">
    <div class="ui header">LOGIN OR CREATE AN ACCOUNT</div>
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
                    <a href="sign-up.html">
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
=======
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="semantic-ui/dist/semantic.min.css">
        <link rel="stylesheet" type="text/css" href="style.css">
        
        <script src="jquery-1.11.3.min.js"></script>
        <script src="semantic-ui/dist/semantic.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#login").click(function () {
                    $("#error-login").hide();
                    $("#login-modal")
                            .modal({
                                closable  : true,
                                onDeny    : function(){
                                    window.alert('Wait not yet!');
                                    return false;
                                },
                                onApprove : function() {
                                    if($("#username").val()=="" || $("#password").val()==""){
                                        $("#error-login").show();
                                        return false;
                                    }

                                }
                            })
                            .modal('show')
                    ;
                });
            });
        </script>
    </head>
    <body>
<!--
        <div id="#login-menu" class="ui top attached menu">
            <div class="right menu">
                <div class="ui right aligned item top-nav">
                    <a href="login.html" class="item top-nav-item">login</a>
                    <a href="sign-up.html" class="item top-nav-item">sign up</a>
                </div>
            </div>
        </div> 
-->
        <div class="ui grid inverted attached segment">
            <div class="four wide column center aligned">
                <div class="ui header center aligned">
                    <div class="content brand-container">
                        <a href="index.html">
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
                    <div class="eight wide column right aligned"><i class="badge big link shop icon" data-badge="0"></i></div>
                    <div class="eight wide column left aligned"><span class="price-label">0.00</span></div>
                </div>                              
            </div>
        </div>
        
        
        <div class="ui container custom-container" style="padding-top: 5%;">
            <div class="ui header">LOGIN OR CREATE AN ACCOUNT</div>
            <div class="ui segment very padded">
                <form>
                    <div class="ui two column middle aligned very relaxed stackable grid">
                        <div class="column">
                            <div class="ui form">
                                <div class="field">
                                    <label>Username</label>
                                    <div class="ui left icon input">
                                        <input placeholder="Username" type="text"><i class="user icon"></i>
                                    </div>
                                </div>
                                <div class="field">
                                    <label>Password</label>
                                    <div class="ui left icon input">
                                        <input type="password"><i class="lock icon"></i>
                                    </div>
                                </div>
                                <button class="ui blue submit button">Login</button>
                            </div>
                      </div>
                      <div class="ui vertical divider"> Or</div>
                      <div class="center aligned column">
                          <a href="sign-up.html">
                              <div class="ui big green labeled icon button">
                                  <i class="signup icon"></i>Sign Up
                              </div>
                          </a>
                      </div>
                    </div>
                </form>
            </div>          
        </div>          
    </body>
>>>>>>> feature/product_manager
</html>