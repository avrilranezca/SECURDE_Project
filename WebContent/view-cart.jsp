<%--
  Created by IntelliJ IDEA.
  User: rissa
  Date: 8/2/2016
  Time: 1:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="database.ProductDAO" %>
<%@ page import="model.Product" %>
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
                $("#login-modal").modal('show');
            });

            $(".btnminus").click(function(){
                var index = $(this).index(".btnminus");
                var a = +$(".txtquantity:eq("+index+")").val();
//                if(a>1)$(".txtquantity:eq("+index+")").val(a-1);
            });

            $(".btnplus").click(function(){
                var index = $(this).index(".btnplus");
                var a = +$(".txtquantity:eq("+index+")").val();
//                $(".txtquantity:eq("+index+")").val(a+1);
//                $("#quantity").val(a+1);

//                console.log(a);

            });


            $(".remove.icon").click(function(){
                var index = $(this).index(".remove.icon");
//                $("tr").eq(index+1).remove();
//                console.log(index);
            });
        });
    </script>
</head>
<body>
<div id="#login-menu" class="ui top attached menu">
    <div class="right menu">
        <div class="ui right aligned item top-nav">
            <a href="login.html" class="item top-nav-item">login</a>
            <a href="sign-up.html" class="item top-nav-item">sign up</a>
        </div>
    </div>
</div>
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
    <div class="ui four item pointing menu">
        <a class="item">
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
    <h2 class="ui header">Your Cart
    </h2>
    <table class="ui single line basic table">
        <thead>
        <tr>
            <th>Item</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Subtotal</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>
                <h4 class="ui image header">
                    <img src="assets/bababoots.jpg" class="ui mini rounded image">
                    <div class="content">
                        Bababoots
                    </div>
                </h4></td>
            <td>PHP 1,500.00</td>
            <td>

                <i class="btnminus minus link icon"></i>
                <div class="ui input">
                    <input type="number" class="txtquantity" name="quantity" value="3">
                </div>
                <i class="btnplus plus link icon"></i></td>
            <td>PHP 4,500.00</td>
            <td><i class="link bordered inverted red remove icon"></i></td>
        </tr>
        <tr>
            <td>
                <h4 class="ui image header">
                    <img src="assets/bababoots.jpg" class="ui mini rounded image">
                    <div class="content">
                        Bababoots
                    </div>
                </h4></td>
            <td>PHP 1,500.00</td>
            <td>
                <i class="btnminus minus link icon"></i>
                <div class="ui input">
                    <input type="number" class="txtquantity" name="quantity" value="2">
                </div>
                <i class="btnplus plus link icon"></i></td>
            <td>PHP 3,000.00</td>
            <td><i class="link bordered inverted red remove icon"></i></td>
        </tr>
        <tr>
            <td>
                <h4 class="ui image header">
                    <img src="assets/bababoots.jpg" class="ui mini rounded image">
                    <div class="content">
                        Bababoots
                    </div>
                </h4></td>
            <td>PHP 1,500.00</td>
            <td>
                <i class="btnminus minus link icon"></i>
                <div class="ui input">
                    <input type="number" class="txtquantity" name="quantity" value="4">
                </div>
                <i class="btnplus plus link icon"></i></td>
            <td>PHP 6,000.00</td>
            <td><i class="link bordered inverted red remove icon"></i></td>
        </tr>
        </tbody>
    </table>

    <div class="ui basic right aligned segment">
        <h3 class="ui header">Total: PHP 13,500.00</h3>
        <div class="ui large orange submit button">
            <div><span class="middle-align">CHECKOUT</span>
            </div>
        </div>
    </div>
</div>

</body>
</html>
