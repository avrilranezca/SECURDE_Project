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
                <div class="headingsubc">
                    <b><a href="#">All</a> </b> | <a href="#">Boots</a> | <a href="#">Shoes</a>| <a href="#">Sandals</a>
                    | <a href="#">Slippers</a>
                </div>
            </div>

            <div class="ui basic segment headingd">
                <div class="headingsubc">
                    <b>SORT BY: </b><b><a href="#">Recent</a> </b> | <a href="#">Alphabetical</a>
                </div>
            </div>

            <div class="ui hidden divider"></div>

            <div class="ui  segment">
                <div class="ui grid">
                    <div class="ten wide column">
                        <h3 class="ui header">Payday 2
                            <div class="ui sub header">PHP 565.00</div>
                        </h3>
                    </div>
                    <div class="six wide column right aligned">
                        <h1 class="ui sub header">Boots</h1>
                        <i class="write link icon"></i>
                        <i class="trash link icon"></i>
                    </div>
                </div>
            </div>
            <div class="ui  segment">
                <div class="ui grid">
                    <div class="ten wide column">
                        <h3 class="ui header">Dead By Daylight
                            <div class="ui sub header">PHP 565.00</div>
                        </h3>
                    </div>
                    <div class="six wide column right aligned">
                        <h1 class="ui sub header">Sandals</h1>
                        <i class="write link icon"></i>
                        <i class="trash link icon"></i>
                    </div>
                </div>
            </div>
            <div class="ui  segment">
                <div class="ui grid">
                    <div class="ten wide column">
                        <h3 class="ui header">Depth
                            <div class="ui sub header">PHP 565.00</div>
                        </h3>
                    </div>
                    <div class="six wide column right aligned">
                        <h1 class="ui sub header">Shoes</h1>
                        <i class="write link icon"></i>
                        <i class="trash link icon"></i>
                    </div>
                </div>
            </div>
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

                                        <div class="field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" name="addType" checked="checked" value="Boots">
                                                <label>Boots</label>
                                            </div>
                                        </div>
                                        <div class="field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" name="addType" value="Sandals">
                                                <label>Sandals</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="grouped fields">
                                    <div class="inline fields">

                                        <div class="field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" name="addType" value="Shoes">
                                                <label>Shoes</label>
                                            </div>
                                        </div>
                                        <div class="field">
                                            <div class="ui radio checkbox">
                                                <input type="radio" name="addType" value="Slippers">
                                                <label>Slippers</label>
                                            </div>
                                        </div>
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

            <form class="ui form" id="edit-product" method="post">
                <div id="error-edit-product" class="ui negative message">
                    <p>
                        Please fill up all fields!
                    </p>
                </div>

                <div>
                    <div class="ui grid middle aligned">
                        <div class="four wide column left aligned"><label>Name:</label></div>
                        <div class="twelve wide column"><input name="name" type="text"></div>
                    </div>
                    <div class="ui grid middle aligned">
                        <div class="four wide column left aligned"><label>Price:</label></div>
                        <div class="twelve wide column"><input name="price" type="text"></div>
                    </div>
                    <div class="ui grid">
                        <div class="four wide column left aligned"><label>Type:</label></div>
                        <div class="twelve wide column">
                            <div class="grouped fields">
                                <div class="inline fields">

                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="type" checked="checked">
                                            <label>Boots</label>
                                        </div>
                                    </div>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="type">
                                            <label>Sandals</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="grouped fields">
                                <div class="inline fields">

                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="type">
                                            <label>Shoes</label>
                                        </div>
                                    </div>
                                    <div class="field">
                                        <div class="ui radio checkbox">
                                            <input type="radio" name="type">
                                            <label>Slippers</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="ui grid aligned">
                        <div class="four wide column left aligned"><label>Description:</label></div>
                        <div class="twelve wide column">
                            <div class="field">
                                <textarea name="description"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="actions">
        <div class="ui positive right button" type="submit" form="edit-product" onClick="asd">Save</div>
    </div>
</div>
</body>
</html>