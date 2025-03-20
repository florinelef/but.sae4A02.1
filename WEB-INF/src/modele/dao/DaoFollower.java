package modele.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import modele.dto.Follower;
import modele.dto.Thread;
import modele.dto.User;
import utils.DS;

public class DaoFollower {

    public List<Follower> findAll() {
        DS bdd = DS.getInstance();
        List<Follower> res = new ArrayList<>();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM followers");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                res.add(new Follower(rs.getString("username"), rs.getInt("id_thread")));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public void create(Follower follower) {
        DS bdd = DS.getInstance();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("INSERT INTO followers VALUES (?,?)");
            ps.setString(1, follower.getUsername());
            ps.setInt(2, follower.getId_thread());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void delete(Follower follower) {
        DS bdd = DS.getInstance();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("DELETE FROM followers WHERE username=? AND id_thread=?");
            ps.setString(1, follower.getUsername());
            ps.setInt(2, follower.getId_thread());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<User> findUsersByThreadID(int idThread){
        DS bdd = DS.getInstance();
        List<User> res = new ArrayList<>();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM users JOIN followers ON users.username = followers.username WHERE id_thread = ?");
            ps.setInt(1, idThread);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                res.add(new User(rs.getString("username"), rs.getString("password"),rs.getString("firstname"),rs.getString("lastname")));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public List<Thread> findThreadsByUsername(String username){
        DS bdd = DS.getInstance();
        List<Thread> res = new ArrayList<>();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM threads JOIN followers ON threads.id_thread = followers.id_thread WHERE username = ?");
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                res.add(new Thread(rs.getInt("id_thread"), rs.getString("creator"),rs.getString("name"),rs.getDate("date").toLocalDate()));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }

    public boolean checkFollowerExist(Follower follower){
        DS bdd = DS.getInstance();
        boolean res = false;
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM followers WHERE username = ? AND id_thread = ?");
            ps.setString(1, follower.getUsername());
            ps.setInt(2, follower.getId_thread());
            ResultSet rs = ps.executeQuery();
            res = rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return res;
    }


    public boolean userIsInThread(String username, int idThread){
        DS bdd = DS.getInstance();
        try(Connection con = bdd.getConnection()) {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM followers WHERE id_thread = ? AND username = ?");
            ps.setInt(1, idThread);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
