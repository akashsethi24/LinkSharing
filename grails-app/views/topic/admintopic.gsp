<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 11/7/15
  Time: 11:30 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Link Sharing: TOPIC LIST</title>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <style type="text/css">
#header {
    height: 130px;

    padding: 5px;
    background-color: #EAFFF7;
}
</style>
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
                User
                <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <li><g:link controller="documentResource" action="adminsort" id="All">All User</g:link></li>
                <li><g:link controller="documentResource" action="adminsort" id="Active">Active</g:link></li>
                <li><g:link controller="documentResource" action="adminsort" id="Inactive">Inactive</g:link></li>
            </ul>
        </div>

        <div class="btn-group">
            <a class="btn btn-danger dropdown-toggle" data-toggle="dropdown" href="#">
                ${user}
                <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <li> <g:link controller="user" action="index">Profile</g:link></li>
                <g:if test="${user.admin==true}">
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
<table class="table">
    <tr>
    <th>Topic List For ADMIN</th>
    </tr>
    <g:each in="${topic}" var="list">
        <tr>
            <td>${list.name}</td>
            <td>${list.user}</td>
            <td>${list.dateCreated}</td>
        </tr>
    </g:each>
    <g:paginate total="${total}" max="20" params="[q:params.q]"/>
</table>

<body>

</body>
</html>