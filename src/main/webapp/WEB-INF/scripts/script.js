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