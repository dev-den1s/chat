<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Chat</title>
    <script>
   let chatUnit = {
               init() {
                   this.startbox = document.querySelector(".start");
                   this.chatbox = document.querySelector(".chatbox");
                   this.sendbox = document.querySelector(".chatbox");

                   this.nameInput = this.startbox.querySelector("input")
                   this.startBtn = this.startbox.querySelector("button");

                   this.msgTextArea = this.sendbox.querySelector("textarea");
                   this.sendBtn = this.sendbox.querySelector("button");

                   this.messagesContainer = this.chatbox.querySelector(".messages");
                   this.bindEvents();
               },

               bindEvents() {
                   this.startBtn.addEventListener("click", e => this.openSocket());

                   //key up - это отпустить любую кнопку
                   this.sendBtn.addEventListener("click", e => {
                       if (this.msgTextArea.value) {
                           e.preventDefault();
                           this.send();
                       }
                   });
               },

               send() {
                   this.sendMessage({
                       name: this.name,
                       text: this.msgTextArea.value
                   });
               },

               openSocket() {
                   //ws - WebSocket
                   this.name = this.nameInput.value;

                   this.ws = new WebSocket("ws://localhost:8080/ChatRSK/chat/" + this.name);
                   this.ws.onopen = () => this.onOpenSock();
                   this.ws.onmessage = (e) => this.onMessage(JSON.parse(e.data));
                   this.ws.onclose = () => this.onClose();

                   this.startbox.style.display = "none";
                   this.chatbox.style.display = "block";
               },

               onOpenSock() {

               },

               onMessage(msg) {
                   let msgBlock = document.createElement("div");
                   msgBlock.className = "msg";

                   let fromBlock = document.createElement("div");
                   fromBlock.className = "from";
                   fromBlock.innerText = msg.name;

                   let textBlock = document.createElement("div");
                   textBlock.className = "text";
                   textBlock.innerText = msg.text;

                   msgBlock.appendChild(fromBlock);
                   msgBlock.appendChild(textBlock);

                   this.messagesContainer.prepend(msgBlock);

               },

               onClose() {

               },

               sendMessage(msg) {
                   this.onMessage({
                       name: "Me",
                       text: msg.text
                   })
                   this.msgTextArea.value = "";
                   this.ws.send(JSON.stringify(msg));
               }
           };

           window.addEventListener("load", ev => chatUnit.init());
    </script>

    <style>
    body {
       text-align: center;
    }

            div {
                margin-left: auto;
                margin-right: auto;
            }

            .chatbox {
                display: none;
            }

            .messages {
                background-color: #369;
                width: 500px;
                padding: 20px;
            }

            .messages .msg {
                background-color: #fff;
                border-radius: 10px;
                margin-bottom: 10px;
                overflow: hidden;
            }


            .sendBlock button{
                     width: 50;
                     height: 50;
                     bottom: 4px;
                     left: -1;
                     position: relative;
            }



            .messages .msg .from {
                background-color: #396;
                line-height: 30px;
                text-align: center;
                color: white
            }

            .messages .msg .text {
                padding: 10px;
            }

            textarea.msg {
                width: 487px;
                    padding: 10px;
                    position: relative;
                    resize: none;
                    top: 17;
                    border: none;
                    box-shadow: 2px 2px 5px 0 inset;
            }
    </style>
</head>
<body>
<h1 class="title">Chat Box</h1>

<div class="start">
    <input type="text" class="username" placeholder="enter name...">
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