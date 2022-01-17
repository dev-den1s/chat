let chatUnit = {
   init(){
     this.startbox=document.querySelector(".start");
     this.chatbox=document.querySelector(".chatbox");

     this.startBtn=this.startbox.querySelector("button");

     this.nameinput=this.startbox.querySelector("input");

     this.msgTextArea = this.chatbox.querySelector("textarea");

     this.bindEvents();
   },

   bindEvents(){
      this.startBtn.addEventListener("click",e=>this.openSocket())
      this.msgTextArea.addEventListener("keyup", e => {
        if(e.ctrKey && e.keyCode === 13){
          alert("test");
          e.preventDefault();
          this.send(this.msgTextArea.value);
        }
      })
   },

   onOpenSock(){

   },

   onMessage(parse){

   },
   onClose(){

   },

   sendMessage(msg){
      this.ws.send(JSON.stringify(msg));
   },

   openSocket(){
      this.ws = new WebSocket("ws://localhost:8080/ChatRSK/chat");
      this.ws.onopen= () => this.onOpenSock();
      this.ws.onmessage= (e) => this.onMessage(JSON.parse(e.data));
      this.ws.onclose= (e) => this.onClose();


      this.name = this.nameinput.value;
      this.startbox.style.display="none";
      this.chatbox.style.display="block";
   }
};

window.addEventListener("load",e=>chatUnit.init());