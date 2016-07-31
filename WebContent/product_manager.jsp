<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<! DOCTYPE html>
<html>
<head>
    <script src="jquery-1.11.3.min.js"></script>
    <link rel="stylesheet" type="text/css" href="semantic-ui/dist/semantic.min.css">
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="semantic-ui/dist/semantic.js"></script>

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
			
        });
        function editProduct(index) {
        	document.getElementById("editId").value = document.getElementById("productId"+index).value;
        	document.getElementById("editName").value = document.getElementById("productName"+index).innerHTML;
        	document.getElementById("editPrice").value = parseFloat(document.getElementById("productPrice"+index).value).toFixed(2);
        	document.getElementById("editDescription").value = document.getElementById("productDescription"+index).value;
        	document.getElementById("editcb"+document.getElementById("productCategory"+index).innerHTML).checked = true;
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
<div id="#welcome-menu" class="ui container hidden">
    <div class="ui right aligned basic segment">
        <div class="ui grid middle aligned">
            <div class="fourteen wide column">
                 <div class="ui sub header"> Welcome Shayane!</div>
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
							<a href="#" onClick="filter(document.getElementById('filter-form'), '${category}');return false;">${category }</a>
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

			<c:forEach var="product" items="${products }" varStatus="loop">
				<div class="ui segment">
	                <div class="ui grid">
	                    <div class="ten wide column">
	                        <h3 class="ui header"><div id="productName${loop.index}">${product.name }</div>
	                            <div class="ui sub header"><fmt:formatNumber value="${product.price }" type="currency" currencyCode="PHP"/></div>
	                        </h3>
	                    </div>
	                    <div class="six wide column right aligned">
	                        <h1 class="ui sub header" id="productCategory${loop.index}">${product.category }</h1>
	                        <i class="write link icon" onClick="editProduct(${loop.index})"></i>
	                        <i class="trash link icon" onClick="deleteProduct(document.getElementById('delete-form'), ${product.id})"></i>
	                    </div>
	                </div>
           		</div>
           		<input type="hidden" id="productId${loop.index}" value="${product.id }" name="productId">
           		<input type="hidden" id="productPrice${loop.index}" value="${product.price }">
	            <input type="hidden" id="productDescription${loop.index}" value="${product.description }">
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
		                                                <input type="radio" name="addType" value="${category}" checked="checked">
		                                                <label>${category}</label>
		                                            </div>
		                                        </div>
		                                    </c:when>
		                                    <c:otherwise>
		                                    	<div class="field">
		                                            <div class="ui radio checkbox">
		                                                <input type="radio" name="addType" value="${category}">
		                                                <label>${category}</label>
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
													<input id="editcb${category}" type="radio" name="editType" value="${category}">
													<label>${category}</label>
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