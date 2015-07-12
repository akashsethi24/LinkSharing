<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 25/6/15
  Time: 10:59 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <style type="text/css">

    #left {
        height: 450px;
        width: 600px;
        float:right;
        padding: 5px;
    }

    #right {
        width: 600px;
        height: 450px;
        float: left;
        padding: 5px;
    }

    #bottom {
        clear: both;
        height: 60px;
        text-align: center;
        padding: 5px;
    }

    #header {
        height: 130px;

        padding: 5px;
        background-color: #EAFFF7;
    }
    </style>
</head>

<body>
<div id="header">

    <h1 class="text-error" style="color:#D42727" align="center">Link Sharing Application</h1>
    <g:form  class="navbar-form navbar-left" role="search" controller="documentResource" action="search">
        <g:textField name="search" class="form-control" placeholder="Search"/>
        <g:submitButton name="Search" type="submit" class="btn btn-default"/>
    </g:form>&emsp;&emsp;&emsp;&emsp;&emsp;

    <div align="right">
        <g:link controller="resource" action="invites"><g:img dir="images" file="Email-icon.png" width="25px" height="25px"></g:img> </g:link>&emsp;
        <g:link controller="topic" action="createtopic"><g:img dir="images" file="resource-icon.png" width="25px" height="25px"></g:img> </g:link>&emsp;
        <g:link controller="resource" action="index"><g:img dir="images" file="3.jpg" width="25px" height="25px"></g:img> </g:link>&emsp;
        <div class="btn-group">
            <a class="btn btn-danger dropdown-toggle" data-toggle="dropdown" href="#">
                ${used}
                <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <li> <g:link controller="user" action="index">Profile</g:link></li>
                <g:if test="${used.admin==true}">
                    <li><g:link controller="user" action="adminuser">Users</g:link></li>
                    <li><g:link controller="topic" action="admintopic">Topic</g:link> </li>
                </g:if>
                <li><g:link controller="user" action="edituser">Edit Profile</g:link></li>
                <li> <g:link controller="dashboard" action="index">DashBoard</g:link></li>
                <li><g:link controller="login" action="index">LogOut</g:link></li>
                <!-- dropdown menu links -->
            </ul>
        </div>
    </div>
</div>

<div id="right">
    <table class="table table-condensed">
        <g:form controller="user" action="edituser">
        <tr>
            <th>Photo</th>
            <th>Name</th>
            <th>Subscription</th>
            <th>Topics</th>
        </tr>
        <tr>

            <td><gt:pic uid="${used.id}"/> </td>
            <td>${used.toString()}</td>
            <td>${sc}</td>
            <td>${tc}</td>
        </tr>
        </g:form>
    </table>
</div>
<div id="left">
    <table class="table">
        <tr>
            <th>Personal Information</th>
        </tr>

            <g:uploadForm controller="user" action="changedata">
                <tr>
            <td>
                <label for="fName">First Name</label>
                <g:textField name="fName" value="${used.firstName}"/>
            </td>
                </tr>
                <tr>
               <td>
                   <label for="lName">Last Name</label>
                   <g:textField name="lName" value="${used.lastName}"/>
               </td>
                </tr>
                <tr>
                <td>
                    <label for="username">Username</label>
                    <g:textField name="username" value="${used.username}"/>
                </td>
                </tr>
                <tr>
                <td>
                    <label for="photo">Photo</label>
                    <g:field type="file" name="photo" value=""/><br>
                <g:submitButton name="Change" class="btn btn-danger"/>
                </td>
            </g:uploadForm>
        </tr>
    </table>
    <table class="table">
        <tr>
            <th>Change Password</th>
        </tr>
        <g:form controller="user" action="Changepass">
        <tr>
            <td>
                <label for="password">Password</label>&emsp;&emsp;&emsp;&emsp;
                <g:passwordField name="password"/>
            </td>
        </tr>
        <tr>
            <td>
                <label for="confirm_password">Confirm Password</label>
                <g:passwordField name="confirm_password"/>
                <br>
                <g:submitButton name="Update" class="btn btn-danger"/>
            </td>
        </tr>
        </g:form>
    </table>
</div>
</body>
</html>