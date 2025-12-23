package root;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import root.pattern.AdminRepository;
import java.io.IOException;

public class AboutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("topBanner", AdminRepository.Instance().GetTopBanner());
        
        req.setAttribute("bodySections", AdminRepository.Instance().GetAboutBodySections());
        
        req.getRequestDispatcher("/client/about-us.jsp").forward(req, resp);
    }
}