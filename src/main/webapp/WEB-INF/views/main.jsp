<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Chat</title>

    <script><%@include file="/WEB-INF/scripts/script.js"%></script>
    <style><%@include file="/WEB-INF/styles/style.css"%></style>

</head>
<body>
<h1 class="title">Chat Box</h1>

<div class="start">
    <input type="text" class="username" required placeholder="enter name...">
    <button id="startBtn">start</button>
</div>

<div class="chatbox">
  <div class="sendBlock">
    <textarea class="msg"> </textarea>
    <button id="sendBtn">SEND</button>
  </div>
    <div class="messages">
    </div>
</div>
</body>

</html>