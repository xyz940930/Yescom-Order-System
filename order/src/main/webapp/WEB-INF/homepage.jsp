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
    <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
    <script src="https://kit.fontawesome.com/249020923f.js"></script>
    <%--    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>--%>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
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
            display: none;
            position: relative;
        }

        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
            border: solid 1px
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        /*      tr:nth-child(even) {
                    background-color: #eee;
                }
                tr:nth-child(odd) {
                    background-color: #fff;
                }*/

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

        .editEnable {
            float: right;
            font-size: 15px;
            cursor: pointer;
            font-weight: bold;
            padding: 10px;
        }

        .fakePointer {
            cursor: pointer;
        }

        .btnView {
            text-decoration: underline;
            color: #2e8ded;
        }

        tr:hover td {
            background-color: #ddd;
            color: black;
            /*             text-decoration: underline;
                         cursor: pointer;*/
        }

        .pagination {
            display: inline-block;
        }

        .paginationDiv {
            text-align: center;
            position: absolute;
            font-size: 15px;
            bottom: 0;
            left: 0;
            right: 0;
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

        .status td {
            border: 2px solid black;
            background-color: white;
            color: black;
            font-size: 16px;
        }

        .inProgress {
            /*           border-color: #f44336;*/
            color: #ff5722;
        }

        .finished {
            /*            border-color: #4CAF50;*/
            color: white;
            background-color: #4CAF50;
        }

        .fixed {
            /*            border-color: #2196F3;*/
            color: dodgerblue;
        }

        .paidPartial {
            /*            border-color: #ff9800;*/
            color: orange;
        }

        .sendAway {
            /*            border-color: #e7e7e7;*/
            color: #616161;
        }
        .canceled{
            color: red;
        }

        #notesPanel {
            display: none;
        }

        .switchInvo {
            text-align: center;
            position: absolute;
            font-size: 15px;
            bottom: 40px;
            left: 0;
            right: 0;
            font-size: 15pt;
        }

        #warrantyBtn {
            display: none;
        }

        .form-inline {
            display: flex;
            flex-flow: row wrap;
            align-items: center;
        }

        .form-inline label {
            margin: 5px 10px 5px 0;
        }

        .form-inline input {
            vertical-align: middle;
            margin: 5px 10px 5px 0;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        .form-inline button {
            padding: 10px 20px;
            background-color: dodgerblue;
            border: 1px solid #ddd;
            color: white;
            cursor: pointer;
        }

        .form-inline button:hover {
            background-color: royalblue;
        }

    </style>
</head>


<div class="topnav">
    <a class="active fakePointer" id="createNew">New Ticket</a>
    <a class=" fakePointer" id="productSale">Accessories Sale</a>
    <a class=" fakePointer" href=/showSales?name=${name}&store=${store}>TotalSales</a>
    <%--    <a class=" fakePointer" href=/showLoggers?name=${name}&store=${store}>Update History</a>--%>
    <a class=" fakePointer" id="changeStore">Store</a>
    <a href="/showUsers?name=${name}&store=${store}" id="manageUser" hidden="hidden">Manage Users</a>

    <a href="/index" class="float-right"> Logout </a>
    <a href="/" class="not-active float-right">
        <span>Store:</span>
        <lbael style="margin-left: 10px" id="storename">${store}</lbael>
        <span> User:</span>
        <lbael id="username">${name}</lbael>
    </a>
</div>

<br>
<div>
    <button class="w3-button <%--w3-block --%>w3-section w3-orange w3-ripple w3-padding" style="float: left"
            id="searchBarSlideShow">Search
    </button>
</div>
<br/>
<br/>
<br/>

<div id="searchBar" style="float: left;">
    <form class=form-inline action="/searchTickets?name=${name}&store=${store}" method="post">
        <label for="searchTicketID" placeholder="Enter TicketID">Ticket ID:</label>
        <input type="text" id="searchTicketID" name="searchTicketID">
        <label for="searchCustomerName" placeholder="Enter customerName">Customer Name:</label>
        <input type="text" id="searchCustomerName" name="searchCustomerName">
        <label for="searchMobile" placeholder="Enter Mobile">Mobile:</label>
        <input type="text" id="searchMobile" name="searchMobile">
        <label for="searchDevice" placeholder="Enter Device">Device:</label>
        <input type="text" id="searchDevice" name="searchDevice">
        <label for="searchDevice" placeholder="Select Ticket Status">Ticket Status:</label>
        <select id="searchTicket" name="status">
            <option value="All">All</option>
            <option value="In Progress">In Progress</option>
            <option value="Finished">Finished</option>
            <option value="Repaired">Repaired</option>
            <option value="Send Away">Send Away</option>
            <option value="Paid Partial">Paid Partial</option>
        </select>

        <label for="dates" placeholder="Enter Date">Date:</label>
        <input type="text" name="dates" id="dates" value=""/>
        <%--        <input
                        class="devui-input devui-form-control"
                        placeholder="y/MM/dd  -  y/MM/dd"
                        name="dp"
                        [(ngModel)]="dateRange"
                        (focus)="dateRangePicker.toggle()"
                        autocomplete="off"
                        dDateRangePicker
                        #dateRangePicker="dateRangePicker"
                        (selectedRangeChange)="getValue($event)"
                        [hideOnRangeSelected]="true"
                />--%>
        <input class="w3-button <%--w3-block --%>w3-section w3-orange w3-ripple w3-padding" type="submit" id="btnSearch"
               value="Go">
    </form>
</div>

<table class="display">
    <tr>
        <th>Ticket ID</th>
        <th>Date
            <button id="ascOrder">&#8593;</button>
            <button id="descOrder">&#8595;</button>
        </th>
        <th>Customer Name</th>
        <th>Mobile</th>
        <th>Price</th>
        <th>Device</th>
        <th>Device Issue</th>
        <th>Status</th>
        <th></th>
    </tr>
    <c:forEach var="ticket" items="${tickets}">

        <tr id="${ticket.id}" <%--onclick="view(this)"--%> >
            <td><a class="fakePointer btnView">${ticket.id}</a></td>
            <td> ${ticket.date}</td>
            <td> ${ticket.customerName}</td>
            <td> ${ticket.mobile}</td>
            <td> ${ticket.price}</td>
            <td> ${ticket.device}</td>
            <td> ${ticket.devicePassword}</td>
            <c:choose>
                <c:when test="${ticket.isDeleted == 1}">
                    <td class="status canceled">Canceled</td>
                </c:when>
                <c:when test="${ticket.isDeleted == 0}">
                    <c:choose>
                        <c:when test="${ticket.status == 0}">
                            <td class="status inProgress">In Progress</td>
                        </c:when>
                        <c:when test="${ticket.status == 1}">
                            <td class="status finished">Finished</td>
                        </c:when>
                        <c:when test="${ticket.status == 2}">
                            <td class="status paidPartial">Paid Partial</td>
                        </c:when>
                        <c:when test="${ticket.status == 3}">
                            <td class="status fixed">Repaired</td>
                        </c:when>
                        <c:when test="${ticket.status == 4}">
                            <td class="status sendAway">Send To Repair</td>
                        </c:when>

                    </c:choose>
                </c:when>
            </c:choose>

            <td>

                <c:choose>
                    <c:when test="${ticket.isDeleted != 1}">
                        <c:choose>
                            <c:when test="${ticket.status == 0}">
                                <input type="button" class="btnRepaired" value="Repaired">
                                <br>
                                <input type="button" class="btnSendAway" value="Send Away">
                                <br>
                                <input type="button" class="btnPrint" value="Print">
                            </c:when>
                            <c:when test="${ticket.status == 1 }">
                                <input type="button" class="btnPrint" value="Print">
                                <br>
                            </c:when>
                            <c:when test="${ticket.status == 2}">
                                <input type="button" class="btnCheckOut" value="Check Out">
                                <br>
                                <input type="button" class="btnPrint" value="Print">
                                <br>
                            </c:when>
                            <c:when test="${ticket.status == 3}">
                                <input type="button" class="btnCheckOut" value="Check Out">
                                <br>
                                <input type="button" class="btnPrint" value="Print">
                                <br>
                            </c:when>
                            <c:when test="${ticket.status == 4}">
                                <input type="button" class="btnRepaired" value="Repaired">
                                <br>
                                <input type="button" class="btnPrint" value="Print">
                                <br>
                            </c:when>
                        </c:choose>
                    </c:when>
                </c:choose>
            </td>
        </tr>
    </c:forEach>

</table>

<!-- update Modal -->
<div id="editModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">


        <div class="w3-container w3-card-4 w3-light-grey w3-text-orange w3-margin">
            <span id="editClose" class="close">&times;</span>
            <span id="editEnable" class="editEnable">Edit</span>
            <h2 class="w3-center w3-padding">Ticket ID: <span id="ticketId"></span></h2>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
                <div class="w3-rest">
                    <span>Customer Name:</span><input class="w3-input w3-border" type="text" id="customerName" disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fas fa-phone-alt"></i></div>
                <div class="w3-rest">
                    <span>Contact:</span><input class="w3-input w3-border" id="mobile" type="text" disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="material-icons" style="font-size:36px" ;>devices</i>
                </div>
                <div class="w3-rest">
                    <span>Device:</span><input class="w3-input w3-border" id="device" type="text" disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-tools"></i></div>
                <div class="w3-rest">
                    <span>Device Issue:</span> <input class="w3-input w3-border" id="deviceIssue" type="text" disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-expeditedssl"></i></div>
                <div class="w3-rest">
                    <span>Device Password:</span><input class="w3-input w3-border" id="devicePassword" type="text"
                                                        disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-dollar"></i></div>
                <div class="w3-rest">
                    <span>Price:</span><input class="w3-input w3-border" id="price" type="text" disabled>
                </div>
            </div>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="material-icons" style="font-size:36px" ;>payment</i>
                </div>
                <div class="w3-rest">
                    <span>Payment Method:</span><input class="w3-input w3-border" id="paymentMethod" type="text"
                                                       disabled>
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-file-text-o"></i></div>
                <div class="w3-rest">
                    <span id="flip" class="w3-button w3-block w3-orange fakePointer">Show/Hide Notes</span>
                </div>
            </div>
            <div id="notesPanel" class="w3-row w3-section">
                <input class="w3-input w3-border" id="updateNotes" type="text">
                <div class="w3-rest">
                    <button class="w3-button<%-- w3-block w3-section--%> w3-orange w3-ripple w3-padding"
                            style="float: right" id="addNotes">Add
                    </button>
                </div>
                <div class="w3-rest">
                    <Strong>Notes History:</Strong>
                    <p id="notes" class="w3-block w3-section w3-border w3-text-grey"
                       style="background-color: white"></p>
                </div>
            </div>


            <%--            <div class="w3-row w3-section">
                            <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-dollar"></i></div>
                            <div class="w3-rest">
                                <span>Price Exl GST:</span> <input class="w3-input w3-border" id="priceExludeGST" type="text"
                                                                   disabled>
                            </div>
                        </div>

                        <div class="w3-row w3-section">
                            <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
                            <div class="w3-rest">
                                <span>GST:</span> <input class="w3-input w3-border" id="GST" type="text" disabled>
                            </div>
                        </div>--%>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fas fa-user-edit"></i></div>
                <div class="w3-rest">
                    <span>CreatedBy:</span><input class="w3-input w3-border" id="createdBy" type="text" disabled>
                </div>
            </div>

            <button class="w3-button <%--w3-block --%>w3-section w3-orange w3-ripple w3-padding" style="float: right"
                    id="updateBtn">Update
            </button>
            <button class="w3-button <%--w3-block--%> w3-section w3-orange w3-ripple w3-padding"
                    style="float: right ;margin-right: 10px" id="deleteBtn">Delete
            </button>
            <button class="w3-button <%--w3-block--%> w3-section w3-orange w3-ripple w3-padding"
                    style="float: right ;margin-right: 10px" id="warrantyBtn">Warranty
            </button>

        </div>
    </div>

</div>


<!-- NewTicket Modal -->
<div id="newTicketModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">


        <div class="w3-container w3-card-4 w3-light-grey w3-text-orange w3-margin">
            <span id="newTicketClose" class="close">&times;</span>
            <h2 class="w3-center">New Ticket:</h2>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" type="text" id="new_customerName" placeholder="customerName">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fas fa-phone-alt"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="new_mobile" type="text" placeholder="contact number">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="material-icons" style="font-size:36px" ;>devices</i>
                </div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="new_device" type="text" placeholder="device">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-tools"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="new_deviceIssue" type="text" placeholder="deviceIssue">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-expeditedssl"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="new_devicePassword" type="text" placeholder="devicePassword">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-dollar"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="new_price" type="text" placeholder="price">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-file-text-o"></i></div>
                <div class="w3-rest">
                    <span>Notes:</span><input class="w3-input w3-border" id="new_notes" type="text">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-rest">
                    <span id="newTicketError" style = "color: #ff5722;"></span>
                </div>
            </div>


            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="newTicketBtn">Create
            </button>

        </div>
    </div>

</div>


<div id="productSaleModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">


        <div class="w3-container w3-card-4 w3-light-grey w3-text-orange w3-margin">
            <span id="productSaleClose" class="close">&times;</span>
            <h2 class="w3-center">Product Sale:</h2>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-shopping-bag"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" type="text" id="product" placeholder="Product">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-dollar"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" id="productPrice" type="text" placeholder="price">
                </div>
            </div>

            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="productBtn">Create</button>

        </div>
    </div>

</div>


<div id="checkoutModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">


        <div class="w3-container w3-card-4 w3-light-grey w3-text-orange w3-margin">
            <span id="checkoutClose" class="close">&times;</span>
            <h2 class="w3-center">Ticket ID: <span id="checkOutId"></span></h2>
            <h2 class="w3-center">Amount Due: <span id="amountDueSpan"></span></h2>
            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa fa-dollar"></i></div>
                <div class="w3-rest">
                    <input class="w3-input w3-border" type="text" id="checkoutPrice" placeholder="checkoutPrice">
                </div>
            </div>

            <div class="w3-row w3-section">
                <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-dollar"></i></div>
                <div class="w3-col" style="width:50px">
                    <input class="w3-input w3-border" id="eftpos" type="radio" name="paymentMethod" value="Eftpos">
                    <label for="eftpos">Eftpos</label>
                    <input class="w3-input w3-border" id="cash" type="radio" name="paymentMethod" value="Cash">
                    <label for="cash">Cash</label>

                </div>
            </div>

            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="checkoutBtn">Check Out
            </button>

        </div>
    </div>

</div>

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


<div id="printModal" class="modal">

    <!-- Modal content -->
    <div class="modal-content">

        <div class="w3-container w3-card-4 w3-light-grey w3-text-orange w3-margin">
            <span id="printClose" class="close">&times;</span>
            <h2 class="w3-center">Ticket ID: <span id="printTicketID"></span></h2>

            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="printLabel">Label</button>
            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="printInvoice">GST Invoice
            </button>
            <button class="w3-button w3-block w3-section w3-orange w3-ripple w3-padding" id="printCheckInForm">Check In
                Form
            </button>
        </div>
    </div>

</div>

<div class="switchInvo">

    <button class="w3-button <%--w3-block w3-section--%> w3-orange w3-ripple w3-padding" id="showInvoice">Invoice
    </button>
    <button class="w3-button <%--w3-block w3-section--%> w3-orange w3-ripple w3-padding" id="showTicket">Ticket</button>

</div>

<div class="paginationDiv">
    <div class="pagination">
        <tr>
            <td><a href="${displayMethod}?name=${name}&store=${store}&pageNum=1">First Page</a></td>

            <td th:if="${pageInfo.hasPreviousPage}"><a
                    href="${displayMethod}?name=${name}&store=${store}&pageNum=${pageInfo.pageNum-1}">&laquo;</a>
            </td>
            <td><a>${pageInfo.pageNum}/${pageInfo.pages}</a></td>
            <td th:if="${pageInfo.hasNextPage}"><a
                    href="${displayMethod}?&name=${name}&store=${store}&pageNum=${pageInfo.pageNum+1}">&raquo;</a>
            </td>
            <td><a href="${displayMethod}?name=${name}&store=${store}&pageNum=${pageInfo.pages}">Last Page</a></td>
        </tr>

    </div>
</div>

</body>

<script>

    /*Display hidden column by role*/
    $(document).ready(function () {
        var role = '<c:out value="${role}"/>';
        if (role === "admin") {

            $("#manageUser").prop("hidden", false);
        }

        var params = {};
        params.name = $("#username").html();

        $.ajax({
            type: "POST",
            url: "/checkStore",
            data: params,
            dataType: "json",
            success: function (data) {
                for (i of data.stores) {
                    $('#storelist').append($('<option>', {
                        value: i,
                        text: i
                    }));
                }
            },
            error: function (err) {
                alert("Error!!! Cannot get Store List ! Please Try again or contact your technician");
            }
        });
    });

    /*Edit Modal Operation*/
    var editModal = document.getElementById("editModal");
    var editSpan = document.getElementById("editClose");


    editSpan.onclick = function () {
        $("#customerName").prop("disabled", true);
        $("#mobile").prop("disabled", true);
        $("#device").prop("disabled", true);
        $("#deviceIssue").prop("disabled", true);
        $("#devicePassword").prop("disabled", true);
        $("#price").prop("disabled", true);
        $("#notes").prop("disabled", true);
        $("#warrantyBtn").css('display', 'none');
        editModal.style.display = "none";
        location.reload();
    };


    $('.btnView').click(function () {

        getTicket($(this).parent().parent().attr("id"));

    });

    function getTicket(x) {

        var params = {};
        params.id = x;
        $.ajax({
            type: "POST",
            url: "/getTicket",
            data: params,
            dataType: "json",
            success: function (data) {
                $("#ticketId").text(data.id);
                $("#customerName").val(data.customerName);
                $("#mobile").val(data.mobile);
                $("#device").val(data.device);
                $("#deviceIssue").val(data.deviceIssue);
                $("#devicePassword").val(data.devicePassword);
                $("#price").val(data.price);
                $("#priceExludeGST").val(data.priceExludeGST);
                $("#GST").val(data.GST);
                $("#createdBy").val(data.createdBy);
                $("#paymentMethod").val(data.paymentMethod);
                $("#notes").html(data.notes);


                if (data.status == "1" && data.customerName != "Walkin Customer") {
                    $("#warrantyBtn").css('display', 'block');
                }

                if (data.isDeleted == "1") {
                    $("#updateBtn").css('display', 'none');
                    $("#deleteBtn").css('display', 'none');
                    $("#editEnable").css('display', 'none');
                }

            },
            error: function (err) {
                alert("Error!!! Cannot Edit Ticket ! Please Try again or contact your technician");
            }
        });

        editModal.style.display = "block";

    }

    /*Update Button Onlick Check*/
    $('#updateBtn').click(function () {

        if ($("#customerName").val() == "Walkin Customer") {
            if (!$("#price").val()) {
                alert("Please Enter Price");
                return false
            }
            if (!$.isNumeric($("#price").val())) {
                alert("Please Enter Valid Price");
                return false
            }
        } else {
            if (!$("#customerName").val()) {
                alert("Please Enter Customer Name");
                return false;
            }

            if (!$("#mobile").val()) {
                alert("Please Enter Customer's mobile");

                return false
            }
            if (!$("#device").val()) {
                alert("Please Enter Device Model");
                return false
            }
            if (!$("#deviceIssue").val()) {
                alert("Please Enter Device Problem");
                return false
            }
            if (!$("#price").val()) {
                alert("Please Enter Price");
                return false
            }
            if (!$.isNumeric($("#price").val())) {
                alert("Please Enter Valid Price");
                return false
            }

        }
        updateTicket();
    });


    /*Update Ticket Ajax*/
    function updateTicket() {

        var params = {};
        params.username = $('#username').text();
        params.id = $("#ticketId").text();
        params.customerName = $("#customerName").val();
        params.mobile = $("#mobile").val();
        params.device = $("#device").val();
        params.deviceIssue = $("#deviceIssue").val();
        params.devicePassword = $("#devicePassword").val();
        params.price = $("#price").val();
        /*        params.notes = $("#notes").val();*/

        $.ajax({
            type: "POST",
            url: "/updateTicket",
            data: params,
            dataType: "json",
            success: function (data) {
                getTicket($("#ticketId").text());
                $("#customerName").prop("disabled", true);
                $("#mobile").prop("disabled", true);
                $("#price").prop("disabled", true);
                $("#device").prop("disabled", true);
                $("#deviceIssue").prop("disabled", true);
                $("#devicePassword").prop("disabled", true);
            },
            error: function (err) {
                alert("Error!!! Cannot Edit Ticket ! Please Try again or contact your technician");
            }
        });
    }

    $('#addNotes').click(function () {

        var params = {};
        params.id = $("#ticketId").text();
        params.notes = $("#updateNotes").val();
        params.user = $('#username').text();
        $.ajax({
            type: "POST",
            url: "/updateNotes",
            data: params,
            dataType: "json",
            success: function (data) {
                getTicket($("#ticketId").text());
                $("#customerName").prop("disabled", true);
                $("#mobile").prop("disabled", true);
                $("#price").prop("disabled", true);
                $("#device").prop("disabled", true);
                $("#deviceIssue").prop("disabled", true);
                $("#devicePassword").prop("disabled", true);
            },
            error: function (err) {
                alert("Error!!! Please Try again or contact your technician");
            }
        });

    });


    $('#deleteBtn').click(function () {
        var answer = confirm("Warning!!! Please make sure that you want to delete this ticket")
        if (!answer) {
            return false;
        } else {
            var params = {};
            params.username = $("#username").html();
            params.id = $("#ticketId").text();

            $.ajax({
                type: "POST",
                url: "/deleteTicket",
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

    $('#warrantyBtn').click(function () {
        var answer = confirm("Warning!!! Please make sure that you want to Create Warranty Ticket")
        if (!answer) {
            return false;
        } else {
            var params = {};
            params.username = $("#username").html();
            params.id = $("#ticketId").text();
            params.store = $('#storename').html();

            $.ajax({
                type: "POST",
                url: "/warrantyTicket",
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



    /*New Ticket Modal Operation*/
    var newTicketModal = document.getElementById("newTicketModal");
    var newTicketSpan = document.getElementById("newTicketClose");
    newTicketSpan.onclick = function () {
        newTicketModal.style.display = "none";
    };

    $('#createNew').click(function () {

        newTicketModal.style.display = "block";

    });
    /*Check New Ticket Input */
    $('#new_customerName').blur(function(){
        if (!$("#new_customerName").val()) {
            $('#new_customerName').focus();
            $('#newTicketError').text("Please Enter Customer Name");
        }
        else{
            $('#newTicketError').text("");
        }
    });


    $('#new_mobile').blur(function(){
        /*New Zealand Phone Number Check*/
        var pattern = /^((03|04|06|07|09)\d{7})|((021|022|025|027|028|029)\d{6,8})|((0508|0800|0900)\d{5,8})$/;
        if (!pattern.test($("#new_mobile").val())) {
            $('#new_mobile').focus();
            $('#newTicketError').text("Please check your mobile number format!!");
        }

        else{
            $('#newTicketError').text("");
        }
    });

    $('#new_device').blur(function(){
        if (!$("#new_device").val()) {
            $('#new_device').focus();
            $('#newTicketError').text("Please Enter Device Name");
        }
        else{
            $('#newTicketError').text("");
        }
    });

    $('#new_deviceIssue').blur(function(){
        if (!$("#new_deviceIssue").val()) {
            $('#new_deviceIssue').focus();
            $('#newTicketError').text("Please Enter Device Issue");
        }
        else{
            $('#newTicketError').text("");
        }
    });

    $('#new_price').blur(function(){
        if (!$("#new_price").val() || !$.isNumeric($("#new_price").val())){
            $('#new_price').focus();
            $('#newTicketError').text("Please Enter Valid Price");
        }
        else{
            $('#newTicketError').text("");
        }
    });

    /*Submit the New Ticket*/
    $('#newTicketBtn').click(function () {

        createTicket();

    });
    /*fetch url parameter*/
    var getUrlParameter = function getUrlParameter(sParam) {
        var sPageURL = window.location.search.substring(1),
            sURLVariables = sPageURL.split('&'),
            sParameterName,
            i;

        for (i = 0; i < sURLVariables.length; i++) {
            sParameterName = sURLVariables[i].split('=');

            if (sParameterName[0] === sParam) {
                return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
            }
        }
    };
    function createTicket() {
        var params = {};
        params.customerName = $("#new_customerName").val();
        params.mobile = $("#new_mobile").val();
        params.device = $("#new_device").val();
        params.deviceIssue = $("#new_deviceIssue").val();
        params.devicePassword = $("#new_devicePassword").val();
        params.price = $("#new_price").val();
        params.creator = getUrlParameter("name");
        params.store = getUrlParameter("store");
        params.notes = $("#new_notes").val();

        $.ajax({
            type: "POST",
            url: "/createTicket",
            data: params,
            dataType: "json",
            success: function (data) {
                /*                alert("Create Success");*/
                newTicketModal.style.display = "none";
                location.reload();
            },
            error: function (err) {
                alert("Create Ticket Failed, Please contact your technician for reference");
            }

        });

    };


    /*Product Sale Modal Operation*/
    var productSaleModal = document.getElementById("productSaleModal");
    var productSaleClose = document.getElementById("productSaleClose");

    productSaleClose.onclick = function () {
        productSaleModal.style.display = "none";
    };

    $('#productSale').click(function () {

        productSaleModal.style.display = "block";

    });

    $('#productBtn').click(function () {

        if (!$("#product").val()) {
            alert("Please Enter Product Name");
            return false;
        }
        if (!$("#productPrice").val()) {
            alert("Please Enter Product Price");

            return false
        }
        if (!$.isNumeric($("#productPrice").val())) {
            alert("Please Enter Valid Price");
            return false
        }
        productSale();
    });


    function productSale() {
        var params = {};
        params.product = $("#product").val();
        params.price = $("#productPrice").val();
        params.creator = getUrlParameter("name");
        params.store = getUrlParameter("store");

        $.ajax({
            type: "POST",
            url: "/productSale",
            data: params,
            dataType: "json",
            success: function (data) {
                /*                alert("Product Sale Success");*/
                productSaleModal.style.display = "none";
                location.reload();
            },
            error: function (err) {
                alert("new Product Sale Failed, Please contact your technician for reference");
            }

        });

    };

    /*Edit Modal Operation*/
    var checkoutModal = document.getElementById("checkoutModal");
    var checkoutSpan = document.getElementById("checkoutClose");

    checkoutSpan.onclick = function () {
        checkoutModal.style.display = "none";
    };

    $('.btnCheckOut').click(function () {
        var params = {};
        params.id = $(this).parent().parent().attr("id");

        $.ajax({
            type: "POST",
            url: "/getTicket",
            data: params,
            dataType: "json",
            success: function (data) {
                $("#amountDueSpan").text(data.amountDue);
                $("#checkOutId").text(data.id);


            },
            error: function (err) {
                alert("Error!!! Please Try again or contact your technician");
            }
        });

        checkoutModal.style.display = "block";

    });

    $('#checkoutBtn').click(function () {

        if (!$("#checkoutPrice").val()) {
            alert("Please Enter Payment Price");
            return false;
        }

        if (!$.isNumeric($("#checkoutPrice").val())) {
            alert("Please Enter Valid Check Out Price");
            return false
        }

        if (!$("input[name='paymentMethod']:checked").val()) {
            alert("Please Select Payment Method");
            return false;
        }
        checkOut();

    });


    function checkOut() {
        var params = {};
        params.id = $("#checkOutId").text();
        params.username = $('#username').text();
        params.checkoutPrice = $("#checkoutPrice").val();
        params.paymentMethod = $("input[name='paymentMethod']:checked").val();


        $.ajax({
            type: "POST",
            url: "/checkOut",
            data: params,
            dataType: "json",
            success: function (data) {
                /*                alert("Product Sale Success");*/
                productSaleModal.style.display = "none";
                location.reload();
            },
            error: function (err) {
                alert("new Product Sale Failed, Please contact your technician for reference");
            }

        });

    };


    var printModal = document.getElementById("printModal");
    var printSpan = document.getElementById("printClose");

    printSpan.onclick = function () {
        printModal.style.display = "none";
    };

    $('.btnPrint').click(function () {

        $('#printTicketID').text($(this).parent().parent().attr("id"));
        printModal.style.display = "block";
    });


    $('#printLabel').click(function () {
        var params = {};
        params.id = $('#printTicketID').text();

        $.ajax({
            type: "POST",
            url: "/getTicket",
            data: params,
            dataType: "json",
            success: function (data) {
                var doc = new jsPDF('l', 'mm', [29, 90]);
                doc.setFontSize(15);
                doc.setFont("helvetica");
                doc.setFontType("bold");
                doc.text(2, 5, "Name: " + data.customerName);
                doc.text(2, 10, "Device: " + data.device)
                doc.setFontSize(8);
                doc.setFontType("normal");
                doc.text(2, 15, "Contact: " + data.mobile);
                doc.text(2, 20, "Issue: " + data.deviceIssue);
                doc.text(2, 25, "Password: " + data.devicePassword);

                window.open(doc.output('bloburl'), '_blank');
                /*              $("#printMobile").text(data.mobile);
                                $("#printDevice").text(data.device);
                                $("#printDeviceIssue").text(data.deviceIssue);
                                $("#printDevicePassword").text(data.devicePassword);
                                $("#printPrice").text(data.price);*/
            },
            error: function (err) {
                alert("Error!!! Please Try again or contact your technician");
            }
        });


    });

    $('#printInvoice').click(function () {
        var id = $('#printTicketID').text();
        window.open("/showInvoice?id=" + id);

    });

    $('#printCheckInForm').click(function () {
        var id = $('#printTicketID').text();
        window.open("/showCheckInForm?id=" + id);
    });


    /*Change Store Modal*/
    var storeSelectionModal = document.getElementById("storeSelectionModal");
    var storeSelectionClose = document.getElementById("storeSelectionClose");

    storeSelectionClose.onclick = function () {
        storeSelectionModal.style.display = "none";
    };

    $('#changeStore').click(function () {

        storeSelectionModal.style.display = "block";

    });


    $('#selectBtn').click(function () {
        var store = $('#storelist').val();
        var username = $("#username").html();
        window.location.href = "/showTickets?name=" + username + "&store=" + store;
    });


    $('#ascOrder').click(function () {
        var store = $('#storename').html();
        var username = $('#username').text();
        window.location.href = "/showTickets?name=" + username + "&store=" + store + "&order=ASC";
    });


    $('#descOrder').click(function () {
        var store = $('#storename').html();
        var username = $('#username').text();
        window.location.href = "/showTickets?name=" + username + "&store=" + store + "&order=DESC";
    });


    $('.btnRepaired').click(function () {
        var answer = confirm("Warning!!! Please make sure that the job has been done !!!!!!!!!!")
        if (!answer) {
            return false;
        } else {
            /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
            var params = {};
            params.id = $(this).parent().parent().attr("id");
            params.status = "3";

            $.ajax({
                type: "POST",
                url: "/updateStatus",
                data: params,
                dataType: "json",
                success: function (data) {
                    location.reload();
                },
                error: function (err) {
                    alert("Error!!! Cannot Edit Ticket ! Please Try again or contact your technician");
                }
            });
        }
    });

    $('.btnSendAway').click(function () {
        var answer = confirm("Warning!!! Please make sure that the job need to be sent away!!!!!!!!!")
        if (!answer) {
            return false;
        } else {
            /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
            var params = {};
            params.id = $(this).parent().parent().attr("id");
            params.status = "4";

            $.ajax({
                type: "POST",
                url: "/updateStatus",
                data: params,
                dataType: "json",
                success: function (data) {
                    location.reload();
                },
                error: function (err) {
                    alert("Error!!! Cannot Edit Ticket ! Please Try again or contact your technician");
                }
            });
        }
    });

    $('.editEnable').click(function () {

        if ($("#customerName").val() != "Walkin Customer") {
            $("#customerName").prop("disabled", false);
            $("#mobile").prop("disabled", false);
            $("#price").prop("disabled", false);
            $("#device").prop("disabled", false);
            $("#deviceIssue").prop("disabled", false);
            $("#devicePassword").prop("disabled", false);
            $("#notes").prop("disabled", false);
        } else {
            $("#price").prop("disabled", false);
            $("#device").prop("disabled", false);
        }

    });

    $("#flip").click(function () {
        $("#notesPanel").slideToggle("slow");
    });

    $("#searchBarSlideShow").click(function () {
        $("#searchBar").slideToggle("slow");
    });
    $('#showTicket').click(function () {
        var store = $('#storename').html();
        var username = $('#username').text();
        window.location.href = "/showTickets?name=" + username + "&store=" + store + "&order=DESC";
    });

    $('#showInvoice').click(function () {
        var store = $('#storename').html();
        var username = $('#username').text();
        window.location.href = "/showTickets?name=" + username + "&store=" + store + "&order=DESC&ifInvo='yes'";
    });

    /*dataPicker*/
    $(function () {
        $('input[name="dates"]').daterangepicker({
            autoUpdateInput: false,
            locale: {
                cancelLabel: 'Clear'
            }
        }, function (start, end, label) {
            /*            var store = $('#storename').html();
                        var username = $('#username').text();
                        var startDate = start.format('YYYY-MM-DD');
                        var endDate = end.format('YYYY-MM-DD');*/
        });
    });


    $('input[name="dates"]').on('apply.daterangepicker', function (ev, picker) {
        $(this).val(picker.startDate.format('MM/DD/YYYY') + ' - ' + picker.endDate.format('MM/DD/YYYY'));
    });

    $('input[name="dates"]').on('cancel.daterangepicker', function (ev, picker) {
        $(this).val('');
    });


</script>
</html>
