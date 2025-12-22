package root;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import root.models.Category;
import root.pattern.CategoryRepository;
import java.io.IOException;

public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if (req.getPathInfo() != null) path += req.getPathInfo();

        if (path.contains("/add")) {
            req.setAttribute("category", new Category(0, "", 1));
            req.getRequestDispatcher("/admin/category-form.jsp").forward(req, resp);
        } 
        else if (path.contains("/edit")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                req.setAttribute("category", CategoryRepository.Instance().GetbyID(id));
                req.getRequestDispatcher("/admin/category-form.jsp").forward(req, resp);
            } catch (Exception e) { resp.sendRedirect(req.getContextPath() + "/category"); }
        } 
        else if (path.contains("/delete")) {
            // XỬ LÝ XÓA AN TOÀN
            int id = Integer.parseInt(req.getParameter("id"));
            Category c = new Category(); c.setId(id);
            
            // Hàm Delete trong Repo cần trả về boolean (bạn đã làm rồi). 
            // Nếu SQL trả về 0 -> Delete false -> Báo lỗi
            boolean isDeleted = CategoryRepository.Instance().Delete(c);
            
            if (isDeleted) {
                resp.sendRedirect(req.getContextPath() + "/category?msg=deleted");
            } else {
                // Chuyển hướng kèm thông báo lỗi
                resp.sendRedirect(req.getContextPath() + "/category?error=cannot_delete");
            }
        } 
        else if (path.contains("/toggle")) {
            // XỬ LÝ ĐỔI TRẠNG THÁI NHANH
            int id = Integer.parseInt(req.getParameter("id"));
            int currentStatus = Integer.parseInt(req.getParameter("status"));
            int newStatus = (currentStatus == 1) ? 0 : 1; // Đảo ngược trạng thái
            
            Category c = CategoryRepository.Instance().GetbyID(id);
            if (c != null) {
                c.setActive(newStatus);
                CategoryRepository.Instance().Update(c);
            }
            resp.sendRedirect(req.getContextPath() + "/category");
        }
        else {
            // Danh sách
            req.setAttribute("categories", CategoryRepository.Instance().Gets());
            req.getRequestDispatcher("/admin/category.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getRequestURI(); 

        if (path.contains("/save")) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String name = req.getParameter("name").trim();
                
                String activeParam = req.getParameter("active");
                int active = (activeParam != null) ? Integer.parseInt(activeParam) : 1;

                if (name.isEmpty()) {
                    resp.sendRedirect(req.getContextPath() + "/category"); 
                    return;
                }

                Category item = new Category(id, name, active);
                
                if (id == 0) CategoryRepository.Instance().Create(item);
                else CategoryRepository.Instance().Update(item);

                resp.sendRedirect(req.getContextPath() + "/category");
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/category?error=system");
            }
        }
    }
}