package root.mappers;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.models.Category;

public class CategoryMapper implements IMapper<Category> {
    @Override
    public Category RowMap(ResultSet rs) {
        Category c = new Category();
        try {
            c.setId(rs.getInt("id"));
            c.setName(rs.getString("name"));
            c.setRootId(rs.getInt("root_id"));
            c.setActive(rs.getInt("active"));
            try { c.setRootName(rs.getString("root_name")); } catch (Exception e) {} 
        } catch (SQLException e) { e.printStackTrace(); }
        return c;
    }

    @Override
    public List<Category> RowsMap(ResultSet rs) {
        List<Category> list = new ArrayList<>();
        try {
            while (rs.next()) list.add(RowMap(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}