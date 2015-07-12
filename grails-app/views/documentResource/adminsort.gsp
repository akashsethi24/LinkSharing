<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 27/6/15
  Time: 6:39 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Link Sharing: ADMIN PANEL</title>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <style type="text/css">
    #header {
        height: 150px;
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
                ${userd}
                <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <li> <g:link controller="user" action="index">Profile</g:link></li>
                <g:if test="${userd.admin==true}">
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
        <th>ID</th>
        <th>Email</th>
        <th>FirstName</th>
        <th>LastName</th>
        <th>Username</th>
        <th>Active</th>
        <th>Manage</th>
    </tr>
    <g:each in="${user}" var="users">
        <tr>
            <td>${users.id}</td>
            <td>${users.email}</td>
            <td>${users.firstName}</td>
            <td>${users.lastName}</td>
            <td>${users.username}</td>
            <td>${users.active}</td>
            <td><g:if test="${users.active==true}">
                <g:form controller="user" action="changeuser">
                    <g:hiddenField name="active" value="${users.username}"/>
                    <g:submitButton name="Deactivate" class="btn btn-danger"/>
                </g:form>
            </g:if>
            <g:elseif test="${users.active==false}">
                <g:form controller="user" action="changeuser">
                    <g:hiddenField name="active" value="${users.username}"/>
                    <g:submitButton name="Activate" class="btn btn-danger"/>
                </g:form>
            </g:elseif>
            </td>
        </tr>
    </g:each>
</table>
</body>
</html>