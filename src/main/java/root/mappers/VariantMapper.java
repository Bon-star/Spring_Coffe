package root.mappers;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.models.Variant;

public class VariantMapper implements IMapper<Variant> {
    @Override
    public Variant RowMap(ResultSet rs) {
        try {
            return new Variant(rs.getInt("id"), rs.getInt("product_id"), rs.getString("name"), rs.getLong("price"));
        } catch (SQLException e) { return null; }
    }
    @Override
    public List<Variant> RowsMap(ResultSet rs) {
        List<Variant> list = new ArrayList<>();
        try { while (rs.next()) list.add(RowMap(rs)); } catch (SQLException e) {}
        return list;
    }
}