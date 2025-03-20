package modele.dto;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;

public class Thread {
    int id_thread;
    String creator;
    String name;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    LocalDate date;
    
    public Thread(int id_thread, String creator, String name, LocalDate date) {
        this.id_thread = id_thread;
        this.creator = creator;
        this.name = name;
        this.date = date;
    }

    public int getId_thread() {
        return id_thread;
    }

    public void setId_thread(int id_thread) {
        this.id_thread = id_thread;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }
}
