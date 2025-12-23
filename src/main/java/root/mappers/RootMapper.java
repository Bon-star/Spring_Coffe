package root.mappers;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import root.models.Root;

public class RootMapper implements IMapper<Root> {
    @Override
    public Root RowMap(ResultSet rs) {
        try {
            return new Root(rs.getInt("id"), rs.getString("name"), rs.getInt("active"));
        } catch (SQLException e) { return null; }
    }
    @Override
    public List<Root> RowsMap(ResultSet rs) {
        List<Root> list = new ArrayList<>();
        try { while (rs.next()) list.add(RowMap(rs)); } catch (SQLException e) {}
        return list;
    }
}