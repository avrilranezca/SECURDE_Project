<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<! DOCTYPE html>
<html>
<head>
    <script src="resources/jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="resources/semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="resources/style.css">
    <script src="resources/semantic-ui/dist/semantic.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".write.link.icon").click((function () {
//                $("#login-modal").modal('show');
                $("#error-edit-product").hide();
                $("#edit-product-modal")
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
            
            
          $('#changepw')
	        .modal({
	            closable  : false,
	            onDeny    : function(){
	//                window.alert('Wait not yet!');
	//                return false;
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
        function editProduct(index) {
        	document.getElementById("editId").value = document.getElementById("productId"+index).value;
        	document.getElementById("editName").value = document.getElementById("productName"+index).innerHTML;
        	document.getElementById("editPrice").value = parseFloat(document.getElementById("productPrice"+index).value).toFixed(2);
        	document.getElementById("editDescription").value = document.getElementById("productDescription"+index).value;
        	document.getElementById("editcb"+document.getElementById("productCategory"+index).innerHTML).checked = true;
        }
        
        $('#change-button').click(function(){
        	 var oldPassword = $('#oldpw').val();
        	 var newPassword = $('#newpw').val();
        	 alert("hello");
        	  $.ajax({
                  url: "ChangePasswordServlet",
                  data: {"oldpw": oldPassword,
                	  	 "newpw": newPassword},
                  type: "POST",
                  success: function(data){
                  		alert("data: "+data);	
                  }
              });
        	
        });
        
        function submitForm(form){
        	alert("form: "+ form);
        	form.submit();
        }
        
        function saveEdit(form) {
        	form.submit();
        }
        function filter(form, filter) {
        	document.getElementById("filter").value = filter;
        	form.submit();
        }
        function deleteProduct(form, id) {
        	document.getElementById("deleteProductId").value = id;
        	form.submit();
        }

    </script>
</head>
<body>
<c:choose>
	<c:when test='${isPermanent eq false}'>	
		<div class="ui small basic long modal" id="changepw" >
			<input type="hidden" value="product_manager.jsp" name="page">
		    <div class="header">Change temporary password</div>
		    <div class="content">
		        <p>Please change the temporary password given to you by the administrator. This is for security purposes.</p>
		        <div class="ui hidden divider"></div>
		        <form class="ui form" id="change-form" method="post" action="ChangePasswordServlet">
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
		        <div class="ui positive right button" type="submit" id="change-button"> 
		        	Change Password
		        </div>
		    </div>
		</div>
	</c:when>
</c:choose>
<div id="#welcome-menu" class="ui container">
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
                            <a href="DisplayProductsServlet">
                                <span>Talaria</span>
                                <div class="sub header">
                                    <span>Footwear Co.</span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>

                <div class="twelve wide column right aligned ">
                    <h1 class="ui inverted header">PRODUCT MANAGER</h1>
                </div>
            </div>

        </div>

    </div>
</div>

<div class="ui container basic segment">
    <div class="ui grid">
        <div class="nine wide column">
            <div class="ui basic segment headingc">
                <h2 class="ui header headerc">
                    Products
                </h2>
                <form id="filter-form" method="post" action="DisplayProductsServlet">
	                <div class="headingsubc">
	                	<c:choose>
							<c:when test="${filter eq 'All'}">
								<b><a href="#" onClick="filter(document.getElementById('filter-form'), 'All');return false;">All</a></b>
							</c:when>
							<c:otherwise>
								<a href="#" onClick="filter(document.getElementById('filter-form'), 'All');return false;">All</a>
							</c:otherwise>
						</c:choose>
	                
						<c:forEach var="category" items="${categories}" varStatus="loop">
							<c:choose>
								<c:when test="${filter eq category}">
									<b>
								</c:when>
							</c:choose>
							|
							<a href="#" onClick="filter(document.getElementById('filter-form'), <c:out value='${category}'/>);return false;">${category }</a>
							<c:choose>
								<c:when test="${filter eq category}">
									</b>
								</c:when>
							</c:choose>
						</c:forEach>
	                </div>
	                <input id="filter" type="hidden" name="filter" value="All">
	            </form>
            </div>

            <div class="ui basic segment headingd">
                <div class="headingsubc">
                    <b>SORT BY: </b><b><a href="#">Recent</a> </b> | <a href="#">Alphabetical</a>
                </div>
            </div>

            <div class="ui hidden divider"></div>

			<form id="delete-form" action="DeleteProductServlet" method="post">
           		<input type="hidden" id="deleteProductId" name="deleteProductId">
           	</form>

			<c:forEach var="product" items="${products}" varStatus="loop">
				<div class="ui segment">
	                <div class="ui grid">
	                    <div class="ten wide column">
	                        <h3 class="ui header">
	                        	<div id="productName<c:out value='${loop.index}'/>">
	                        		<c:out value='${product.name}'/>
	                        	</div>
	                            <div class="ui sub header">
	                            	<fmt:formatNumber value="${product.price}" type="currency" currencyCode="PHP"/>
	                            </div>
	                        </h3>
	                    </div>
	                    <div class="six wide column right aligned">
	                        <h1 class="ui sub header" id="productCategory<c:out value='${loop.index}'/>">
	                        	<c:out value='${product.category }'/>
	                        </h1>
	                        <i class="write link icon" onClick="editProduct(<c:out value="${loop.index}"/>)"></i>
	                        <i class="trash link icon" onClick="deleteProduct(document.getElementById('delete-form'), <c:out value='${product.id}'/>)"></i>
	                    </div>
	                </div>
           		</div>
           		<input type="hidden" id="productId<c:out value='${loop.index}'/>" value="<c:out value="${product.id }"/>" name="productId">
           		<input type="hidden" id="productPrice<c:out value='${loop.index}'/>" value="<c:out value='${product.price}'/>">
	            <input type="hidden" id="productDescription<c:out value='${loop.index}'/>" value="<c:out value ='${product.description}'/>">
			</c:forEach>
        </div>
        <div class="seven wide column">


            <div class="ui segment">

				<form class="ui form" method="post" action="AddProductServlet">

                    <h2 class="ui header">Add Product</h2>
                    <div>
                        <div class="ui grid middle aligned">
                            <div class="four wide column"><label>Name:</label></div>
                            <div class="twelve wide column"><input name="addName" type="text"></div>
                        </div>
                        <div class="ui grid middle aligned">
                            <div class="four wide column"><label>Price:</label></div>
                            <div class="twelve wide column"><input name="addPrice" type="text"></div>
                        </div>
                        <div class="ui grid">
                            <div class="four wide column"><label>Type:</label></div>
                            <div class="twelve wide column">
                                <div class="grouped fields">
                                    <div class="inline fields">
										<c:forEach var="category" items="${categories}" varStatus="loop">
											<c:choose>
											<c:when test="${loop.first}">
		                                        <div class="field">
		                                            <div class="ui radio checkbox">
		                                                <input type="radio" name="addType" value="<c:out value='${category}'/>" checked="checked">
		                                                <label><c:out value='${category}'/></label>
		                                            </div>
		                                        </div>
		                                    </c:when>
		                                    <c:otherwise>
		                                    	<div class="field">
		                                            <div class="ui radio checkbox">
		                                                <input type="radio" name="addType" value="<c:out value='${category}'/>">
		                                                <label><c:out value='${category}'/></label>
		                                            </div>
		                                        </div>
		                                    </c:otherwise>
		                                    </c:choose>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="ui grid aligned">
                            <div class="four wide column"><label>Description:</label></div>
                            <div class="twelve wide column">
                                <div class="field">
                                    <textarea name="addDescription"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <h4 class="ui hidden divider"></h4>
                    <div class="ui basic right aligned segment">

                        <button class="ui  large orange submit button" type="submit">Add Product</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div id="edit-product-modal" class="ui small modal">
    <i class="close icon"></i>
    <div class="header"> Edit Product</div>

    <div class="content">
        <div class="ui basic center aligned segment">

            <form class="ui form" id="edit-product" method="post" action="EditProductServlet">
                <div id="error-edit-product" class="ui negative message">
                    <p>
                        Please fill up all fields!
                    </p>
                </div>
				<input type="hidden" id="editId" name="editId">
                <div>
                    <div class="ui grid middle aligned">
                        <div class="four wide column left aligned"><label>Name:</label></div>
                        <div class="twelve wide column"><input id="editName" name="editName" type="text"></div>
                    </div>
                    <div class="ui grid middle aligned">
                        <div class="four wide column left aligned"><label>Price:</label></div>
                        <div class="twelve wide column"><input id="editPrice" name="editPrice" type="text"></div>
                    </div>
                    <div class="ui grid">
                        <div class="four wide column left aligned"><label>Type:</label></div>
                        <div class="twelve wide column">
                            <div class="grouped fields">
                                <div class="inline fields">
										<c:forEach var="category" items="${categories}"
											varStatus="loop">
											<div class="field">
												<div class="ui radio checkbox">
													<input id="editcb<c:out value='${category}'/>" type="radio" name="editType" value="<c:out value='${category}'/>">
													<label><c:out value='${category}'/></label>
												</div>
											</div>
										</c:forEach>
									</div>
                            </div>
                        </div>
                    </div>

                    <div class="ui grid aligned">
                        <div class="four wide column left aligned"><label>Description:</label></div>
                        <div class="twelve wide column">
                            <div class="field">
                                <textarea id="editDescription" name="editDescription"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="actions">
        <div class="ui positive right button" onClick="saveEdit(document.getElementById('edit-product'))">Save</div>
    </div>
</div>
</body>
</html>