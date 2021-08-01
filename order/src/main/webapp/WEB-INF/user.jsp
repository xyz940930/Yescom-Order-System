<%@ page language="java" import="java.io.IOException" pageEncoding="ISO-8859-1" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="th" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
<%--    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script src="https://kit.fontawesome.com/249020923f.js"></script>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }


        #searchBar {
            text-align: left;
            font-family: arial, sans-serif;
        }

        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;

        }
        tr:nth-child(even) {
            background-color: #eee;
        }
        tr:nth-child(odd) {
            background-color: #fff;
        }

        .topnav {
            overflow: hidden;
            background-color: #333;
        }

        .topnav a {
            float: left;
            color: #f2f2f2;
            text-align: center;
            font-size: 17px;
            line-height: 30px;
            padding: 14px 16px;
            text-decoration: none;
        }

        .topnav a:hover {
            background-color: #ddd;
            color: black;
        }

        .topnav a.active {
            background-color: orange;
            color: white;
        }

        .topnav .not-active {
            pointer-events: none;
            cursor: default;
        }

        .topnav .float-right {
            float: right;
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

        .editEnable{
            float: right;
            font-size: 15px;
            cursor: pointer;
            font-weight: bold;
            padding:10px;
        }

        .fakePointer {
            cursor: pointer;
        }

        .pagination {
            display: inline-block;
        }

        .center {
            text-align: center;
        }

        .pagination a {
            color: black;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
            border: 1px solid #ddd;
            margin: 0 4px;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
            border: 1px solid #4CAF50;
        }

        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }


    </style>
</head>


<div class="topnav">
    <a class="active fakeAtag" id="back_btn">Back</a>


    <a href="/index" class="float-right"> Logout </a>
    <a href="/" class="not-active float-right">
        <span>Store:</span>
        <lbael style="margin-left: 10px" id="storename">${store}</lbael>
        <span> User:</span>
        <lbael id="username">${name}</lbael>
    </a>
</div>

<br>
<div id="searchBar">
    <form action="/showUsers?name=${name}&store=${store}" id="searchHistory" method="post">
        <label for="search_username" placeholder="Enter Username">Username :</label>
        <input type="text" id="search_username" name="search_username">
        <label for="company" placeholder="Enter Company Name">Company :</label>
        <input type="text"  name="search_company">
        <input type="submit" id="btnSearch" value="Search">
    </form>
</div>


<table id="userTable" class="display">
    <tr>
        <th>User ID</th>
        <th>Username</th>
        <th>User Password</th>
        <th>Role</th>
        <th>Company</th>
        <th></th>

    </tr>
    <c:forEach var="user" items="${userlist}">
        <tr id="${user.id}">
            <td>${user.id}</td>
            <td>${user.name}</td>
            <td>${user.password}</td>
            <td>${user.role}</td>
            <td>${user.company}</td>
            <td><input type="button" class="btnEdit" value="Edit"></td>
        </tr>
    </c:forEach>

</table>

<div id="editModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">


        <div class="w3-container w3-card-4 w3-light-grey w3-text-orange w3-margin">
            <span id="editClose" class="close">&times;</span>
            <span id="editEnable" class="editEnable">Edit</span>
            <h2 class="w3-center">User ID: <span id="userID"></span></h2>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
                <div class="w3-rest">
                    <span>Username:</span><input class="w3-input w3-border" type="text" id="name" disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fas fa-key"></i></div>
                <div class="w3-rest">
                    <span>Password:</span><input class="w3-input w3-border" id="password" type="text" disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge far fa-id-card"></i></div>
                <div class="w3-rest">
                    <span>Role:</span> <input class="w3-input w3-border" id="role" type="text" disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge 	fas fa-building"></i></div>
                <div class="w3-rest">
                    <span>Company:</span><input class="w3-input w3-border" id="company" type="text" disabled>
                </div>
            </div>

            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="updateBtn">Update</button>
            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="deleteBtn">Delete</button>

        </div>
    </div>

</div>






<div class="center">
    <div class="pagination">
        <tr>
            <td><a href="/showUsers?name=${name}&store=${store}&pageNum=1">First Page</a></td>

            <td th:if="${pageInfo.hasPreviousPage}"><a
                    href="/showUsers?name=${name}&store=${store}&pageNum=${pageInfo.pageNum-1}">&laquo;</a>
            </td>
            <td><a>${pageInfo.pageNum}/${pageInfo.pages}</a></td>
            <td th:if="${pageInfo.hasNextPage}"><a
                    href="/showUsers?name=${name}&store=${store}&pageNum=${pageInfo.pageNum+1}">&raquo;</a>
            </td>
            <td><a href=/showUsers?name=${name}&store=${store}&pageNum=${pageInfo.pages}">Last Page</a></td>
        </tr>

    </div>
</div>

</body>

<script>
    $("#back_btn").click(function (){
        var store = $('#storename').html();
        var username = $('#username').text();
        window.location.href = "/showTickets?name=" + username + "&store=" + store;
    });



    /*Edit Modal Operation*/
    var editModal = document.getElementById("editModal");
    var editSpan = document.getElementById("editClose");

    editSpan.onclick = function () {
        editModal.style.display = "none";
    };

    $(".btnEdit").click(function () {
        var params = {};
        params.id = $(this).parent().parent().attr("id");

        $.ajax({
            type: "POST",
            url: "/getUser",
            data: params,
            dataType: "json",
            success: function (data) {
                $("#userID").text(data.id);
                $("#name").val(data.name);
                $("#password").val(data.password);
                $("#role").val(data.role);
                $("#company").val(data.company);

            },
            error: function (err) {
                alert("Error!!! Cannot Edit Ticket ! Please Try again or contact your technician");
            }
        });

        editModal.style.display = "block";

    });


    /*Update Button Onlick Check*/
    $('#updateBtn').click(function () {
        if (!$("#password").val()) {
            alert("Please Enter Password");

            return false
        }
        if (!$("#company").val()) {
            alert("Please Enter Company");
            return false
        }

        updateUser();
    });


    /*Update Ticket Ajax*/
    function updateUser() {

        var params = {};
        params.id = $("#userID").text();
        params.name = $("#name").val();
        params.password = $("#password").val();
        params.role = $("#role").val();
        params.company = $("#company").val();

        $.ajax({
            type: "POST",
            url: "/updateUser",
            data: params,
            dataType: "json",
            success: function (data) {
                /*                alert("Update Success");*/
                editModal.style.display = "none";
                location.reload();
            },
            error: function (err) {
                alert("Update Ticket Failed, Please contact your technician for reference");
            }

        });

    }


    $('#deleteBtn').click(function () {
        var answer = confirm("Warning!!! Please make sure that you want to delete this ticket")
        if (!answer) {
            return false;
        } else {

            var params = {};
            params.id = $("#userID").text();

            $.ajax({
                type: "POST",
                url: "/deleteUser",
                data: params,
                dataType: "json",
                success: function (data) {
                    /*                    alert("Ticket Delete Success");*/
                    location.reload();
                },
                error: function (err) {
                    alert("Error!!! Please Try again or contact your technician");
                }
            });
        }
    });



    $('.editEnable').click(function(){


        $("#password").prop("disabled", false);
        $("#company").prop("disabled", false);

    });


</script>
</html>

