package root.models;

import java.sql.Connection;
import java.sql.SQLException;
import com.microsoft.sqlserver.jdbc.SQLServerDataSource;
import root.utils.StringValue;

public final class DBConnection {
    private static DBConnection instance = null;

    private DBConnection() {}

    public static DBConnection GetInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection GetConn() {
        try {
            SQLServerDataSource ds = new SQLServerDataSource();
            ds.setUser(StringValue.USER_SQL);
            ds.setPassword(StringValue.PWD_SQL);
            ds.setServerName(StringValue.SERVER_SQL);
            ds.setPortNumber(Integer.parseInt(StringValue.PORT_SQL));
            ds.setDatabaseName(StringValue.DATABASE_SQL);
            ds.setEncrypt("true"); 
            ds.setTrustServerCertificate(true);

            Connection conn = ds.getConnection();
            if (conn != null) {
                System.out.println("===> KẾT NỐI DATABASE THÀNH CÔNG!");
            }
            return conn;            
        } catch (SQLException e) {
        	System.err.println("===> KẾT NỐI THẤT BẠI: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
