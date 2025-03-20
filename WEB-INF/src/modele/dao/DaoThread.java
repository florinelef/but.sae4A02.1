package modele.dao;

import modele.dto.Thread;
import utils.DS;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoThread {

    public List<Thread> findAll() {
        DS bdd = DS.getInstance();
        List<Thread> res = new ArrayList<>();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM threads");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                res.add(new Thread(rs.getInt("id_thread"), rs.getString("creator"), rs.getString("name"), rs.getDate("date").toLocalDate()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public Thread findById(int idThread) {
        DS bdd = DS.getInstance();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM threads WHERE id_thread = ?");
            ps.setInt(1, idThread);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Thread(rs.getInt("id_thread"), rs.getString("creator"), rs.getString("name"), rs.getDate("date").toLocalDate());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    // créer un thread et renvoie l'id
    public int create(Thread thread) {
        DS bdd = DS.getInstance();
        int id = -1;
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO threads (creator, name, date) VALUES (?, ?, ?) RETURNING id_thread;");
            ps.setString(1, thread.getCreator());
            ps.setString(2, thread.getName());
            ps.setDate(3, java.sql.Date.valueOf(thread.getDate()));
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                id = rs.getInt("id_thread");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return id;
    }

    public void delete(int idThread) {
        DS bdd = DS.getInstance();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM threads WHERE id_thread = ?");
            ps.setInt(1, idThread);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Thread> findByCreator(String creator) {
        DS bdd = DS.getInstance();
        List<Thread> res = new ArrayList<>();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM threads WHERE creator = ?");
            ps.setString(1, creator);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                res.add(new Thread(rs.getInt("id_thread"), rs.getString("creator"), rs.getString("name"), rs.getDate("date").toLocalDate()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public List<Thread> findThreadNotFollow(String creator) {
        DS bdd = DS.getInstance();
        List<Thread> res = new ArrayList<>();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM threads WHERE id_thread NOT IN (SELECT id_thread FROM followers WHERE username = ?) ORDER BY date DESC");
            ps.setString(1, creator);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                res.add(new Thread(rs.getInt("id_thread"), rs.getString("creator"), rs.getString("name"), rs.getDate("date").toLocalDate()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public List<Thread> findThreadFollow(String creator) {
        DS bdd = DS.getInstance();
        List<Thread> res = new ArrayList<>();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM threads WHERE id_thread IN (SELECT id_thread FROM followers WHERE username = ?) ORDER BY date DESC");
            ps.setString(1, creator);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                res.add(new Thread(rs.getInt("id_thread"), rs.getString("creator"), rs.getString("name"), rs.getDate("date").toLocalDate()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public boolean isCreatorOf(String creator, int idThread){
        DS bdd = DS.getInstance();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM threads WHERE id_thread = ? AND creator = ?");
            ps.setInt(1, idThread);
            ps.setString(2, creator);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
