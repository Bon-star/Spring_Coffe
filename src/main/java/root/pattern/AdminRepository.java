package root.pattern;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import root.models.*;
import root.mappers.*;

public class AdminRepository {
    private static AdminRepository instance = null;

    private AdminRepository() {
    }

    public static AdminRepository Instance() {
        if (instance == null)
            instance = new AdminRepository();
        return instance;
    }

    public List<Root> GetRoots() {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_roots_admin()}");
             ResultSet rs = cs.executeQuery()) {
            return new RootMapper().RowsMap(rs);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Root GetRootById(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_root_by_id(?)}")) {
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();
            if (rs.next())
                return new RootMapper().RowMap(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void SaveRoot(Root r) {
        String sql = (r.getId() == 0) ? "{call create_root(?,?)}" : "{call update_root(?,?,?)}";
        try (Connection conn = DBConnection.GetInstance().GetConn(); 
             CallableStatement cs = conn.prepareCall(sql)) {
            if (r.getId() != 0) {
                cs.setInt(1, r.getId());
                cs.setString(2, r.getName());
                cs.setInt(3, r.getActive());
            } else {
                cs.setString(1, r.getName());
                cs.setInt(2, r.getActive());
            }
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void DeleteRoot(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call delete_root(?)}")) {
            cs.setInt(1, id);
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Category> GetCategoriesByRoot(int rootId) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_categories_by_root(?)}")) {
            cs.setInt(1, rootId);
            ResultSet rs = cs.executeQuery();
            return new CategoryMapper().RowsMap(rs);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Category GetCategoryById(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_category_by_id(?)}")) {
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();
            if (rs.next())
                return new CategoryMapper().RowMap(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void SaveCategory(Category c) {
        String sql = (c.getId() == 0) ? "{call create_category(?,?,?)}" : "{call update_category(?,?,?,?)}";
        try (Connection conn = DBConnection.GetInstance().GetConn(); 
             CallableStatement cs = conn.prepareCall(sql)) {
            if (c.getId() != 0) {
                cs.setInt(1, c.getId());
                cs.setString(2, c.getName());
                cs.setInt(3, c.getRootId());
                cs.setInt(4, c.getActive());
            } else {
                cs.setString(1, c.getName());
                cs.setInt(2, c.getRootId());
                cs.setInt(3, c.getActive());
            }
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void DeleteCategory(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call delete_category(?)}")) {
            cs.setInt(1, id);
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<SubCategory> GetSubByCat(int catId) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_subcategories_by_cat(?)}")) {
            cs.setInt(1, catId);
            ResultSet rs = cs.executeQuery();
            return new SubCategoryMapper().RowsMap(rs);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public SubCategory GetSubById(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_subcategory_by_id(?)}")) {
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();
            if (rs.next())
                return new SubCategoryMapper().RowMap(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void SaveSubCategory(SubCategory s) {
        String sql = (s.getId() == 0) ? "{call create_subcategory(?,?,?)}" : "{call update_subcategory(?,?,?,?)}";
        try (Connection conn = DBConnection.GetInstance().GetConn(); 
             CallableStatement cs = conn.prepareCall(sql)) {
            if (s.getId() != 0) {
                cs.setInt(1, s.getId());
                cs.setString(2, s.getName());
                cs.setInt(3, s.getCategoryId());
                cs.setInt(4, s.getActive());
            } else {
                cs.setString(1, s.getName());
                cs.setInt(2, s.getCategoryId());
                cs.setInt(3, s.getActive());
            }
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void DeleteSubCategory(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call delete_subcategory(?)}")) {
            cs.setInt(1, id);
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<SubCategory> GetAllSubCategories() {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall(
                "SELECT s.*, c.name as category_name FROM CH_SubCategory s JOIN CH_Category c ON s.category_id = c.id");
             ResultSet rs = cs.executeQuery()) {
            return new SubCategoryMapper().RowsMap(rs);
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    public List<Product> GetProductsBySub(int subId) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_products_by_sub(?)}")) {
            cs.setInt(1, subId);
            ResultSet rs = cs.executeQuery();
            List<Product> list = new ProductMapper().RowsMap(rs);
            for (Product p : list)
                p.setVariants(GetVariants(p.getId()));
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Product GetProductById(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_product_by_id(?)}")) {
            cs.setInt(1, id);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                Product p = new ProductMapper().RowMap(rs);
                p.setVariants(GetVariants(id));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void SaveProduct(Product p) {
        String sql = (p.getId() == 0) ? "{call create_product(?,?,?,?)}" : "{call update_product(?,?,?,?,?)}";
        try (Connection conn = DBConnection.GetInstance().GetConn(); 
             CallableStatement cs = conn.prepareCall(sql)) {
            if (p.getId() != 0) {
                cs.setInt(1, p.getId());
                cs.setString(2, p.getName());
                cs.setString(3, p.getImage());
                cs.setInt(4, p.getSubCategoryId());
                cs.setInt(5, p.getActive());
            } else {
                cs.setString(1, p.getName());
                cs.setString(2, p.getImage());
                cs.setInt(3, p.getSubCategoryId());
                cs.setInt(4, p.getActive());
            }
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void DeleteProduct(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call delete_product(?)}")) {
            cs.setInt(1, id);
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Product> GetAllProducts() {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("SELECT * FROM CH_Product ORDER BY id DESC");
             ResultSet rs = cs.executeQuery()) {
            List<Product> list = new ProductMapper().RowsMap(rs);
            for (Product p : list)
                p.setVariants(GetVariants(p.getId()));
            return list;
        } catch (Exception e) {
            return new ArrayList<>();
        }
    }

    public List<Variant> GetVariants(int prodId) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_variants_by_prod(?)}")) {
            cs.setInt(1, prodId);
            ResultSet rs = cs.executeQuery();
            return new VariantMapper().RowsMap(rs);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public void CreateVariant(Variant v) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call create_variant(?,?,?)}")) {
            cs.setInt(1, v.getProductId());
            cs.setString(2, v.getName());
            cs.setLong(3, v.getPrice());
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void DeleteVariant(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call delete_variant(?)}")) {
            cs.setInt(1, id);
            cs.execute();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public List<Category> GetClientCategories() {
        List<Category> list = new ArrayList<>();
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM CH_Category WHERE active = 1")) {
            ResultSet rs = ps.executeQuery();
            list = new CategoryMapper().RowsMap(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Product> GetClientProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, c.name as cat_name FROM CH_Product p " +
                     "JOIN CH_SubCategory s ON p.subcategory_id = s.id " +
                     "JOIN CH_Category c ON s.category_id = c.id " +
                     "WHERE p.active = 1 ORDER BY p.id DESC";
        
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while(rs.next()) {
                Product p = new ProductMapper().RowMap(rs);
                try { p.setCategoryName(rs.getString("cat_name")); } catch(Exception e) {}
                
                List<Variant> vars = GetVariants(p.getId());
                if (!vars.isEmpty()) {
                    long min = vars.get(0).getPrice();
                    for (Variant v : vars) if (v.getPrice() < min) min = v.getPrice();
                    p.setPrice(min);
                }
                list.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Product> GetProductsPaging(int pageIndex, int pageSize, String keyword, int subId) {
        List<Product> list = new ArrayList<>();
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call get_products_paging(?,?,?,?)}")) {
            cs.setInt(1, pageIndex);
            cs.setInt(2, pageSize);
            cs.setString(3, keyword);
            cs.setInt(4, subId);
            ResultSet rs = cs.executeQuery();
            list = new ProductMapper().RowsMap(rs);
            for (Product p : list) p.setVariants(GetVariants(p.getId()));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public int CountProductsPaging(String keyword, int subId) {
        int count = 0;
        try (Connection conn = DBConnection.GetInstance().GetConn();
             CallableStatement cs = conn.prepareCall("{call count_products_paging(?,?)}")) {
            cs.setString(1, keyword);
            cs.setInt(2, subId);
            ResultSet rs = cs.executeQuery();
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }

    public List<Root> GetFullMenuForClient() {
        List<Root> roots = new ArrayList<>();
        try {
            roots = GetRoots();
            for (Root r : roots) {
                List<Category> cats = GetCategoriesByRoot(r.getId());
                r.setCategories(cats);
                for (Category c : cats) {
                    List<SubCategory> subs = GetSubByCat(c.getId());
                    c.setSubCategories(subs);
                    for (SubCategory s : subs) {
                        List<Product> prods = GetProductsBySub(s.getId());
                        s.setProducts(prods);
                        for (Product p : prods) {
                            List<Variant> vars = GetVariants(p.getId());
                            if (!vars.isEmpty()) {
                                long min = vars.get(0).getPrice();
                                for (Variant v : vars) {
                                    if (v.getPrice() < min) min = v.getPrice();
                                }
                                p.setMinPrice(min);
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return roots;
    }

    public List<Category> GetHomeData() {
        List<Category> cats = new ArrayList<>();
        try {
            cats = GetClientCategories();
            
            for (Category c : cats) {
                List<SubCategory> subs = GetSubByCat(c.getId());
                c.setSubCategories(subs);
                
                for (SubCategory s : subs) {
                    List<Product> prods = GetProductsBySub(s.getId());
                    s.setProducts(prods);
                    
                    for (Product p : prods) {
                        List<Variant> vars = GetVariants(p.getId());
                        if (!vars.isEmpty()) {
                            long min = vars.get(0).getPrice();
                            for (Variant v : vars) if (v.getPrice() < min) min = v.getPrice();
                            p.setMinPrice(min);
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cats;
    }

    public Map<String, PageSection> GetAboutSections() {
        Map<String, PageSection> map = new HashMap<>();
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM CH_PageSection WHERE page_code = 'ABOUT_US' AND active = 1")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PageSection s = new PageSection(
                    rs.getString("section_code"),
                    rs.getString("title"),
                    rs.getString("subtitle"),
                    rs.getString("description"),
                    rs.getString("image")
                );
                map.put(s.getSectionCode(), s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    public List<PageSection> GetAboutSectionsList() {
        List<PageSection> list = new ArrayList<>();
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM CH_PageSection WHERE page_code = 'ABOUT_US'")) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PageSection s = new PageSection(
                    rs.getString("section_code"),
                    rs.getString("title"),
                    rs.getString("subtitle"),
                    rs.getString("description"),
                    rs.getString("image")
                );
                s.setId(rs.getInt("id"));
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public PageSection GetSectionById(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM CH_PageSection WHERE id = ?")) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PageSection s = new PageSection(
                    rs.getString("section_code"),
                    rs.getString("title"),
                    rs.getString("subtitle"),
                    rs.getString("description"),
                    rs.getString("image")
                );
                s.setId(rs.getInt("id"));
                return s;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }


    public void UpdateSection(PageSection s) {
        // Lưu ý: Dùng Ntext hoặc Nvarchar(max) trong SQL để lưu HTML dài
        String sql = "UPDATE CH_PageSection SET title=?, subtitle=?, description=?, image=? WHERE id=?";
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, s.getTitle());
            ps.setString(2, s.getSubtitle());
            ps.setString(3, s.getDescription()); // Lưu HTML từ CKEditor
            ps.setString(4, s.getImage());
            ps.setInt(5, s.getId());
            
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void CreateSection(PageSection s) {
        String sql = "INSERT INTO CH_PageSection (page_code, section_code, title, subtitle, description, image, active) VALUES ('ABOUT_US', ?, ?, ?, ?, ?, 1)";
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "SECTION_" + System.currentTimeMillis()); // Mã tự sinh
            ps.setString(2, s.getTitle());
            ps.setString(3, s.getSubtitle());
            ps.setString(4, s.getDescription());
            ps.setString(5, s.getImage());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void DeleteSection(int id) {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement("DELETE FROM CH_PageSection WHERE id = ?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<PageSection> GetAboutBodySections() {
        List<PageSection> list = new ArrayList<>();
        String sql = "SELECT * FROM CH_PageSection WHERE page_code = 'ABOUT_US' AND section_code != 'TOP_BANNER' AND active = 1 ORDER BY id ASC";
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PageSection s = new PageSection(
                    rs.getString("section_code"),
                    rs.getString("title"),
                    rs.getString("subtitle"),
                    rs.getString("description"),
                    rs.getString("image")
                );
                list.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public PageSection GetTopBanner() {
        try (Connection conn = DBConnection.GetInstance().GetConn();
             java.sql.PreparedStatement ps = conn.prepareStatement("SELECT * FROM CH_PageSection WHERE section_code = 'TOP_BANNER'")) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new PageSection(
                    rs.getString("section_code"),
                    rs.getString("title"),
                    rs.getString("subtitle"),
                    rs.getString("description"),
                    rs.getString("image")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}