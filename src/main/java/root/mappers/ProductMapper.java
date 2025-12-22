package root.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import root.models.Product;
import root.utils.StringValue;

public final class ProductMapper implements IMapper<Product> {

    @Override
    public Product RowMap(ResultSet rs) {
        Product item = new Product();
        try {
            item.setId(rs.getInt(StringValue.PRODUCT_ID_COL));
            item.setName(rs.getString(StringValue.PRODUCT_NAME_COL));
            item.setPrice(rs.getLong(StringValue.PRODUCT_PRICE_COL));
            item.setImage(rs.getString(StringValue.PRODUCT_IMAGE_COL));
            item.setActive(rs.getInt(StringValue.PRODUCT_ACTIVE_COL));
            item.setCategoryId(rs.getInt(StringValue.PRODUCT_CID_COL));
            
            try {
                item.setCategoryName(rs.getString("category_name"));
            } catch (Exception e) {
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }

    @Override
    public HashSet<Product> RowsMap(ResultSet rs) {
        HashSet<Product> hs = new HashSet<>();
        try {
            while (rs.next()) {
                hs.add(RowMap(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return hs;
    }
}