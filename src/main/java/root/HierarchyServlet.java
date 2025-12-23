package root;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import root.models.*;
import root.pattern.AdminRepository;

public class HierarchyServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Luôn load cột 1 (Root)
        req.setAttribute("roots", AdminRepository.Instance().GetRoots());

        // Nếu chọn Root -> Load cột 2 (Category)
        String rId = req.getParameter("rootId");
        if(rId != null && !rId.isEmpty()) {
            int id = Integer.parseInt(rId);
            req.setAttribute("categories", AdminRepository.Instance().GetCategoriesByRoot(id));
            req.setAttribute("selRootId", id);
            
            // Nếu chọn Category -> Load cột 3 (SubCategory)
            String cId = req.getParameter("catId");
            if(cId != null && !cId.isEmpty()) {
                int id2 = Integer.parseInt(cId);
                req.setAttribute("subcategories", AdminRepository.Instance().GetSubByCat(id2));
                req.setAttribute("selCatId", id2);
            }
        }
        req.getRequestDispatcher("/admin/hierarchy.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        String rId = req.getParameter("rootId"); // Để redirect về đúng chỗ cũ
        String cId = req.getParameter("catId");
        
        try {
            if("save_root".equals(action)) {
                AdminRepository.Instance().SaveRoot(new Root(Integer.parseInt(req.getParameter("id")), req.getParameter("name"), 1));
            } else if("delete_root".equals(action)) {
                AdminRepository.Instance().DeleteRoot(Integer.parseInt(req.getParameter("id")));
                rId = null; cId = null; // Xóa root thì reset hết
            } else if("save_cat".equals(action)) {
                AdminRepository.Instance().SaveCategory(new Category(Integer.parseInt(req.getParameter("id")), req.getParameter("name"), Integer.parseInt(req.getParameter("rootIdInput")), 1));
            } else if("delete_cat".equals(action)) {
                AdminRepository.Instance().DeleteCategory(Integer.parseInt(req.getParameter("id")));
                cId = null; // Xóa cat thì reset sub
            } else if("save_sub".equals(action)) {
                AdminRepository.Instance().SaveSubCategory(new SubCategory(Integer.parseInt(req.getParameter("id")), req.getParameter("name"), Integer.parseInt(req.getParameter("catIdInput")), 1));
            } else if("delete_sub".equals(action)) {
                AdminRepository.Instance().DeleteSubCategory(Integer.parseInt(req.getParameter("id")));
            }
        } catch(Exception e) { e.printStackTrace(); }
        
        String url = "hierarchy";
        if(rId != null) url += "?rootId=" + rId;
        if(cId != null) url += "&catId=" + cId;
        resp.sendRedirect(url);
    }
}