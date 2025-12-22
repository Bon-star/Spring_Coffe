package root;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import root.pattern.CategoryRepository;
import root.pattern.ProductRepository;
import java.io.IOException;

public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Lấy danh sách Category (để hiển thị Menu bên trái hoặc trên cùng)
        req.setAttribute("categories", CategoryRepository.Instance().Gets());

        // 2. Lấy danh sách Product (để hiển thị lưới sản phẩm ở giữa)
        // Hiện tại lấy tất cả, sau này có thể làm phân trang hoặc "Sản phẩm mới nhất"
        req.setAttribute("products", ProductRepository.Instance().Gets());

        // 3. Chuyển hướng về trang chủ của khách (trong thư mục client mới)
        req.getRequestDispatcher("/client/index.jsp").forward(req, resp);
    }
}