<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 26/6/15
  Time: 6:45 PM
--%>

<%@ page import="link_sharing.Topic; link_sharing.Subscription" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <title>Link Sharing: Profile</title>

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

<div id="right">
    <table class="table">
        <tr>
            <th>Topic</th>
        </tr>
        <tr>
            <td><g:link controller="user" action="index"><gt:pic uid="${user.id}"/></g:link>   </td>
            <td>Name:- ${topic.name} (${topic.visibility})</td>
            <td><g:link>Subscription</g:link></td>
        </tr>
        <tr>
            <td>Subscription:- ${tcount}</td>
            <td>Posts:- ${rcount}</td>
            <td><g:select name="serious" from="${subs.seriousness}"/></td>
            <td>
            <g:form controller="resource" action="invites">
                <g:hiddenField name="topic" value="${topic.name}"/>
                <g:submitButton name="invite" value="Invite" class="btn btn-danger"/>
            </g:form>
            </td>
        </tr>
        <g:if test="${user.admin==true || subs.topic.user==user}">
            <tr>

                <td><g:link controller="topic" action="edittopic" params="[topic:subs.topic.name]">Edit</g:link></td>
                <td><g:link controller="dashboard" action="deleteit" params="[topic: subs.topic.name]">Delete</g:link></td>
            </tr>
        </g:if>
    </table>
    <table class="table">
        <tr><th>Users ${topic.name}</th></tr>
        <g:each in="${userlist}" var="use">
            <tr>
                <td><g:link controller="user" action="index"><gt:pic uid="${use.id}"/></g:link> </td>
                <td>${use.toString()}</td>
            </tr>
            <tr>
                <td>Subscription ${link_sharing.Subscription.countByUser(use)}</td>
                <td>Topics ${link_sharing.Topic.countByUser(use)}</td>
            </tr>
        </g:each>
    </table>
</div>
<table class="tabel">
   <tr><th>Posts ${topic.name}</th></tr>
    <g:each in="${resource}" var="res">
        <tr>
      <td><g:link controller="user" action="index"><gt:pic uid="${res.creator.id}"/></g:link></td>
            <td>${res.description}</td>
            <td>&ensp;<g:if test="${res.instanceOf(link_sharing.DocumentResource)}"><g:link controller="resource" action="downloadit" params="[resource:res.title]">Download</g:link></g:if>
                <g:else><g:link controller="resource" action="viewfull" params="[resource: res.title]">View Full Site</g:link></g:else></td>
            <td>&ensp;<g:link controller="resourceRating" action="index" params="[resource:res.title]">View Post</g:link></td>
        </tr>
    </g:each>
</table>
</body>
</html>