package root.mappers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;

import root.models.Category;
import root.utils.StringValue;

public final class CategoryMapper implements IMapper<Category>{

	@Override
	public Category RowMap(ResultSet rs) {
		// TODO Auto-generated method stub
		Category item=new Category();
		try {
			item.setId(rs.getInt(StringValue.CATEGORY_ID_COL));
			item.setName(rs.getString(StringValue.CATEGORY_NAME_COL));
			item.setActive(rs.getInt(StringValue.CATEGORY_ACTIVE_COL));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return item;
	}

	@Override
	public HashSet<Category> RowsMap(ResultSet rs) {
		// TODO Auto-generated method stub
		HashSet<Category> hs=new HashSet<Category>();
		try {
			while (rs.next()) {
				Category item = RowMap(rs);
				hs.add(item);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return hs;
	}
	
}
