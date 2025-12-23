package root;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import root.models.PageSection;
import root.pattern.AdminRepository;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
public class ManageAboutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("sections", AdminRepository.Instance().GetAboutSectionsList());
        req.getRequestDispatcher("/admin/about-manager.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("update_section".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String title = req.getParameter("title");
                String subtitle = req.getParameter("subtitle");
                String desc = req.getParameter("description");
                String oldImg = req.getParameter("oldImg");
                String img = oldImg;

                Part part = req.getPart("imageFile");
                if (part != null && part.getSize() > 0) {
                    img = saveImage(part); // Gọi hàm lưu ảnh
                }

                PageSection s = new PageSection();
                s.setId(id);
                s.setTitle(title);
                s.setSubtitle(subtitle);
                s.setDescription(desc);
                s.setImage(img);
                
                AdminRepository.Instance().UpdateSection(s);
            } catch (Exception e) { e.printStackTrace(); }
        }
        
        else if ("create_section".equals(action)) {
            try {
                String title = req.getParameter("title");
                String subtitle = req.getParameter("subtitle");
                String desc = req.getParameter("description");
                String img = "";

                Part part = req.getPart("imageFile");
                if (part != null && part.getSize() > 0) {
                    img = saveImage(part); // Gọi hàm lưu ảnh
                }

                PageSection s = new PageSection();
                s.setTitle(title);
                s.setSubtitle(subtitle);
                s.setDescription(desc);
                s.setImage(img);
                
                AdminRepository.Instance().CreateSection(s);
            } catch (Exception e) { e.printStackTrace(); }
        }

        else if ("delete_section".equals(action)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                AdminRepository.Instance().DeleteSection(id);
            } catch (Exception e) { e.printStackTrace(); }
        }
        
        resp.sendRedirect("about-manager");
    }

    private String saveImage(Part part) throws IOException {
        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File dir = new File(uploadPath);
        if (!dir.exists()) dir.mkdirs();

        String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String ext = fileName.contains(".") ? fileName.substring(fileName.lastIndexOf(".")) : ".jpg";
        String imgName = "about-" + System.currentTimeMillis() + ext;
        
        part.write(uploadPath + File.separator + imgName);
        return imgName;
    }
}