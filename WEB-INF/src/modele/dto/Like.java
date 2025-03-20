package modele.dto;

public class Like {
    private String username;
    private int idMessage;

    public Like(String username, int idMessage) {
        this.username = username;
        this.idMessage = idMessage;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getIdMessage() {
        return idMessage;
    }

    public void setIdMessage(int idMessage) {
        this.idMessage = idMessage;
    }
}
