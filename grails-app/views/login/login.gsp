

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="link_sharing.*" %>
<html xmlns:color="http://www.w3.org/1999/xhtml">
<head>
    <asset:stylesheet src="application.css"/>
    <asset:javascript src="application.js"/>



    <style type="text/css">

    h1{color:#000000}
    #left{
        height:450px;
        width:600px;
        float:right;
        padding:20px;
    }
    #right{
        width:450px;
        height:450px;
        float:left;
        padding:20px;
    }
    #bottom{
        clear:both;
        height:60px;
        text-align:center;
        padding:5px;
    }
    #header{
        height:90px;

        padding:5px;
        background-color: #EAFFF7;
    }
        </style>

</head>

<body>
<div id="header">

    <h1 class="text-error" style="color:#D42727"align="center">Link Sharing Application</h1>
    </div>
<div id="right">
    <table border="1" class="table" bgcolor="white">
        <tr>
            <td><h4><b>Login</b></h4></td>
            </tr>
        <tr>
            <td>

<g:form controller="login" action="login" method="post" align="right">
    <label for="username">Username</label>
  <g:textField name="username" /><br>
    <label for="password">Password</label>
 <g:passwordField name="password" /><br>
    <g:link action="recent">Forget Password</g:link>
    <g:submitButton name="Login" class="btn btn-danger" />
            </g:form>

</td>
            </tr>
        <tr>
            <td><h4><b>Registration</b></h4></td>
        </tr>
        <g:if test="${bool==false}">
        <tr>
            <td>
                <g:renderErrors bean="${flash["user"]}" as="list"/>
            </td>
        </tr>
            <tr><g:if test="${bbool==false}">
                <td>Please Check Password</td>
            </g:if>
            </tr>
        </g:if>
        <tr>
        <td>
<g:uploadForm controller="login" action="register" method="post" align="right">

    <label for="firstName">First Name </label>
        <g:textField name="firstName" /><br>
        <label for="lastName">Last Name</label>
        <g:textField name="lastName"/><br>
        <label for="email">Email</label>
        <g:textField name="email"/><br>
        <label for="username">Username</label>
        <g:textField name="username"/><br>
        <label form="password">Password</label>
        <g:passwordField name="password"/><br>
        <label for="confirmPassword">Confirm Password</label>
        <g:passwordField name="confirmPassword"/><br><br>
        <g:field type="File" name="photo" align="right"/><br>
        <g:submitButton name="Register" value="Register" class="btn btn-danger" />
    </g:uploadForm>
        </td>
</tr>
        </table>
    </div>
<div id="left" align="right">
    <h3 class="text-error" style="color:#D42727">Recent Shares</h3>
    <table  border="1" class="table table-hover">
        <tr>
        <th>Resource Title </th>
        <th>Create By </th>
        <th>Description </th>
        </tr>
        <g:each in="${resources}" var="rs">
        <tr>
            <td><g:link controller="resourceRating" action="index" params="[resource:rs.title]" > ${rs.title}</g:link></td>
            <td>${rs.creator}</td>
            <td>${rs.description}</td>
        </tr>
            </g:each><br>

            %{--<g:paginate total="${total}" max="5" params="[q:params.q]"/>--}%
    </table>
    <h3 class="text-error" style="color:#D42727">Top Posts</h3>
<table border="1" align="left" class="table table-hover">
    <tr>
    <th>Post Tittle</th>
        <th>Description</th>
    </tr>

    <g:each in="${topic}" var="top">
        <tr>
        <td>${top.title}</td>
        <td>${top.description}</td>
        </tr>
    </g:each><br>

    </table>

</div>
<g:if test="${logini==false}"><g:javascript>alert("Please Check Credentials")</g:javascript>
<%logini=true%>
</g:if>
<g:if test="${loginb==false}">${loginb=true}<g:javascript>alert("Account Block By Admin")</g:javascript>
    <%loginb=true%>
</g:if>
</body>
</html>