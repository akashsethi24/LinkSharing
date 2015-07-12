<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 3/7/15
  Time: 6:26 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <style>
    #header {
    height: 130px;

    padding: 5px;
    background-color: #EAFFF7;
    }</style>
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
<div align="center">
<table class="table>">
    <tr>
        <th>Create Resource</th>
    </tr>
    <tr>
        <g:form controller="resource" action="createreource">
        <td>
           <br> <label for="title">Title</label>&emsp;&emsp;&emsp;&emsp;
            <g:textField name="title"/><br>
        </td>
            </tr>
            <tr>
            <td>
                <br>  <label for="description">Description</label>&emsp;
                <g:textField name="description"/><br>
            </td>
            </tr>
            <tr>
            <td>
                <br><label for="type">Type of Resource</label>&emsp;&emsp;&emsp;&emsp;
                <select id="type" name="type"><option value="doc">Document</option><option value="link">Link</option> </select>
            </td>
            </tr>
            <tr>
            <td>
                <br><label for="filePath">FilePath (For Document)</label>
           <g:field type="File" name="filePath"/><br>
                <label for="url">URL (For Link)</label>
                <g:textField name="url"/><br>
            </td>
            </tr>
            <tr>
            <td>
                <br><label for="topic">Topic</label>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                <g:select name="topic" from="${topics.name}"/><br>
            </td>
            </tr>
            <tr>
            <td>
                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<g:submitButton name="Create"/>
            </td>
        </g:form>
    </tr>
</table>
</div>
</body>
</html>