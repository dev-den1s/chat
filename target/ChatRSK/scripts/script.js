let chatUnit = {
   init(){
     this.startbox=document.querySelector(".start");
     this.chatbox=document.querySelector(".chatbox");

     this.startBtn=this.startbox.querySelector("button");

     this.nameinput=this.startbox.querySelector("input");

     this.bindEvents();
   },

   bindEvents(){
      this.startBtn.addEventListener("click",e=>this.openSocket())
   },

   openSocket(){
      this.ws = new WebSocket("ws://localhost:8080/ChatRSK/chat");
      this.name = this.nameinput.value;

      this.startbox.style.display="none";
      this.chatbox.style.display="block";
   }
};

window.addEventListener("load",e=>chatUnit.init());