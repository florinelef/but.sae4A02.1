package modele.dto;

public class Follower {
    String username;
    int id_thread;

    public Follower(String username, int id_thread) {
        this.username = username;
        this.id_thread = id_thread;
    }

    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public int getId_thread() {
        return id_thread;
    }
    
    public void setId_thread(int id_thread) {
        this.id_thread = id_thread;
    }
}
