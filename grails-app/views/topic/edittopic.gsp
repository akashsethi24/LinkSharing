<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 3/7/15
  Time: 7:26 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <style>
    #header {
        height: 130px;

        padding: 5px;
        background-color: #EAFFF7;
    }</style>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
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
                ${users}
                <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
                <li> <g:link controller="user" action="index">Profile</g:link></li>
                <g:if test="${users.admin==true}">
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

<div align="center">
    <table class="table">
        <tr>
            <th>Create Topic</th>
        </tr>
        <tr>
            <td>
                <g:form controller="topic" action="changetopic">
                    <label for="name">Topic Name</label>
                    <g:textField name="name" value="${topic.name}"/><br>
                    <label for="visibility">Visiblity</label>&emsp;&emsp;
                    <select id="visibility" name="visibility"><option value="PUBLIC">Public</option><option value="PRIVATE">Private</option></select><br>
                    <label for="seriousness">Seriousness</label>
                    <select id="seriousness" name="seriousness"><option value="SERIOUS">Serious</option><option value="CASUAL">Casual</option><option value="VERY_SERIOUS">Very Serious</option> </select>
                    <br>&emsp;&emsp;&emsp;<input type="submit" name="Create Topic" class="btn btn-danger"/>
                </g:form>
            </td>
        </tr>
    </table>
</div>
</body>
</html>