package root.mappers;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.models.SubCategory;

public class SubCategoryMapper implements IMapper<SubCategory> {
    @Override
    public SubCategory RowMap(ResultSet rs) {
        SubCategory s = new SubCategory();
        try {
            s.setId(rs.getInt("id"));
            s.setName(rs.getString("name"));
            s.setCategoryId(rs.getInt("category_id"));
            s.setActive(rs.getInt("active"));
            try { s.setCategoryName(rs.getString("category_name")); } catch(Exception e){}
        } catch (SQLException e) { return null; }
        return s;
    }
    @Override
    public List<SubCategory> RowsMap(ResultSet rs) {
        List<SubCategory> list = new ArrayList<>();
        try { while (rs.next()) list.add(RowMap(rs)); } catch (SQLException e) {}
        return list;
    }
}