package root.mappers;
import java.sql.ResultSet;
import java.util.List;

public interface IMapper<T> {
    T RowMap(ResultSet rs);
    List<T> RowsMap(ResultSet rs);
}