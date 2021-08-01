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
    <form action="/showSales?name=${name}&store=${store}" id="searchTicket" method="post">
<%--        <label for="startDate" >Start Date:</label>
        <input type="date" id= "startDate"name="startDate"
               placeholder="yy/MM/dd">

        <label for="endDate" >Start Date:</label>
        <input type="date" id= "endDate"name="endDate"
               placeholder="yy/MM/dd">--%>
        <label>Dates: </label>
        <input type="text" name="dates" value="" />
    </form>
</div>

<h2>
    <c:choose>
        <c:when test="${date != null}">
            Summary for ${date}
        </c:when>
        <c:otherwise>
            Summary for ${startDate}  To  ${endDate}
        </c:otherwise>


    </c:choose>
</h2>

<table id="ticketTable" class="display">
    <tr>
        <th>Store</th>
        <th>Sales</th>
        <th>GST</th>
        <th>Sales Exlude GST</th>
        <th>Total Tickets</th>
        <th>Tickets Checked Out</th>
        <th>Paid Partial</th>
        <th>Repaird but Not Collected</th>
        <th>Send Away for Repair</th>
    </tr>
    <c:forEach var="sale" items="${sales}">
        <tr>
            <td>${sale.store}</td>
            <td>${sale.sales}</td>
            <td>${sale.GST}</td>
            <td>${sale.salesExlGst}</td>
            <td>${sale.ticketNum}</td>
            <td>${sale.salesNum}</td>
            <td>${sale.paidPartial}</td>
            <td>${sale.repaired}</td>
            <td>${sale.sendAway}</td>
        </tr>
    </c:forEach>

</table>


</body>

<script>
    $("#back_btn").click(function (){
        var store = $('#storename').html();
        var username = $('#username').text();
        window.location.href = "/showTickets?name=" + username + "&store=" + store;
    });


    $(function() {
        $('input[name="dates"]').daterangepicker({
            opens: 'left'
        }, function(start, end, label) {
            var store = $('#storename').html();
            var username = $('#username').text();
            var startDate = start.format('YYYY-MM-DD');
            var endDate = end.format('YYYY-MM-DD');
            window.location.href = "/showSales?name=" + username + "&store=" + store +"&startDate="+startDate+"&endDate=" +endDate;

        });
    });


</script>
</html>

