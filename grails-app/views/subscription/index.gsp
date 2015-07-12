<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 26/6/15
  Time: 8:49 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
</head>

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
            ${users}
            <span class="caret"></span>
        </a>
        <ul class="dropdown-menu">
            <li> <g:link controller="user" action="index">Profile</g:link></li>
            <g:if test="${users.admin==true}">
                <li><g:link controller="user" action="adminuser">Users</g:link></li>
            </g:if>
            <li><g:link controller="user" action="edituser">Edit Profile</g:link></li>
            <li> <g:link controller="dashboard" action="index">DashBoard</g:link></li>
            <li><g:link controller="login" action="index">LogOut</g:link></li>
            <!-- dropdown menu links -->
        </ul>
    </div>
</div>
</div>

</body>
</html>