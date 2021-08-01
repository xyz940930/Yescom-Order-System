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
    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <script src="https://kit.fontawesome.com/249020923f.js"></script>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <title>Invoice</title>
    <style type="text/css">
        #page-wrap {
            width: 700px;
            margin: 0 auto;
        }
        #page-wrap li{
            font-size: 10px;
        }
        .center-justified {
            text-align: justify;
            margin: 0 auto;
            width: 18em;
            font-size: 10px;
        }
        table.outline-table {
            border: 1px solid;
            border-spacing: 0;
        }
        tr.border-bottom td, td.border-bottom {
            border-bottom: 1px solid;
        }
        tr.border-top td, td.border-top {
            border-top: 1px solid;
        }
        tr.border-right td, td.border-right {
            border-right: 1px solid;
        }
        tr.border-right td:last-child {
            border-right: 0px;
        }
        tr.border-left td, td.broder-left {
            border-left: 1px solid;
        }
        tr.center td, td.center {
            text-align: center;
            vertical-align: text-top;
        }
        td.pad-left {
            padding-left: 5px;
        }
        tr.right-center td, td.right-center {
            text-align: right;
            padding-right: 50px;
        }
        tr.right td, td.right {
            text-align: right;
        }
        .grey {
            background-color: #ddd;
        }

    </style>
</head>
<body>
<div id="page-wrap">
    <table width="100%">
        <tbody>
        <tr>
            <td width="20%">
                <img src="images/logo.png" width="100"> <!-- your logo here -->
            </td>
            <td width="30%">
                <div class="center-justified">
                    Mobile Muster Panmure <br>
                    43 Queens Road<br>
                    Auckland, Auckland<br>
                    1072, New Zealand<br>
                    Tel: 09-527 2954<br>
                    Email: support@mobilemuster.co.nz<br>
                    Website: http://www.mobilemuster.co.nz<br>
                    <strong>GST Number: 103481473</strong><br>
                </div>
            </td>
            <td width="40%" style="float: right; font-size: 17px">
                <h2 style="font-size: 20px"><strong>Tax Invoice</strong></h2><br>
                <span>Date:</span><span id="Date"></span><br>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        </tbody>
    </table>
    <p>&nbsp;</p>
    <table width="100%" class="outline-table">
        <tbody>
        <tr class="border-bottom border-right grey">
            <td colspan="3"><strong>Invoice For</strong></td>
        </tr>
        <tr class="border-bottom border-right left">
            <td width="35%"><strong>Name</strong></td>
            <td width="30%"><strong>Ticket Number</strong></td>
            <td width="35%"><strong>Mobile</strong></td>
        </tr>
        <tr class="border-right">
            <td width="35%" id="customerName"> </td>
            <td width="30%" id="ticketId"> </td>
            <td width="35%" id="mobile"> </td>
        </tr>
        </tbody>
    </table>
    <p>&nbsp;</p>

    <table width="100%" class="outline-table">
        <tbody>
        <tr class="border-bottom border-right grey">
            <td colspan="3" ><strong>Summary</strong></td>
        </tr>
        <tr class="border-bottom border-right border-left center">
            <td width="35%"><strong>Device</strong></td>
            <td width="35%"><strong>Service</strong></td>
            <td width="30%"><strong>Price</strong></td>
        </tr>

        <tr class="border-right border-bottom border-left">
            <td height="100px" style="text-align: center" id = "device"></td>
            <td height="100px" style="text-align: center" id = "deviceIssue"></td>
            <td height="100px" style="text-align: right;" class = "price "></td>
        </tr>

        <tr class="center">
            <td></td>
            <td style="text-align: right ;">Subtotal</td>
            <td style="border-left:1px solid; text-align: right" id="priceExludeGST"></td>
        </tr>

        <tr class="center" >
            <td></td>
            <td style="text-align: right">Sales Tax</td>
            <td style="border-left:1px solid;text-align: right" id="GST"></td>
        </tr>
        <tr class="center" >
            <td></td>
            <td style="text-align: right">Total</td>
            <td style="text-align: right ; border-left:1px solid" class="price"></td>
        </tr>
        </tbody>
    </table>

    <p>&nbsp;</p>

    <p>&nbsp;</p>


    <table>
        <tbody>
        <tr width="200%">
            <Strong>Terms & Conditions</Strong>
            <li type="1"> A pre repair check will be performed on your device.</li>
            <li type="1">  We will return your device in the same condition it was checked in if the phone is not able to fix.</li>
            <li type="1">  Our warranty only covers the part we repair or replace. </li>
            <li type="1">  I understand that any repair may void my manufacture warranty. </li>
            <li type="1">  I understand that if my device is not powering on, or has any any other defect that does not allow Mobile Muster to pre test it, it will be marked as "no power" and no warranty will be provided except on the part we replace.</li>
            <li type="1">  I agree that Mobile Muster will not be liable for any lost data and that it is my responsibility to back up my device. </li>
            <li type="1">  I further agree that Mobile Muster has the right to dispose or resell my device if not picked up within 30 days of completion. </li>
            <li type="1"> I understand that my phone will not be water resistant or water proof after repairs</li>
            </td>
        </tr>
        </tbody>
    </table>
</div>
</body>







<script>


    $(document).ready(function () {
        var id = '<c:out value="${ticketID}"/>';
        var params = {};
        params.id = id;

        $.ajax({
            type: "POST",
            url: "/getTicket",
            data: params,
            dataType: "json",
            success: function (data) {
                $("#ticketId").text(data.id);
                $("#customerName").text(data.customerName);
                $("#mobile").text(data.mobile);
                $("#device").text(data.device);
                $("#deviceIssue").text(data.deviceIssue);
                $(".price").text("$"+data.price);
                $("#priceExludeGST").text("$"+data.priceExludeGST);
                $("#GST").text("$"+data.GST);
                $("#paymentMethod").text(data.paymentMethod);
                $("#Date").text(data.date);

                window.print();
            },
            error: function (err) {
                alert("Error!!! Cannot Edit Ticket ! Please Try again or contact your technician");
            }
        });



    });

</script>






</html>
