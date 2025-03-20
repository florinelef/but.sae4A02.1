package modele.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import modele.dto.Message;
import utils.DS;

public class DaoMessage {

    public List<Message> findAll() {
        DS bdd = DS.getInstance();
        List<Message> res = new ArrayList<>();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM messages");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                res.add(new Message(rs.getInt("id_message"), rs.getString("sender"), rs.getInt("id_thread"), rs.getString("message"), rs.getTimestamp("time").toLocalDateTime()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public Message findById(int idMessage) {
        DS bdd = DS.getInstance();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM messages WHERE id_message = ?");
            ps.setInt(1, idMessage);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Message(rs.getInt("id_message"), rs.getString("sender"), rs.getInt("id_thread"), rs.getString("message"), rs.getTimestamp("time").toLocalDateTime());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public List<Message> findByThreadId(int idThread) {
        DS bdd = DS.getInstance();
        List<Message> res = new ArrayList<>();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM messages WHERE id_thread = ? ORDER BY time ASC");
            ps.setInt(1, idThread);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                res.add(new Message(rs.getInt("id_message"), rs.getString("sender"), rs.getInt("id_thread"), rs.getString("message"), rs.getTimestamp("time").toLocalDateTime()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public void create(Message message) {
        DS bdd = DS.getInstance();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO messages (sender, id_thread, message, time) VALUES (?, ?, ?, ?)");
            ps.setString(1, message.getSender());
            ps.setInt(2, message.getId_thread());
            ps.setString(3, message.getMessage());
            ps.setTimestamp(4, java.sql.Timestamp.valueOf(message.getTime()));
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(int idMessage) {
        DS bdd = DS.getInstance();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM messages WHERE id_message = ?");
            ps.setInt(1, idMessage);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}