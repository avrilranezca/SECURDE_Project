<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            
            $('#logout').click(function(){
                $('#logout-form').submit();
            });
            
        	var password = $('[name="password"]');
            $.fn.form.settings.rules.passwordMinLength = function(value) {
       		    var currentPassValue = password.length > 0 ? password.val() : undefined;
       		    if(currentPassValue === undefined || currentPassValue.length === 0) {
       		      return true;
       		    }
       		    return value.length >= 7;
       		  };
       		  
            $('#add-manager').form({
            	fields :{
            		  username: {
	                      identifier: 'username',
	                      rules: [
	                        {
	                          type   : 'empty',
	                          prompt : 'Please enter a username'
	                        },{
	                        	type	: 'regExp[/([A-Za-z0-9_]+$)/]',
	                        	prompt	: 'Please enter a valid username. A username may contain alphanumeric characters with an optional underscore only'
	                        }
	                      ]
	                    },
	                    temppass: {
	                      identifier: 'temppass',
	                      rules: [
	                        {
	                        	type   : 'empty',
	                        	prompt : 'Please enter a password'
	                        },{
	                        	type 	: 'passwordMinLength',
	                        	prompt 	: 'Your password must contain at least 7 characters'
	                        },{
	                        	type	: 'regExp[/([a-z].*[A-Z])|([A-Z].*[a-z])/]',
	                        	prompt	: 'Your password must contain at least one lowercase and uppercase letter'
	                        },{
	                        	type	: 'regExp[/([0-9])/]',
	                        	prompt	: 'Your password must contain at least one number'
	                        },{
	                        	type 	: 'regExp[/([!,%,&,@,#,$,^,*,?,_,~,:,.])/]',
	                        	prompt	: 'Your password must contain at least one special character'
	                        }
	                      ]
	                    }
            	},
            	 on: 'blur',
                 inline: true,
                 onSuccess : function(event, fields){
                	alert("here")
                    submitAddForm();
                 	return false;
                 },
                 onFail: function(){
                 	return false;
                 }
            });

        });
        
        
        function submitAddForm() {
            alert("subimit me Add Manager form!");
            $("#error-password").hide();
            $("#password-modal")
                  .modal({
                      closable: true,
                      onDeny: function () {
                          alert("fail");
                      },
                      onApprove: function () {
                          alert("yes");
                          if ($("#password").val() == "") {
                              $("#error-password").show();
                          }

                          var password = $("#user-password").val();
                          $.ajax({
                              url: "AddManagerServlet",
                              data: {
                            	  	"password": password,
                              		"username" : $("input[name='username']").val(),
                              		"temppass" : $("input[name='temppass']").val(),
                              		"type"	   : $("input[name='type']:checked").val()	  
                              	},
                              type: "POST",
                              error: function (data) {
                                  alert("fail: ");
                              },
                              success: function (data) {
                                  if (data == '-1') {
                                      $("#error-password p").text("Incorrect Password!");
                                      $("#error-password").show();

                                  } else {
                                      $('#password-modal').modal('hide');

                                      window.location.href = 'DisplayManagersServlet';
                                      return true;
                                  }
                              }
                          });

                          return false;
                      }
                  })
                  .modal('show');
        }
        
        function submitForm(form) {
        	form.submit();
        }
        
        function changeFilter(form, filter) {
        	document.getElementById("filter").value = filter;
        	form.submit();
        }
        
        function deleteManager(id) {
           
         	alert("subimit me Delete!");
             $("#error-password").hide();
             $("#password-modal")
                     .modal({
                         closable: true,
                         onDeny: function () {
                             alert("fail");
                         },
                         onApprove: function () {
                             alert("yes");
                             if ($("#password").val() == "") {
                                 $("#error-password").show();
                             }

                             var password = $("#user-password").val();
                             $.ajax({
                                 url: "DeleteManagerServlet",
                                 data: {"password": password,
                                 	   "deleteManagerId" : id
                                 	},
                                 type: "POST",
                                 error: function (data) {
                                     alert("fail: ");
                                 },
                                 success: function (data) {
                                     if (data == '-1') {
                                         $("#error-password p").text("Incorrect Password!");
                                         $("#error-password").show();

                                     } else {
                                         $('#password-modal').modal('hide');

                                         window.location.href = 'DisplayManagersServlet';
                                         return true;
                                     }
                                 }
                             });

                             return false;
                         }
                     })
                     .modal('show');
         }
    </script>
