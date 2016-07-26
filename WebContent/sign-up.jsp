<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <div id="#login-menu" class="ui top attached menu">
            <div class="right menu">
                <div class="ui right aligned item top-nav">
                    <a id="login" class="item top-nav-item">login</a>
                    <a href="sign-up.html" class="item top-nav-item">sign up</a>
                </div>
            </div>
        </div> 
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
        
        
        <div class="ui container custom-container">
            <div class="ui header">Create new account</div>
            <div class="ui segment">
                <form class="ui form">
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
                             <button class="ui blue button" style="width: 100%;">REGISTER</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>  
<!---- START LOGIN MODAL---------------------------------------->
        <div id="login-modal" class="ui small modal">
            <i class="close icon"></i>
            <div class="header"> Login</div>

            <div class="content">
                <div class="ui basic  center aligned segment">

                    <form class="ui form" id="login-form" method="post">
                        <div id="error-login" class="ui negative message">
                            <p>
                                Wrong username/password!
                            </p>
                        </div>
                        <div class="ui fluid left icon input">
                            <i class="user icon"></i>
                            <input type="text" id="username" placeholder="Username">
                        </div>
                        <br>
                        <div class="ui fluid left icon input">
                            <i class="lock icon"></i>
                            <input type="text" id="password" placeholder="Password">
                        </div>
                    </form>
                </div>
            </div>
            <div class="actions">
                <div class="ui positive right button" type="submit" form="login-form"> Login</div>
            </div>
        </div>
<!---- END LOGIN MODAL------------------------------------------>
        
    </body>
</html>