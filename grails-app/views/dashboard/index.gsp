<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 14/6/15
  Time: 11:34 PM
--%>

<%@ page import="link_sharing.Subscription; link_sharing.DocumentResource" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Link Sharing: DASHBOARD</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <style>
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

<body >
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
            <th>Subscription</th>&emsp;<g:link controller="subscription" action="showsubscription">View All</g:link>
        </tr>

        <g:each in="${sub}" var="ss">
        <tr>
            <td>
            <g:link controller="user" action="index"><gt:pic uid="${users.id}"/></g:link>
            </td>
            <td>Name:-<g:link controller="topic" action="index" params="['topic':ss.topic.name]">${ss.topic.name}</g:link></td>
            <td>Subscription:- ${scount}</td>
            <td>Posts :- ${rcount}</td>
        </tr>
        <tr>
            <td>
                <g:if test="${users.admin==true}">
                    <g:select name="visiblity" from="${top}"></g:select>
                </g:if>
                <g:else>
                    <g:select name="visiblity" from="${ss.topic.visibility}"></g:select>
                </g:else>
            </td>
            <td>
                <g:if test="${users.admin==true}">
                    <g:select name="seriousness" from="${ser}"></g:select>
                </g:if>
                <g:else>
                <g:select name="seriousness" from="${ss.seriousness}"></g:select>
                </g:else>
            </td>
            <td>
                <g:if test="${ss.topic.user==users}">
                <g:link>Unsubscribe</g:link>
                </g:if>
                <g:else> <g:link controller="documentResource" action="unsubs" params="[topic: ss.topic.name   ]">Unsubscribe</g:link></g:else>
            </td>

        </tr>
            <g:if test="${users.admin==true || ss.topic.user==users}">
            <tr>
                <td>
                    <g:form controller="resource" action="invites">
                        <g:hiddenField name="topic" value="${ss.topic.name}"/>
                        <g:submitButton name="invite" value="Invite" class="btn btn-danger"/>
                    </g:form>
                </td>
                <td><g:link controller="topic" action="edittopic" params="[topic:ss.topic.name]">Edit</g:link></td>
                <td><g:link controller="dashboard" action="deleteit" params="[topic: ss.topic.name]">Delete</g:link></td>
            </tr>
            </g:if>
        </g:each>

    </table>
    <table class="table">
        <tr>
            <th>Send Invitation</th>
        </tr>
        <tr>
            <td>
                <g:form controller="dashboard" action="Invite">
                <label for="emailid">Email</label>
                <g:textField name="emailid"/><br>
                    <label for="topic">Topic</label>&emsp;&emsp;&emsp;&emsp;&ensp;&ensp;
                    <select id="topic" name="topic"><% tlist.each{ %>
                        <option value="${it.name}">${it.name}</option>
                        <% }%></select><br>&ensp;&ensp;&ensp;&ensp;&ensp;
                <g:submitButton name="Invite" class="btn btn-danger"/>
                </g:form>
            </td>
        </tr>
    </table>
    <table class="table">
        <tr>
            <th>
                Treanding Topics
            </th>
        </tr>
        <g:each in="${trend}" var="trends">
            <tr>
                <td><g:link controller="user" action="index"><gt:pic uid="${trends.user.id}"/></g:link> </td>
                <td>${trends.user}</td>
                <td>${trends.name}</td>
                <td><% def sub = link_sharing.Subscription.findByUserAndTopic(users, trends)
                if (sub) { %>
                    <g:form controller="documentResource" action="unsubs">
                        <g:hiddenField name="topic" value="${trends.name}"/>
                        <g:submitButton name="Unsuscribe"  class="btn btn-danger"/>
                    </g:form>
                    <% }
                    else {%>

                    <g:form controller="documentResource" action="index">
                        <g:hiddenField name="topic" value="${trends.name}"/>
                        <g:submitButton name="Subscribe" class="btn btn-danger"/>
                    </g:form>

                    <%  }%>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<div id="left">
    <table class="table table-condensed">
        <tr>
            <th>Create Topic</th>
        </tr>
        <tr>
            <td>
    <form controller="dashboard" action="home">
        <label for="name">Topic Name</label>
        <input type="text"id="name" name="name" /><br>
        <label for="visibility">Visiblity</label>&emsp;&emsp;
        <select id="visibility" name="visibility"><option value="PUBLIC">Public</option><option value="PRIVATE">Private</option></select>
        <br>&emsp;&emsp;&emsp;<input type="submit" name="Create Topic" class="btn btn-danger"/>
    </form>
            </td>
        </tr>
    </table>
    <table class="table table-condensed" align="right">
        <tr>
            <th>Share Document</th>
        </tr>
        <tr>
            <td>
                <g:uploadForm controller="dashboard" action="sharedoc" align="left">
            <label for="file">Document:-</label>&emsp;
                    <g:field type="File" name="file" placeholder="Document Url ..." /><br>
                    <label for="des">Description :- </label>
                    <g:textArea name="des" placeholder="Description..."/><br>
                    <label for="topic">Topic</label>&emsp;&emsp;&emsp;&emsp;
                    <select id="topic" name="topic"><% tlist.each{ %>
                        <option value="${it.name}">${it.name}</option>
                        <% }%></select><br>&emsp;&emsp;&emsp;&emsp;
                    <g:submitButton name="Share Document" class="btn btn-danger"/>
                </g:uploadForm>
            </td>
        </tr>
    </table>
    <table class="table table-condensed" align="right">
        <tr>
            <th>Share Link</th>
        </tr>
        <tr>
            <td>
                <g:form controller="dashboard" action="Sharelink" align="left">
                    <label for="url">Link :-</label>&emsp;&emsp;&emsp;&emsp;
                    <g:textField name="url" placeholder="Link ..." /><br>
                    <label for="des">Description :- </label>
                    <g:textArea name="description" placeholder="Description..."/><br>
                    <label for="topic">Topic</label>&emsp;&emsp;&emsp;&emsp;
                    <select id="topic" name="topic"><% tlist.each{ %>
                        <option value="${it.name}">${it.name}</option>
                        <% }%></select><br>&emsp;&emsp;&emsp;&emsp;
                    <g:submitButton name="Share Link" class="btn btn-danger" />
                </g:form>
            </td>
        </tr>
    </table>
    <h1>Inbox</h1>
    <table class="table table-condensed">
        <tr>
            <th>Photo</th>
            <th>Decription</th>
            <th>Title</th>
        </tr>
        <g:each in="${inbox}" var="inb">
            <tr>
                <td><gt:pic uid="${users.id}"/></td>
                <td>${inb.description}</td>
                <td align="right">${inb.title}</td>
            </tr>
            <tr>
                <td><g:if test="${inb.instanceOf(link_sharing.DocumentResource)}"><g:link controller="resource" action="downloadit" params="[resource:inb.title]">Download</g:link></g:if>
                <g:else><g:link controller="resource" action="viewfull" params="[resource: inb.title]">View Full Site</g:link></g:else>
                </td>
                <td><g:link controller="topic" action="readunread" params="[title: inb.title]" >Mark as Read</g:link></td>
                <td><g:link controller="resourceRating" action="index" params="[resource:inb.title]">View Post</g:link></td>
            </tr>
        </g:each>
    </table>

</div>

<div id="bottom">
%{--<gt:pic uid="1" ></gt:pic>--}%
</div>
</body>
</html>