</head>
<body>
<div class="ui container">

    <div class="ui right aligned basic segment">
        <div class="ui grid middle aligned">
            <div class="fourteen wide column">
                 <div class="ui sub header"> Welcome <c:out value='${user}'/>!</div>
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
                            <a href="DisplayManagersServlet">
                                <span>Talaria</span>
                                <div class="sub header">
                                    <span>Footwear Co.</span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="twelve wide column right aligned ">
                    <h1 class="ui inverted header">ADMINISTRATOR</h1>
                </div>
            </div>

        </div>

    </div>
</div>

<form id="filter-form" action="DisplayManagersServlet" method="post">
	<input id="filter" type="hidden" name="filter" value="<c:out value='${filter}'/>">
</form>

<div class="ui container basic segment">
    <div class="ui grid">
        <div class="nine wide column">
            <div class="ui basic segment headingc">
                <h2 class="ui header headerc">
                    Managers
                </h2>
                <div class="headingsubc">
                    <c:choose>
                    	<c:when test="${filter eq 'All' }">
                    		<b>
                    	</c:when>
                    </c:choose>
                    <a href="#" onClick=" changeFilter(document.getElementById('filter-form'), 'All');return false;">All</a></b>
                    <c:choose>
						<c:when test="${filter eq 'All'}">
							</b>
						</c:when>
					</c:choose>
                    |
					<c:choose>
						<c:when test="${filter eq 'Product'}">
							<b>
						</c:when>
					</c:choose>
					<a href="#" onClick="changeFilter(document.getElementById('filter-form'), 'Product');return false;">Product</a></b>
					<c:choose>
						<c:when test="${filter eq 'Product'}">
							</b>
						</c:when>
					</c:choose>
					|
					<c:choose>
						<c:when test="${filter eq 'Accounting'}">
							<b>
						</c:when>
					</c:choose>
					<a href="#" onClick="changeFilter(document.getElementById('filter-form'), 'Accounting');return false;">Accounting</a></b>
					<c:choose>
						<c:when test="${filter eq 'Accounting'}">
							</b>
						</c:when>
					</c:choose>
				</div>
            </div>

			<c:forEach var="manager" items="${managers}">
				<div class="ui segment">
	                <div class="ui grid">
	                    <div class="ten wide column">
	                        <h3 class="ui header">
	                        	<c:out value='${manager.user_name}'/>
	                            <div class="ui sub header"></div>
	                        </h3>
	                    </div>
	                    <div class="six wide column right aligned">
	                        <h1 class="ui sub header">
	                        	<c:out value='${manager.account_type}'/>
	                        </h1>
	                          <i class="trash link icon bottom aligned"
                               onClick="deleteManager(<c:out value='${manager.id}'/>)"></i>
	                    </div>
	                </div>
	            </div>
			</c:forEach>
        </div>
        <div class="seven wide column">
            <div class="ui segment">
                <form id="add-manager" class="ui form">

                    <h2 class="ui header">Add Manager</h2>
                    <div>
                        <div class="ui grid middle aligned field">
                            <div class="four wide column"><label>Username:</label></div>
                            <div class="twelve wide column"><input name="username" type="text"></div>
                        </div>
                        <div class="ui grid middle aligned field">
                            <div class="four wide column"><label>Temporary Password:</label></div>
                            <div class="twelve wide column"><input name="temppass" type="password"></div>
                        </div>
                        <div class="ui grid">
                            <div class="four wide column"><label>Type:</label></div>
                            <div class="twelve wide column">
                                <div class="grouped fields">
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="type" value="PRODUCT" checked="checked">
                                            <label>Product</label>
                                        </div>
                                    </div>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="type" value="ACCOUNTING">
                                            <label>Accounting</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h4 class="ui hidden divider"></h4>
                    <div class="ui basic right aligned segment">
                        <button class="ui large orange submit button">Add Manager</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div id="password-modal" class="ui small modal">
    <i class="close icon"></i>
    <div class="header">Please enter your password to continue</div>

    <div class="content">
        <div class="ui basic center aligned segment">

            <form class="ui form" id="validate-password">
                <div id="error-password" class="ui negative message">
                    <p>
                        Please fill up all fields!
                    </p>
                </div>
                <div>
                    <div class="ui grid middle aligned field">
                        <div class="four wide column left aligned"><label>Password:</label></div>
                        <div class="twelve wide column"><input id="user-password" name="password" type="password"></div>
                    </div>

                </div>
            </form>
        </div>

    </div>
    <div class="actions">
        <div id="confirm-password" class="ui positive right button">Confirm</div>
    </div>
</div>
</body>
</html>