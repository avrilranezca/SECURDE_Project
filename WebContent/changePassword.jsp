<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script src="resources/jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="resources/semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="resources/style.css">
    <script src="resources/semantic-ui/dist/semantic.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#login").click(function () {
//                $("#login-modal").modal('show');
                $("#error-login").hide();
                $("#login-modal")
                        .modal({
                            closable  : true,
                            onDeny    : function(){
//                                window.alert('Wait not yet!');
//                                return false;
                            },
                            onApprove : function() {
//                                window.alert('Approved!');

                                if($("#username").val()=="" || $("#password").val()==""){
                                    $("#error-login").show();
                                    return false;
                                }

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

            $("#error-change").hide();
                     
            $('#changepw')
                    .modal({
                        closable  : false,
                        onDeny    : function(){
//                            window.alert('Wait not yet!');
//                            return false;
                        },
                        onApprove : function() {
                        	
                        	var strength = 0;
                        	
                            if($("#oldpw").val()=="" || $("#newpw").val()=="" || $("#confirmnewpw").val()==""){
                                $("#error-change").show();
                                $("#error-change p").text("Please fill in all fields!");
                                                              
                                return false;
                            }
                            else{
                            	
                            	if ($("#newpw").val().length > 7) {
                            		strength += 1;
                            		alert("pasok length");
                            	}
                                 	
                              	// If password contains both lower and uppercase characters, increase strength value.
                             	if ($("#newpw").val().match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) {
                             		strength += 1;
									alert("pasook uppercase and lowercase")
                             	}
                              	// If it has numbers and characters, increase strength value.
                              	if ($("#newpw").val().match(/([a-zA-Z])/) && $("#newpw").val().match(/([0-9])/)) {
                              		alert("pasok numbers and characters");
                              		strength += 1;
                            	}
                              	// If it has one special character, increase strength value.
                              	if ($("#newpw").val().match(/([!,%,&,@,#,$,^,*,?,_,~,:,.])/)) {
                              		alert("pasok special characters");
                              		strength += 1;
                              	}
                              	// If it has two special characters, increase strength value.
                              	if ($("#newpw").val().match(/(.*[!,%,&,@,#,$,^,*,?,_,~,:,.].*[!,%,&,@,#,$,^,*,?,_,~,:,.])/)) 
                              		strength += 1;
                              
                              	if(strength < 4){
                              		alert("strength: "+strength);
                              		var error_poorpw = "<br> Weak password! Your password must meet the following requirements: "+
                              						   "<ul> "+
                              						   		"<li>At least one special character</li>"+
                              						   		"<li>At least one capital letter</li>"+
                              						   		"<li>At least one number</li>"+
                              						   		"<li>At least 7 characters</li>"+
                              						   "</ul> ";
                              		$("#error-change").show();
                                    $("#error-change p").append(error_poorpw);
                                 	
                                 	$("#newpw").css('color','red');
                                 	return false;
                              	}
                              	
                                 if($("#newpw").val() != $("#confirmnewpw").val()){
                                 	var error_mismatch ="New password does not match with the confirmation password! ";
                                 	
                                 	if($("#error-change p").val() == "")
                                 		$("#error-change p").text(error_mismatch);
                                 	else
                                 		$("#error-change p").append("<br> "+error_mismatch);
                                 	
                                 	$("#error-change").show();				
                                 	$("#newpw").css('color','red');
                                 	$("#confirmnewpw").css('color','red');
                                 	return false;
                                 }
                            }                           
                        }
                    })
                    .modal('show');
            });
    </script>
</head>
<body>

<div class="ui small basic long modal" id="changepw">
    <div class="header">Change temporary password</div>
    <div class="content">
        <p>Please change the temporary password given to you by the administrator. This is for security purposes.</p>
        <div class="ui hidden divider"></div>
        <form class="ui form" id="change-form">
            <div id="error-change" class="ui negative message">
                <p>Please fill in all fields!</p>                
                <c:choose>
	            	<c:when test="${error ne ''}">
	            		  <p><c:out value='${error}'/></p>   
	            	</c:when>
	            </c:choose>
            </div>
         
            <div class="ui fluid left icon input">
                <i class="lock icon"></i>
                <input type="password" name="oldpw" id="oldpw" placeholder="Old Password">
            </div>
            <br>
            <div class="ui fluid left icon input">
                <i class="lock icon"></i>
                <input type="password" name="newpw" id="newpw" placeholder="New Password">
            </div>
            <br>
            <div class="ui fluid left icon input">
                <i class="lock icon"></i>
                <input type="password" name="confirmnewpw" id="confirmnewpw" placeholder="Confirm New Password">
            </div>
        </form>
    </div>

    <div class="actions">
        <div class="ui positive right button" type="submit" form="change-form"> Change Password</div>
    </div>
</div>

<div class="ui top attached menu">
    <div class="right menu">
        <div class="ui right aligned item top-nav">
            <a href="login.html" class="item top-nav-item">login</a>
            <a href="sign-up.html" class="item top-nav-item">sign up</a>
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
</body>
</html>