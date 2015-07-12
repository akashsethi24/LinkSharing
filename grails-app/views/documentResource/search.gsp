<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 27/6/15
  Time: 2:36 PM
--%>

<%@ page import="link_sharing.Subscription; link_sharing.Topic" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title></title>
    <title>Link Sharing: DASHBOARD</title>
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
<table class="table table-striped">
    <tr>
        <th>Topic Name</th>
        <th> </th>
        <th>Topic Visiblity</th>

    </tr>
    <g:each in="${topicList}" var="tl">
        <tr>
            <td>${tl.name}<td>
            <td>${tl.visibility}</td>

          <td>  <% def sub = link_sharing.Subscription.findByUserAndTopic(user, tl)
          if (sub) { %>
                <g:form controller="documentResource" action="unsubs">
                    <g:hiddenField name="topic" value="${tl.name}"/>
                    <g:submitButton name="Unsuscribe"  class="btn btn-danger"/>
                </g:form>
            <% }
        else {%>

                <g:form controller="documentResource" action="index">
                    <g:hiddenField name="topic" value="${tl.name}"/>
                <g:submitButton name="Subscribe" class="btn btn-danger"/>
                </g:form>

  <%  }%>
            </td>
        </tr>
    </g:each>
</table>
</div>
<div id="left">
    <table class="table">
        <tr>
        <th>Photo</th>
        <th>Creater</th>
            <th>Title</th>
        </tr>
        <g:each in="${resources}" var="rs">
        <tr>
         <td><gt:pic uid="${rs.creator.id}"/></td>
            <td>${rs.creator}</td>
            <td>${rs.title}</td>
        </tr>
            <tr>
            <td>${rs.description}</td>
            <td><g:if test="${rs.instanceOf(link_sharing.DocumentResource)}"><g:link controller="resource" action="downloadit" params="[resource:rs.title]">Download</g:link></g:if>
            <g:else><g:link controller="resource" action="viewfull" params="[resource: rs.title]">View Full Site</g:link></g:else></td>
            <td><g:link controller="resourceRating" action="index" params="[resource:rs.title]">View Post</g:link></td>
            </tr>
        </g:each>
    </table>
</div>
</body>
</html>