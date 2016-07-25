<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="database.UserDAO" %>
<! DOCTYPE html>
<html>
<head>
    <script src="jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="semantic-ui/dist/semantic.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#login").click(function () {
//                $("#login-modal").modal('show');
                $("#error-login").hide();
                $("#login-modal")
                        .modal({
                            closable  : true,
                            onDeny    : function(){
                                window.alert('Wait not yet!');
                                return false;
                            },
                            onApprove : function() {
                                alert('Approved!');
								
								var username = $('#username').val();
				                var password = $('#password').val();
				                $.ajax({
				                    url: 'LoginServlet',
				                    data: { "username" : username,
				                    		"password": password},
				                    error: function(data) {
				                    	alert("wut");
				                        $('#error-login').show();
				                        return false;
				                    },
				                    success: function(data) {
				                    	alert("pasok success");
				                		$('#welcome-menu').show();
				                		$('#login-menu').hide();
				                    },
				                    type: 'POST'
				                });

                            }
                        })
                        .modal('show')
                ;
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
<div id="#login-menu" class="ui top attached menu">
    <div class="right menu">
        <div class="ui right aligned item top-nav">
            <a id="login" class="item top-nav-item">login</a>
            <a href="sign-up.html" class="item top-nav-item">sign up</a>
        </div>
    </div>
</div>
<div id="#welcome-menu" class="ui container hidden">
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
<div  id="menubar">
    <div class="ui  attached container">
        <div class =" ui basic inverted segment">
            <div class="ui grid">
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
                        <div class="eight wide column right aligned"><i class="badge big link shop icon"  id="cart-button" data-badge="0"></i></div>
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

<div class="ui container custom-container">
    <div class="ui four item pointing menu">
        <a class="active item">
            <div class="ui grid">
                <div class="sixteen wide column categ-label-container">
                    <img class="ui mini image middle aligned" src="assets/boots.png">
                </div>
                <div class="sixteen wide column categ-label-container"><span class="category-label">boots</span></div>
            </div>
        </a>
        <a class="item">
            <div class="ui grid">
                <div class="sixteen wide column categ-label-container">
                    <img class="ui mini image middle aligned" src="assets/shoes.png">
                </div>
                <div class="sixteen wide column categ-label-container"><span class="category-label">shoes</span></div>
            </div>
        </a>
        <a class="item">
            <div class="ui grid">
                <div class="sixteen wide column categ-label-container">
                    <img class="ui mini image middle aligned" src="assets/sandals.png">
                </div>
                <div class="sixteen wide column categ-label-container"><span class="category-label">sandals</span></div>
            </div>
        </a>
        <a class="item">
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
      
    <div class="ui four column grid">
        <div class="column">
            <div class="ui fluid card">
                <div class="image">
                    <img src="assets/bababoots.jpg">
                </div>
                <div class="content">
                    <div class="ui grid">
                        <div class="twelve wide column">
                            <a class="header">Rissa Bababoots (Red)</a>
                            <div class="meta"><span class="price-label">900.00</span></div>
                        </div>
                        <div class="four wide column middle aligned center aligned">
                            <i class="big link add to cart icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="column">
            <div class="ui fluid card">
                <div class="image">
                    <img src="assets/bababoots.jpg">
                </div>
                <div class="content">
                    <div class="ui grid">
                        <div class="twelve wide column">
                            <a class="header">Rissa Bababoots (Red)</a>
                            <div class="meta"><span class="price-label">900.00</span></div>
                        </div>
                        <div class="four wide column middle aligned center aligned">
                            <i class="big link add to cart icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="column">
            <div class="ui fluid card">
                <div class="image">
                    <img src="assets/bababoots.jpg">
                </div>
                <div class="content">
                    <div class="ui grid">
                        <div class="twelve wide column">
                            <a class="header">Rissa Bababoots (Red)</a>
                            <div class="meta"><span class="price-label">900.00</span></div>
                        </div>
                        <div class="four wide column middle aligned center aligned">
                            <i class="big link add to cart icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="column">
            <div class="ui fluid card">
                <div class="image">
                    <img src="assets/bababoots.jpg">
                </div>
                <div class="content">
                    <div class="ui grid">
                        <div class="twelve wide column">
                            <a class="header">Rissa Bababoots (Red)</a>
                            <div class="meta"><span class="price-label">900.00</span></div>
                        </div>
                        <div class="four wide column middle aligned center aligned">
                            <i class="big link add to cart icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="column">
            <div class="ui fluid card">
                <div class="image">
                    <img src="assets/bababoots.jpg">
                </div>
                <div class="content">
                    <div class="ui grid">
                        <div class="twelve wide column">
                            <a class="header">Rissa Bababoots (Red)</a>
                            <div class="meta"><span class="price-label">900.00</span></div>
                        </div>
                        <div class="four wide column middle aligned center aligned">
                            <i class="big link add to cart icon"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container pagination-container ">
         <div class="ui pagination menu">
            <a class="icon item"><i class="left arrow icon"></i></a>
            <a class="active item"> 1</a>
            <a class="item">2</a>
            <a class="icon item"><i class="right arrow icon"></i></a>
        </div>
    </div>
</div>

<!---- START LOGIN MODAL---------------------------------------->
<div id="login-modal" class="ui small modal">
    <i class="close icon"></i>
    <div class="header"> Login</div>

    <div class="content">
        <div class="ui basic  center aligned segment">

            <form data-abide action = "LoginServlet" class="ui form" id="login-form" method="post">
                <div id="error-login" class="ui negative message">
                    <p>
                        Wrong username/password!
                    </p>
                </div>
                <div class="ui fluid left icon input">
                    <i class="user icon"></i>
                    <input type="text" name="username" id="username" placeholder="Username">
                </div>
                <br>
                <div class="ui fluid left icon input">
                    <i class="lock icon"></i>
                    <input type="password" name="password" id="password" placeholder="Password">
                </div>
            </form>
        </div>
    </div>
    <div class="actions">
        <button id="login-btn" class="ui positive right button" type="submit" form="login-form"> Login</button>
    </div>
</div>
<!---- END LOGIN MODAL------------------------------------------>

</body>
</html>