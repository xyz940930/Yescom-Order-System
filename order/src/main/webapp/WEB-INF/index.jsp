<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>Mobile Muster Ticket System</title>
    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script src="https://kit.fontawesome.com/249020923f.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <style>

        body {
            text-align: center;
        }

        #errormessage {
            color: red;
            font-size: 15px;
        }

        /* The Modal (background) */
        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0, 0, 0); /* Fallback color */
            background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
        }

        /* Modal Content/Box */
        .modal-content {
            margin: 10% auto; /* 15% from the top and centered */
            padding: 20px;
            width: 80%; /* Could be more or less, depending on screen size */
        }

        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

    </style>

    <script src="js/jquery-3.3.1.min.js"></script>
</head>

<body>
<!-- Button to open the modal login form -->
<img src="images/logo.PNG" height="500" width="500">
<form action="/login" id="login" method="post" style="position: relative; top:100px;">
    <label for="username" placeholder="Enter Username">Username:</label><br>
    <input type="text" id="username" name="username"><br>
    <label for="password" placeholder="Enter Password">Password:</label><br>
    <input type="password" id="password" name="password"><br><br>
    <input type="checkbox" onclick="myFunction()">Show Password
    <br>
    <label hidden="hidden" id=errormessage>Username or Password is invalid</label><br>
    <input type="button" id="btnLogin" value="Login">
</form>


<div id="storeSelectionModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">


        <div class="w3-container w3-card-4 w3-light-grey w3-text-orange w3-margin">
            <span id="storeSelectionClose" class="close">&times;</span>
            <h2 class="w3-center">Select Your Store</h2>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fas fa-store"></i></div>
                <div class="w3-rest">
                    <select class="w3-input w3-border" id="storelist">
                    </select>
                </div>
            </div>

            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="selectBtn">Select</button>

        </div>
    </div>

</div>
<span id='loginUsername'
      style="display:none"></span>
</body>


<%--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>--%>
<script>
    function myFunction() {
        var x = document.getElementById("password");
        if (x.type == "password") {
            x.type = "text";
        } else {
            x.type = "password";
        }
    }


    $('#btnLogin').click(function () {
        check();
    });
    //???????????
    $("body").keydown(function (event) {
        if (event.keyCode == "13") {// keyCode=13????
            $('#btnLogin').click();
        }
    });

    var storeSelectionModal = document.getElementById("storeSelectionModal");
    var storeSelectionClose = document.getElementById("storeSelectionClose");

    storeSelectionClose.onclick = function () {
        storeSelectionModal.style.display = "none";
        location.reload();
    };


    function check() {
        var params = {};
        if (!($("#username").val()) || !($("#password").val())) {
            alert("Please enter your username or password")
            return false //????????
        }
        params.username = $("#username").val();
        params.password = $("#password").val();


        $.ajax({
            type: "POST",
            url: "/login",
            data: params,
            dataType: "json",
            success: function (data) {
                if (data.result == 'success') {

                    for (i of data.stores) {
                        $('#storelist').append($('<option>', {
                            value: i,
                            text: i
                        }));
                    }
                    storeSelectionModal.style.display = "block";
                    $('#loginUsername').text(data.username);


                } else {

                    $("#errormessage").removeAttr("hidden");
                }

            },
            error: function (err) {
                alert("????-loginPage.jsp-ajax");
            }
        });
    }

    $('#selectBtn').click(function () {
        var store = $('#storelist').val();
        var username = $('#loginUsername').text();
        window.location.href = "/showTickets?name=" + username + "&store=" + store;
    });


</script>


</html>
