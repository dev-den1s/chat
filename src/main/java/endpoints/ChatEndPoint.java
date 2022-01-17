package endpoints;

import coders.MessageDecoder;
import coders.MessageEncoder;
import entities.Message;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

@ServerEndpoint(value = "/chat/{user}", encoders = {MessageEncoder.class}, decoders = {MessageDecoder.class})
public class ChatEndPoint {
    private Session session = null;
    private String username = "anonymous";
    private static List<Session> sessionList = new LinkedList<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("user") String username) {
        this.session = session;
        this.username = username;
        sessionList.add(session);
    }

    @OnClose
    public void onClose(Session session) {
        // when the user hangs up the connection, we delete his session from the sessions list
        sessionList.remove(session);
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        // error socket
        throwable.printStackTrace();
    }

    @OnMessage
    public void onMessage(Session session, Message msg) {
        // когда нам пришло сообщение, нам нужно отправить
        // это сообщение всем пользователям кроме отправителя

        // if we get message, we need to send it to other users
        msg.setName(this.username);
        sessionList.forEach(s -> {
            if (s == this.session) return;
            try {
                s.getBasicRemote().sendObject(msg);
            } catch (IOException | EncodeException e) {
                e.printStackTrace();
            }
        });
    }
}
