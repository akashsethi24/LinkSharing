<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 25/6/15
  Time: 10:15 PM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Link Sharing: Profile</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
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

<div id="right">
<table class="table table-condensed">
    <tr>
        <th>Photo</th>
        <th>Name</th>
        <th>Subscription</th>
        <th>Topics</th>
    </tr>
    <tr>
        <td><g:link controller="user" action="index"><gt:pic uid="${users.id}"/></g:link></td>
        <td>${users.toString()}</td>
        <td>${scount}</td>
        <td>${tcount}</td>
    </tr>
    </table>
    <table class="table table-condensed">
        <tr>
            <th>Topic</th>
        </tr>
        <g:each in="${sub}" var="ss">
            <tr>

                <td>Name:-<g:link controller="topic" action="index" params="['topic':ss.topic.name]">${ss.topic.name}</g:link></td>
                <td>Subscription:- ${scount}</td>
                <td>Posts :- ${rcount}</td>

            </tr>
            <tr>
                <td>
                    <g:select name="seriousness" from="${ss.seriousness}"></g:select>
                </td>
                <td>
                    <a href="#" >Subscribe</a>
                </td>
                <td> <g:form controller="dashboard" action="SInvite">
                    <g:hiddenField name="topic" value="${ss.topic.name}"/>
                    <g:submitButton name="invite" value="Invite" class="btn btn-danger"/>
                </g:form></td>
            </tr>
        </g:each>
    </table>

</div>
<div id="left">
    <table class="table">
        <tr>
            <th>Posts</th>
        </tr>
        <g:each in="${AllResource}" var="all">
        <tr>
            <th>${all.title}</th>

        </tr>
            <tr>
                <td>
                    ${all.description}
                </td>
        </tr>
            <tr>
                <td><g:if test="${all.instanceOf(link_sharing.DocumentResource)}"><g:link controller="resource" action="downloadit" params="[resource:all.title]">Download</g:link></g:if>
                <g:else><g:link controller="resource" action="viewfull" params="[resource: all.title]">View Full Site</g:link></g:else>
                </td>

                <td><g:link controller="resourceRating" action="index" params="[resource:all.title]">View Post</g:link></td>
            </tr>
        </g:each>
    </table>
</div>
</body>
</html>