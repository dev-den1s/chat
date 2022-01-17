<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Chat</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<h1 class="title">Chat Box</h1>

<div class="start">
    <input type="text" class="username" placeholder="enter name...">
    <button id="startBtn">start</button>
</div>

<div class="chatbox">
    <textarea class="msg"> </textarea>
    <div class="messages">
    </div>
</div>
</body>

</html>