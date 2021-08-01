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
    <style type="text/css">
        #page-wrap {
            width: 700px;
            margin: 0 auto;
            font-size: 15px;
        }

        /*	#page-wrap {
                font-size: 5px;
            }*/
        .center-justified {
            text-align: justify;
            margin: 0 auto;
            width: 18em;
            font-size: 10px;
        }

        .grey {
            background-color: #ddd;
        }

        li {
            font-size: 15px;
        }

        .signature {
            border: 0;
            border-bottom: 1px solid #000;
        }

        .details {
            font-family: Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            width: 100%;
            font-size: 15px;
        }

        .details td, #customers th {
            border: 1px solid black;
            padding: 5px;
        }

    </style>
</head>
<body>
<div id="page-wrap">
    <table>
        <tbody>
        <tr>
            <td width="20%">
                <img src="images/logo.png" width="100"> <!-- your logo here -->
            </td>
            <td width="30%">
                <div class="center-justified">
                    Mobile Muster Panmure <br>
                    43 Queens Road<br>
                    Panmure, Auckland<br>
                    Tel: 09-527 2954<br>
                    Email: support@mobilemuster.co.nz<br>
                    Website: http://www.mobilemuster.co.nz<br>
                </div>
            </td>
            <td width="40%" style="float: right">
                <h2 style="font-size: 17px"><strong>Check In Form</strong></h2><br>
                <span>Date:</span><span id="Date"></span><br>
            </td>
        </tr>
        <tr>
            <td colspan="2">&nbsp;</td>
        </tr>
        </tbody>
    </table>
    <table class="details"> <!--class="outline-table"-->
        <tbody>
        <tr class="grey">
            <td colspan="3"><strong>Customer Details:</strong></td>
        </tr>
        <tr>
            <td width="30%"><strong>Name:</strong></td>
            <td width="30%" id="customerName"></td>
        </tr>
        <tr>
            <td width="50%"><strong>Contact:</strong></td>
            <td width="50%" id="mobile"></td>
        </tr>
        <tr>
            <td width="50%"><strong>Device:</strong></td>
            <td width="50%" id="device"></td>
        </tr>
        <tr>
            <td width="50%"><strong>Fault Description:</strong></td>
            <td width="50%" id="deviceIssue"></td>
        </tr>
        <tr>
            <td width="50%"><strong>Notes:</strong></td>
            <td width="50%" id="notes"></td>
        </tr>
        <tr>
            <td width="50%"><strong>Price:</strong></td>
            <td width="50%" id="price"></td>
        </tr>
        </tbody>
    </table>
    <br/>
    <strong> Service Fee: </strong>
    <br/>
    Mobile Muster provides a free quick assessment for the customer on spot, but in case of following, there is
    minimum inspection fee ($25) will be applied.
    <ul>
        <li type="1"> When if a detail diagnosis or specific repair report is involved</li>
        <li type="1"> If we spent more than 10 minutes on the service in our labour time.</li>
    </ul>
    <strong> Risk: </strong>
    <br/>
    <ul>
        <li type="1"> Customer should ensure that all data is backed up prior to any servicing or repair. Mobile Muster
            is not responsible for any loss of data or loss of revenue or profits or consequential damages, however
            caused, before, during or after service.
        </li>
        <li type="1"> Any property left with Mobile Muster unclaimed for 30 days will be disposed. At this time Mobile
            Muster shall have no liability to the client or any third party.
        </li>
        <li type="1"> Mobile Muster liability of any kind with respect to services, including any negligence on its
            part, shall be limited to the contract price for the services.
        </li>
        <li type="1"> Customer understands that the inherent risk or injury/ damage prior to any servicing or repair
            might cause the device not functioning properly after servicing and Mobile Muster will not be liable for
            such risks.
        </li>
    </ul>

    <strong> Deposit </strong>

    <li>Whenever the repair having a high estimated cost ($100 or more), a minimum of $50 deposit is required prior to
        the repair
    </li>
    <br/>
    <strong> Turnaround time </strong>

    <li>All repairs may take up to four weeks depending on the workload of Mobile muster or availability of parts.</li>
    <br/>
    <strong> Warranty </strong>
    <br/>
    <ul>
        <li type="1"> We provide 3 months warranty on most of our repair jobs except Liquid damaged repairs due to
            its high uncertainty and instability for the post-repair performances.
        </li>
        <li type="1"> Our Warranty only covers the parts involved in our previous repairs, any faults or issues
            caused by irrelevant parties will be quoted separately.
        </li>
        <li type="1"> Our warranty does not cover any Physical or liquid damage or wear and tear caused by any party
            but Mobile Muster.
        </li>
    </ul>

    <br/>
    <br/>
    <div style="float: right">
        <span>Signature:</span><input type="text" class="signature"/>
        <span>Date:</span><input type="text" class="signature"/>
    </div>
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
/*                $("#ticketId").text(data.id);*/
                $("#customerName").text(data.customerName);
                $("#mobile").text(data.mobile);
                $("#device").text(data.device);
                $("#deviceIssue").text(data.deviceIssue);
                $("#price").text("$"+data.price);
                $("#notes").text(data.notes);
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