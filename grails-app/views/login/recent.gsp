<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 25/6/15
  Time: 7:08 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Link Sharing: FORGET PASSWORD</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <style>
    #right{
        width:450px;
        height:450px;
        float:left;
        padding:20px;
    }
    #header{
        height:90px;

        padding:5px;
        background-color: #EAFFF7;
    }
    </style>
</head>

<body>
<div id="header">

    <h1 class="text-error" style="color:#D42727"align="center">Link Sharing Application</h1>
</div>
<div>
    <table class="table">
        <tr>
            <th>Forget Password</th>
        </tr>
        <g:form controller="login" action="invite">
        <tr>
            <td>

                    <label for="email">Email </label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                    <g:textField name="email"/><br>
                    <g:submitButton name="Send Mail"/>
                </td>
            </tr>

        </g:form>
    </table>
    </div>
<g:if test="${email==false}">
    <g:javascript>alert("Please Check Email")</g:javascript>
    <%email=true%>
</g:if>
</body>
</html>