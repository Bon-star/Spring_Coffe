package root.pattern;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import root.models.DBConnection;
import root.models.Product;
import root.mappers.ProductMapper;

public class ProductRepository implements Icrud<Product> {
    private static ProductRepository instance = null;

    private ProductRepository() {}

    public static ProductRepository Instance() {
        if (instance == null) instance = new ProductRepository();
        return instance;
    }

    @Override
    public void Create(Product item) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.CallableStatement cstmt = conn.prepareCall("{call new_product(?, ?, ?, ?, ?)}")) {
            cstmt.setString(1, item.getName());
            cstmt.setLong(2, item.getPrice());
            cstmt.setString(3, item.getImage());
            cstmt.setInt(4, item.getActive());
            cstmt.setInt(5, item.getCategoryId());
            cstmt.execute();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public void Update(Product item) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.CallableStatement cstmt = conn.prepareCall("{call update_product(?, ?, ?, ?, ?, ?)}")) {
            cstmt.setInt(1, item.getId());
            cstmt.setString(2, item.getName());
            cstmt.setLong(3, item.getPrice());
            cstmt.setString(4, item.getImage());
            cstmt.setInt(5, item.getActive());
            cstmt.setInt(6, item.getCategoryId());
            cstmt.execute();
        } catch (Exception e) { e.printStackTrace(); }
    }

    @Override
    public boolean Delete(Product item) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.CallableStatement cstmt = conn.prepareCall("{call delete_product(?)}")) {
            cstmt.setInt(1, item.getId());
            return cstmt.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    @Override
    public Product GetbyID(Object id) {
        Product p = null;
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.CallableStatement cstmt = conn.prepareCall("{call get_product_by_id(?)}")) {
            cstmt.setInt(1, (Integer)id);
            ResultSet rs = cstmt.executeQuery();
            if (rs.next()) {
                p = new ProductMapper().RowMap(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return p;
    }

    @Override
    public List<Product> Gets() {
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.CallableStatement cstmt = conn.prepareCall("{call get_products()}");
             ResultSet rs = cstmt.executeQuery()) {
            while (rs.next()) {
                list.add(new ProductMapper().RowMap(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public List<Product> Search(String key) { return new ArrayList<>(); }
}