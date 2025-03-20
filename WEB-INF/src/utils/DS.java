package utils;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DS {
    private static DS instance = new DS();

    public static DS getInstance() {
        return instance;
    }

    private String driver;
    private String url;
    private String login;
    private String password;

    private DS(){
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("../config.prop")) {
            if (input == null) {
                System.out.println("Fichier config.prop non trouvé !");
                return;
            }
            Properties properties = new Properties();
            properties.load(input);
            this.driver = properties.getProperty("driver");
            this.url = properties.getProperty("url");
            this.login = properties.getProperty("login");
            this.password = properties.getProperty("password");

            Class.forName(this.driver);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public Connection getConnection(){
        try {
            return DriverManager.getConnection(this.url,this.login,this.password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
