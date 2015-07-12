<%--
  Created by IntelliJ IDEA.
  User: akash
  Date: 1/7/15
  Time: 10:42 AM
--%>

<%@ page import="link_sharing.DocumentResource" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
    <title>Link Sharing: RATING</title>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>
    <style type="text/css">

    div.stars {
        width: 270px;
        display: inline-block;
    }

    input.star { display: none; }

    label.star {
        float: right;
        padding: 10px;
        font-size: 36px;
        color: #444;
        transition: all .2s;
    }

    input.star:checked ~ label.star:before {
        content: '\f005';
        color: #FD4;
        transition: all .25s;
    }

    input.star-5:checked ~ label.star:before {
        color: #FE7;
        text-shadow: 0 0 20px #952;
    }

    input.star-1:checked ~ label.star:before { color: #F62; }

    label.star:hover { transform: rotate(-15deg) scale(1.3); }

    label.star:before {
        content: '\f006';
        font-family: FontAwesome;
    }

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




    <g:if test="${user==null}">
        <h1 align="center">You Needs to Login First </h1>
        <g:link controller="login" action="index"><h1 align="center"> Go To Login Page</h1></g:link>
    </g:if>
    <g:else>
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
            <td>
                <gt:pic uid="${user.id}"/>
            </td>
            <td>${user.toString()}</td>
            <td>${resource.title} </td>
        </tr>
        <tr>



                   <g:form controller="resourceRating" action="ratings" method="get">
                       <td>
                       <div class="stars">
                           <g:if test="${rate=="5"}">
                               <input class="star star-5" id="star-5" type="radio" name="star" value="5" checked="checked"/>
                           </g:if>
                           <g:else> <input class="star star-5" id="star-5" type="radio" name="star" value="5" /></g:else>
                    <label class="star star-5" for="star-5"></label>

                           <g:if test="${rate=="4"}">
                               <input class="star star-4" id="star-4" type="radio" name="star" value="4" checked="checked"/>
                           </g:if>
                           <g:else> <input class="star star-4" id="star-4" type="radio" name="star" value="4"/></g:else>
                           <label class="star star-4" for="star-4" ></label>

                           <g:if test="${rate=="3"}">
                               <input class="star star-3" id="star-3" type="radio" name="star" value="3" checked="checked"/>
                           </g:if>
                           <g:else><input class="star star-3" id="star-3" type="radio" name="star" value="3" /></g:else>
                    <label class="star star-3" for="star-3"></label>

                           <g:if test="${rate=="2"}">
                               <input class="star star-2" id="star-2" type="radio" name="star" value="2" checked="checked"/>
                           </g:if>
                           <g:else>  <input class="star star-2" id="star-2" type="radio" name="star" value="2"/></g:else>
                    <label class="star star-2" for="star-2"></label>

                           <g:if test="${rate=="1"}">
                               <input class="star star-1" id="star-1" type="radio" name="star" value="1" checked="checked"/>
                           </g:if>
                        <g:else>
                            <input class="star star-1" id="star-1" type="radio" name="star" value="1"/>
                        </g:else>
                    <label class="star star-1" for="star-1"></label>
                        </div>
                       </td>
                       <td>
                       <g:submitButton name="Rate" class="btn btn-warning"/>

                   </g:form>

           </td>
        </tr>
        <tr>
            <td>${resource.description}</td>
        </tr>
        <tr>
            <g:if test="${(resource.creator==user) || (user.admin==true)   }">

            </g:if>
            <td><g:link controller="resourceRating" action="deleteres" params="[title:resource.title]">Delete</g:link></td>
            <td><g:link>Edit</g:link></td>
            <td>
                <g:if test="${resource.instanceOf(link_sharing.DocumentResource)}"><g:link>Download</g:link></g:if>
                <g:else><g:link controller="resource" action="viewfull" params="[resource: resource.title]">View Full Site</g:link></g:else>
            </td>

        </tr>
    </table>
    </g:else>
</div>

<div id="left">
    <table class="table">
        <tr><th>Trending Topics</th></tr>
        <g:each in="${trend}" var="trends">
            <tr>
                <td><gt:pic uid="${trends.user.id}"/> </td>
                <td>${trends.user}</td>
                <td>${trends.name}</td>
                <td><% def sub = link_sharing.Subscription.findByUserAndTopic(user, trends)
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

</body>
</html>