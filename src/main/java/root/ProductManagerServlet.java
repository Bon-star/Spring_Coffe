package root;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.UUID;
import root.models.*;
import root.pattern.AdminRepository;

public class ProductManagerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("subList", AdminRepository.Instance().GetAllSubCategories());

        String keyword = req.getParameter("keyword");
        if (keyword == null) keyword = "";
        
        String subIdStr = req.getParameter("sid");
        int subId = (subIdStr != null && !subIdStr.isEmpty()) ? Integer.parseInt(subIdStr) : 0;

        String pageStr = req.getParameter("page");
        int pageIndex = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 10;

        List<Product> products = AdminRepository.Instance().GetProductsPaging(pageIndex, pageSize, keyword, subId);
        int totalItems = AdminRepository.Instance().CountProductsPaging(keyword, subId);
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);

        req.setAttribute("products", products);
        req.setAttribute("totalItems", totalItems);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("currentPage", pageIndex);
        req.setAttribute("keyword", keyword);
        req.setAttribute("selSubId", subId);

        req.getRequestDispatcher("/admin/product-manager.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        if (action == null) action = "";

        try {
            if ("save_product".equals(action)) {
                String idStr = req.getParameter("id");
                int id = (idStr == null || idStr.isEmpty()) ? 0 : Integer.parseInt(idStr);

                String img = "noimage.jpg";
                String oldImg = req.getParameter("oldImg");
                Part part = req.getPart("imageFile");

                if (part != null && part.getSize() > 0) {
                    String path = getServletContext().getRealPath("") + File.separator + "images";
                    File dir = new File(path);
                    if (!dir.exists()) dir.mkdir();

                    if (oldImg != null && !oldImg.isEmpty() && !oldImg.equals("noimage.jpg")) {
                        new File(path + File.separator + oldImg).delete();
                    }

                    String submittedName = part.getSubmittedFileName();
                    String ext = submittedName.contains(".") ? submittedName.substring(submittedName.lastIndexOf(".")) : ".jpg";
                    img = UUID.randomUUID().toString() + ext;
                    
                    part.write(path + File.separator + img);
                } else {
                    if (oldImg != null && !oldImg.isEmpty()) img = oldImg;
                }

                Product p = new Product(id, req.getParameter("name"), img, Integer.parseInt(req.getParameter("subCategoryId")), 1);
                AdminRepository.Instance().SaveProduct(p);
            } 
            
            else if ("delete_product".equals(action)) {
                AdminRepository.Instance().DeleteProduct(Integer.parseInt(req.getParameter("id")));
            } 
            
            else if ("add_variant".equals(action)) {
                String pIdStr = req.getParameter("productId");
                
                if (pIdStr != null && !pIdStr.isEmpty()) {
                    int pId = Integer.parseInt(pIdStr);
                    String name = req.getParameter("name");
                    long price = Long.parseLong(req.getParameter("price"));
                    
                    AdminRepository.Instance().CreateVariant(new Variant(0, pId, name, price));
                }
            } 
            
            else if ("delete_variant".equals(action)) {
                AdminRepository.Instance().DeleteVariant(Integer.parseInt(req.getParameter("id")));
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }

        String sid = req.getParameter("sid");
        String page = req.getParameter("page");
        String keyword = req.getParameter("keyword");

        StringBuilder redirectUrl = new StringBuilder("products?");
        
        if (sid != null && !sid.isEmpty() && !sid.equals("0")) {
            redirectUrl.append("sid=").append(sid).append("&");
        }
        
        if (page != null && !page.isEmpty()) {
            redirectUrl.append("page=").append(page).append("&");
        }
        
        if (keyword != null && !keyword.isEmpty()) {
            redirectUrl.append("keyword=").append(URLEncoder.encode(keyword, StandardCharsets.UTF_8));
        }

        resp.sendRedirect(redirectUrl.toString());
    }
}