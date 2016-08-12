<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <script src="resources/jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="resources/style.css">
    <script src="semantic-ui/dist/semantic.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#add-manager").click((function () {
//              $("#login-modal").modal('show');
              $("#error-password").hide();
              $("#password-modal")
                      .modal({
                          closable  : true,
                          onDeny    : function(){
                          },
                          onApprove : function() {

                          }
                      })
                      .modal('show')
              ;
          }));
            
            $('#logout').click(function(){
                $('#logout-form').submit();
            });

        });
        
        
        
        function submitForm(form) {
        	form.submit();
        }
        
        function changeFilter(form, filter) {
        	document.getElementById("filter").value = filter;
        	form.submit();
        }
    </script>
</head>
<body>
<div class="ui container">

    <div class="ui right aligned basic segment">
        <div class="ui grid middle aligned">
            <div class="fourteen wide column">
                 <div class="ui sub header"> Welcome Shayane!</div>
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
                            <a href="index.html">
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
	<input id="filter" type="hidden" name="filter" value="${filter }">
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
	                        <h3 class="ui header">${manager.user_name}
	                            <div class="ui sub header"></div>
	                        </h3>
	                    </div>
	                    <div class="six wide column right aligned">
	                        <h1 class="ui sub header">${manager.account_type}</h1>
	                        <i class="trash link icon bottom aligned"></i>
	                    </div>
	                </div>
	            </div>
			</c:forEach>
        </div>
        <div class="seven wide column">


            <div class="ui segment">


                <form class="ui form" action="AddManagerServlet" method="post">

                    <h2 class="ui header">Add Manager</h2>
                    <div>
                        <div class="ui grid middle aligned">
                            <div class="four wide column"><label>Username:</label></div>
                            <div class="twelve wide column"><input name="username" type="text"></div>
                        </div>
                        <div class="ui grid middle aligned">
                            <div class="four wide column"><label>Temporary Password:</label></div>
                            <div class="twelve wide column"><input name="temppass" type="text"></div>
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

                        <button id="add-manager" class="ui large orange submit button" type="submit">Add Manager</button>
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

            <form class="ui form" id="validate-password" method="post" action="UserPasswordValidationServlet">
                <div id="error-password" class="ui negative message">
                    <p>
                        Please fill up all fields!
                    </p>
                </div>
                <div>
                    <div class="ui grid middle aligned">
                        <div class="four wide column left aligned"><label>Password:</label></div>
                        <div class="twelve wide column"><input id="password" name="password" type="password"></div>
                    </div>

                </div>
            </form>
        </div>
    </div>
    <div class="actions">
        <div class="ui positive right button" onClick="submitForm(document.getElementById('validate-password'))">Confirm</div>
    </div>
</div>
</body>
</html>