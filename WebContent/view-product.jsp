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

            $("#btnminus").click(function(){
                var a = +$("#quantity").val();
                if(a>1) $("#quantity").val(a-1);
            });

            $("#btnplus").click(function(){
                var a = +$("#quantity").val();
                $("#quantity").val(a+1);
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
    <div class="ui grid">
        <div class="nine wide column">
            <img class="ui fluid image" src="assets/bababoots.jpg">
        </div>
        <div class="seven wide column">
            <h1 class="ui header">Rissa Bababoots (Red)
                <div class="sub header price-label">1,500.00</div>
            </h1>


            <p>
                Rissa Bababoots (Red) is an awesome boots that allows you to walk on gutter level floods.
            </p>
            <p>
                Loren ipsum bae rissa. Rissa the bae! The beh, the bah, and the boh.
            </p>

            <div class="ui divider"></div>

            <form class="ui form" method="post">
                <div class="inline field">
                    <label>Quantity</label>
                    <!--<button class="ui icon button middle">-->
                    <i id="btnminus" class="minus link icon"></i>
                    <!--</button>-->
                    <input type="text" id="quantity" name="quantity" value="1">
                    <!--<button class="ui icon button middle">-->
                    <i id="btnplus" class="plus link icon"></i>
                    <!--</button>-->
                </div>

                <div class="ui fluid large orange submit button">
                    <div><i class="big shop icon element"></i><span class="middle-align">ADD TO CART</span>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>