package root.pattern;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashSet;

import root.models.Category;
import root.models.DBConnection;

public class CategoryRepository implements Icrud<Category> {
	private static CategoryRepository instance=null;
	private CategoryRepository() {
		// TODO Auto-generated constructor stub
	}
	public static CategoryRepository Instance() {
		if (instance==null) {
			instance=new CategoryRepository();
		}
		return instance;
	}
	@Override
	public void Create(Category Item) {
		// TODO Auto-generated method stub
		 String sql = "{call new_category(?, ?)}";

	        try (
	            Connection conn = DBConnection.GetInstance().GetConn();
	            CallableStatement cs = conn.prepareCall(sql);
	        ) {
	            cs.setString(1, Item.getName());
	            cs.setInt(2, Item.getActive());
	            cs.execute();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}

	@Override
	public void Update(Category Item) {
		 String sql = "{call update_category(?, ?, ?)}";
	        try (
	            Connection conn = DBConnection.GetInstance().GetConn();
	            CallableStatement cs = conn.prepareCall(sql)
	        ) {
	            cs.setInt(1, Item.getId());
	            cs.setString(2, Item.getName());
	            cs.setInt(3, Item.getActive());
	            cs.execute();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}

	@Override
	 public boolean Delete(Category Item) {
        String sql = "{call delete_category(?)}";
        try (
            Connection conn = DBConnection.GetInstance().GetConn();
            CallableStatement cs = conn.prepareCall(sql)
        ) {
            cs.setInt(1, Item.getId());
            return cs.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


	@Override
	public Category GetbyID(Object id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
    public HashSet<Category> Gets() {
        HashSet<Category> list = new HashSet<>();
        String sql = "{call get_categories}";

        try (
            Connection conn = DBConnection.GetInstance().GetConn();
            CallableStatement cs = conn.prepareCall(sql);
            ResultSet rs = cs.executeQuery();
        ) {
            while (rs.next()) {
                Category c = new Category();
                c.setId(rs.getInt("c_id"));
                c.setName(rs.getString("c_name"));
                c.setActive(rs.getInt("c_active"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

	@Override
	public HashSet<Category> Search(String key) {
		// TODO Auto-generated method stub
		return null;
	}

}