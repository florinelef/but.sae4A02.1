package modele.dao;

import modele.dto.Like;
import utils.DS;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoLike {

    public List<Like> findAll() {
        DS bdd = DS.getInstance();
        List<Like> likes = new ArrayList<>();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM likes");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                likes.add(new Like(rs.getString("username"), rs.getInt("id_message")));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return likes;
    }

    public void create(Like like) {
        DS bdd = DS.getInstance();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO likes VALUES (?, ?)");
            ps.setString(1, like.getUsername());
            ps.setInt(2, like.getIdMessage());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(Like like) {
        DS bdd = DS.getInstance();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM likes WHERE username=? AND id_message=?");
            ps.setString(1, like.getUsername());
            ps.setInt(2, like.getIdMessage());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int countLikesByMessage(int idMessage) {
        DS bdd = DS.getInstance();
        int count = 0;
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) AS like_count FROM likes WHERE id_message = ?");
            ps.setInt(1, idMessage);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("like_count");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return count;
    }

    public List<Like> findByUser(String username) {
        DS bdd = DS.getInstance();
        List<Like> likes = new ArrayList<>();
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM likes WHERE username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                likes.add(new Like(rs.getString("username"), rs.getInt("id_message")));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return likes;
    }

    public boolean isAlreadyLike(int idMessage, String username){
        DS bdd = DS.getInstance();
        boolean res = false;
        try (Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM likes WHERE id_message = ? AND username = ?");
            ps.setInt(1, idMessage);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();
            res = rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }
}
