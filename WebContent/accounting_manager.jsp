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
	        
	        $('#changepw')
	            .modal({
	                closable: false,
	                onDeny: function () {
	                    //                window.alert('Wait not yet!');
	                    //                return false;
	                },
	                onApprove: function () {
	
//	                    alert("hllo");
	
	                    var strength = 0;
	
	                    if ($("#oldpw").val() == "" || $("#newpw").val() == "" || $("#confirmnewpw").val() == "") {
	                        $("#error-change").show();
	                        $("#error-change p").text("Please fill in all fields!");
	                    }
	                    else {
	
	                        if ($("#newpw").val().length > 7) {
	                            strength += 1;
//	                            alert("pasok length");
	                        }
	
	                        // If password contains both lower and uppercase characters, increase strength value.
	                        if ($("#newpw").val().match(/([a-z].*[A-Z])|([A-Z].*[a-z])/)) {
	                            strength += 1;
//	                            alert("pasook uppercase and lowercase")
	                        }
	                        // If it has numbers and characters, increase strength value.
	                        if ($("#newpw").val().match(/([a-zA-Z])/) && $("#newpw").val().match(/([0-9])/)) {
//	                            alert("pasok numbers and characters");
	                            strength += 1;
	                        }
	                        // If it has one special character, increase strength value.
	                        if ($("#newpw").val().match(/([!,%,&,@,#,$,^,*,?,_,~,:,.])/)) {
//	                            alert("pasok special characters");
	                            strength += 1;
	                        }
	                        // If it has two special characters, increase strength value.
	                        if ($("#newpw").val().match(/(.*[!,%,&,@,#,$,^,*,?,_,~,:,.].*[!,%,&,@,#,$,^,*,?,_,~,:,.])/))
	                            strength += 1;
	
	                        if (strength < 4) {
//	                            alert("strength: " + strength);
	                            var error_poorpw = "<br> Weak password! Your password must meet the following requirements: " +
	                                    "<ul> " +
	                                    "<li>At least one special character</li>" +
	                                    "<li>At least one capital letter</li>" +
	                                    "<li>At least one number</li>" +
	                                    "<li>At least 7 characters</li>" +
	                                    "</ul> ";
	                            $("#error-change").show();
	                            $("#error-change p").append(error_poorpw);
	
	                            $("#newpw").css('color', 'red');
	                        }
	
	                        if ($("#newpw").val() != $("#confirmnewpw").val()) {
	                            var error_mismatch = "New password does not match with the confirmation password! ";
	
	                            if ($("#error-change p").val() == "")
	                                $("#error-change p").text(error_mismatch);
	                            else
	                                $("#error-change p").append("<br> " + error_mismatch);
	
	                            $("#error-change").show();
	                            $("#newpw").css('color', 'red');
	                            $("#confirmnewpw").css('color', 'red');
	                        }else{
	                        	strength += 1;
	                        	$("#newpw").css('color', 'black');
		                        $("#confirmnewpw").css('color', 'black');
	                        }
	                    }
	                   
	                   if(strength > 4){
	                	   var password = $("#user-password").val();
		                    var oldPassword = $('#oldpw').val();
		                    var newPassword = $('#newpw').val();
		
		                    $.ajax({
		                        url: "ChangePasswordServlet",
		                        data: {
		                            "oldpw": oldPassword,
		                            "newpw": newPassword
		                        },
		                        type: "POST",
		                        error: function (data) {
//		                            alert("fail: ");
		                        },
		                        success: function (data) {
//		                            alert("data:" + data);
		                            if (data == '-1') {
		                                $("#error-change p").text("Incorrect Password!");
		                                $("#error-change").show();
		
		                            } else{
		                                $('#changepw').modal('hide');
		                                window.location.href = 'DisplayFinancialRecordsServlet';
		                                return true;
		                            }
		                        }
		                    });
		
	                   }
	                    return false;
	
	                }
	            })
	            .modal('show');
	        
        });
        
        function changeFilter(form, filter) {
        	document.getElementById("filter").value = filter;
        	form.submit();
        }
        
        function changeSubfilter(form, subfilter) {
        	document.getElementById("subfilter").value = subfilter;
        	form.submit();
        }
    </script>
</head>
<body>
<c:choose>
    <c:when test='${isPermanent eq false}'>
        <div class="ui small basic long modal" id="changepw">
            <div class="header">Change temporary password</div>
            <div class="content">
                <p>Please change the temporary password given to you by the administrator. This is for security
                    purposes.</p>
                <div class="ui hidden divider"></div>
                <form class="ui form" id="change-form" method="post" action="ChangePasswordServlet">
                    <div id="error-change" class="ui negative message">
                        <p>Please fill in all fields!</p>
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
                <div class="ui positive right button" type="submit" id="change-button">
                    Change Password
                </div>
            </div>
        </div>
    </c:when>
</c:choose>
<div class="ui container">
    <div class="ui right aligned basic segment">
        <div class="ui grid middle aligned">
            <div class="fourteen wide column">
                 <div class="ui sub header"> Welcome <c:out value="${user}"/>!</div>
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
                            <a href="DisplayFinancialRecordsServlet">
                                <span>Talaria</span>
                                <div class="sub header">
                                    <span>Footwear Co.</span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="twelve wide column right aligned ">
                    <h1 class="ui inverted header">ACCOUNTING MANAGER</h1>
                </div>
            </div>
        </div>
    </div>
</div>
    
<div class="ui container basic segment">
    <div class="ui grid">
			<div class="sixteen wide column">
				<div class="ui basic segment headingc">
					<h2 class="ui header headerc">Financial Records</h2>
					<div class="headingsubc">
						<form id="filter-form" action="DisplayFinancialRecordsServlet" method="post">
							<input id="filter" name="filter" type="hidden" value="Total">
							<input id="subfilter" name="subfilter" type="hidden" value="Daily"> 
						</form>
						<c:choose>
							<c:when test="${filter eq 'Total'}">
								<b>
							</c:when>
						</c:choose>
						<a href="#" onClick="changeFilter(document.getElementById('filter-form'), 'Total');return false;">Total</a>
						<c:choose>
							<c:when test="${filter eq 'Total'}">
								</b>
							</c:when>
						</c:choose>
						|
						<c:choose>
							<c:when test="${filter eq 'Category'}">
								<b>
							</c:when>
						</c:choose>
						<a href="#" onClick="changeFilter(document.getElementById('filter-form'), 'Category');return false;">Category</a></b>
						<c:choose>
							<c:when test="${filter eq 'Category'}">
								</b>
							</c:when>
						</c:choose>
						|
						<c:choose>
							<c:when test="${filter eq 'Product'}">
								<b>
							</c:when>
						</c:choose>
						<a href="#" onClick="changeFilter(document.getElementById('filter-form'), 'Product');return false;">Product</a>
						<c:choose>
							<c:when test="${filter eq 'Product'}">
								</b>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${filter eq 'Total'}">
								<br>
								<c:choose>
									<c:when test="${subfilter eq 'Daily' }">
										<b>
									</c:when>
								</c:choose>
								<a href="#" class="subfilter" onClick="changeSubfilter(document.getElementById('filter-form'), 'Daily');return false;">Daily</a>
								<c:choose>
									<c:when test="${subfilter eq 'Daily' }">
										</b>
									</c:when>
								</c:choose>
								|
								<c:choose>
									<c:when test="${subfilter eq 'Monthly' }">
										<b>
									</c:when>
								</c:choose>
								<a href="#" class="subfilter" onClick="changeSubfilter(document.getElementById('filter-form'), 'Monthly');return false;">Monthly</a>
								<c:choose>
									<c:when test="${subfilter eq 'Monthly' }">
										</b>
									</c:when>
								</c:choose>
								|
								<c:choose>
									<c:when test="${subfilter eq 'Yearly' }">
										<b>
									</c:when>
								</c:choose>
								<a href="#" class="subfilter" onClick="changeSubfilter(document.getElementById('filter-form'), 'Yearly');return false;">Yearly</a>
								<c:choose>
									<c:when test="${subfilter eq 'Yearly' }">
										</b>
									</c:when>
								</c:choose>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="sixteen wide column">
            <table class="ui single line basic table">
					<thead>
						<tr>
							<c:choose>
								<c:when test="${filter eq 'Total'}">
									<th class="eight wide">Date</th>
								</c:when>
								<c:otherwise>
									<th class="eight wide"><c:out value="${filter}"/></th>
								</c:otherwise>
							</c:choose>
							<th class="four wide right aligned">Quantity</th>
							<th class="four wide right aligned">Subtotal</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="sale" items="${sales}">
							<tr>
								<td><h4 class="ui header"><c:out value="${sale.name}"/></h4></td>
								<td class="right aligned"><c:out value="${sale.quantity}"/></td>
								<td class="right aligned price-label">
									<fmt:formatNumber value="${sale.total_sales}" type="currency" currencyCode="PHP" />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
            <div class="ui basic right aligned segment">
                <h3 class="ui header">Total: 
                	<span class="black-text">
                		<fmt:formatNumber value="${total}" type="currency" currencyCode="PHP" />
                	</span>
                </h3>
            </div>
        </div>    
    </div>
</div>

</body>
</html>