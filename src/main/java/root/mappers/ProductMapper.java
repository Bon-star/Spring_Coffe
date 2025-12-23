package root.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.models.Product;

public class ProductMapper implements IMapper<Product> {

    @Override
    public Product RowMap(ResultSet rs) {
        Product p = new Product();
        try {
            p.setId(rs.getInt("id"));
            p.setName(rs.getString("name"));
            p.setImage(rs.getString("image"));
            p.setSubCategoryId(rs.getInt("subcategory_id"));
            p.setActive(rs.getInt("active"));
            try { 
                p.setSubCategoryName(rs.getString("subcategory_name")); 
            } catch (Exception e) {}

            try { 
                p.setCategoryName(rs.getString("cat_name")); 
            } catch (Exception e) {}
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return p;
    }

    @Override
    public List<Product> RowsMap(ResultSet rs) {
        List<Product> list = new ArrayList<>();
        try {
            while (rs.next()) {
                list.add(RowMap(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}