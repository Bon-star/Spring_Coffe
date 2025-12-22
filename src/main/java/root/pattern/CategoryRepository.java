package root.pattern;

import java.sql.Connection;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.microsoft.sqlserver.jdbc.SQLServerCallableStatement;

import root.models.Category;
import root.models.DBConnection;

public class CategoryRepository implements Icrud<Category> {

	private static CategoryRepository instance = null;

	private CategoryRepository() {
	}

	public static CategoryRepository Instance() {
		if (instance == null) {
			instance = new CategoryRepository();
		}
		return instance;
	}

	@Override
	public void Create(Category item) {
		try (Connection conn = DBConnection.GetInstance().GetConn();
				SQLServerCallableStatement cstmt = (SQLServerCallableStatement) conn
						.prepareCall("{call new_category(?, ?)}")) {

			cstmt.setString(1, item.getName());
			cstmt.setInt(2, item.getActive());
			cstmt.execute();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void Update(Category item) {
		try (Connection conn = DBConnection.GetInstance().GetConn();
				SQLServerCallableStatement cstmt = (SQLServerCallableStatement) conn
						.prepareCall("{call update_category(?, ?, ?)}")) {

			cstmt.setInt(1, item.getId());
			cstmt.setString(2, item.getName());
			cstmt.setInt(3, item.getActive());
			cstmt.execute();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean Delete(Category item) {
		try (Connection conn = DBConnection.GetInstance().GetConn();
				SQLServerCallableStatement cstmt = (SQLServerCallableStatement) conn
						.prepareCall("{call delete_category(?)}")) {

			cstmt.setInt(1, item.getId());
			return cstmt.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public Category GetbyID(Object id) {
		if (!(id instanceof Number))
			return null;

		Category category = null;

		try (Connection conn = DBConnection.GetInstance().GetConn();
				SQLServerCallableStatement cstmt = (SQLServerCallableStatement) conn
						.prepareCall("{call get_category_by_id(?)}")) {

			cstmt.setInt(1, ((Number) id).intValue());

			try (ResultSet rs = cstmt.executeQuery()) {
				if (rs.next()) {
					category = new Category();
					category.setId(rs.getInt("c_id"));
					category.setName(rs.getString("c_name"));
					category.setActive(rs.getInt("c_active"));
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return category;
	}

	@Override
	public List<Category> Gets() {
		List<Category> categories = new ArrayList<>();
		// Sử dụng interface chuẩn của JDBC là CallableStatement
		try (Connection conn = DBConnection.GetInstance().GetConn();
				java.sql.CallableStatement cstmt = conn.prepareCall("{call get_categories()}");
				ResultSet rs = cstmt.executeQuery()) {

			while (rs.next()) {
				Category category = new Category();
				// Đảm bảo tên cột "c_id", "c_name" khớp chính xác với SQL
				category.setId(rs.getInt("c_id"));
				category.setName(rs.getString("c_name"));
				category.setActive(rs.getInt("c_active"));
				categories.add(category);
			}
			System.out.println("Query successful, size: " + categories.size());

		} catch (Exception e) {
			System.err.println("LỖI REPOSITORY: " + e.getMessage());
			e.printStackTrace(); // Bắt buộc phải có để hiện lỗi ra console
		}
		return categories;
	}

	@Override
	public List<Category> Search(String key) {
		return new ArrayList<>();
	}
}
