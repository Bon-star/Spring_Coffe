package root;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig; // QUAN TRỌNG: Để nhận file upload
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import root.models.Product;
import root.pattern.CategoryRepository;
import root.pattern.ProductRepository;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.UUID;

// Cấu hình upload file (Thiếu cái này là lỗi 500 ngay)
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		if (req.getPathInfo() != null)
			path += req.getPathInfo();

		if (path.contains("/add")) {
			req.setAttribute("product", new Product());
			req.setAttribute("categories", CategoryRepository.Instance().Gets());
			req.getRequestDispatcher("/admin/product-form.jsp").forward(req, resp);
		} else if (path.contains("/edit")) {
			int id = Integer.parseInt(req.getParameter("id"));
			req.setAttribute("product", ProductRepository.Instance().GetbyID(id));
			req.setAttribute("categories", CategoryRepository.Instance().Gets());
			req.getRequestDispatcher("/admin/product-form.jsp").forward(req, resp);
		} else if (path.contains("/delete")) {
			int id = Integer.parseInt(req.getParameter("id"));
			Product p = new Product();
			p.setId(id);
			ProductRepository.Instance().Delete(p);
			resp.sendRedirect(req.getContextPath() + "/product");
		} else if (path.contains("/toggle")) {
			int id = Integer.parseInt(req.getParameter("id"));
			int currentStatus = Integer.parseInt(req.getParameter("status"));
			Product p = ProductRepository.Instance().GetbyID(id);
			if (p != null) {
				p.setActive(currentStatus == 1 ? 0 : 1);
				ProductRepository.Instance().Update(p);
			}
			resp.sendRedirect(req.getContextPath() + "/product");
		} else {
			req.setAttribute("products", ProductRepository.Instance().Gets());
			req.getRequestDispatcher("/admin/product.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		if (req.getRequestURI().contains("save")) {
			try {
				// 1. Lấy thông tin cơ bản
				int id = Integer.parseInt(req.getParameter("id"));
				String name = req.getParameter("name");
				long price = Long.parseLong(req.getParameter("price"));
				int categoryId = Integer.parseInt(req.getParameter("categoryId"));
				String activeStr = req.getParameter("active");
				int active = (activeStr != null) ? Integer.parseInt(activeStr) : 1;

				// 2. XỬ LÝ ẢNH
				String imageName = "noimage.jpg"; // Mặc định
				String oldImage = req.getParameter("currentImage"); // Tên ảnh cũ gửi từ form

				// Đường dẫn tới thư mục /webapp/images
				String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
				File uploadDir = new File(uploadPath);
				if (!uploadDir.exists())
					uploadDir.mkdir();

				Part filePart = req.getPart("imageFile");

				// Kiểm tra xem người dùng có chọn file không (kích thước > 0)
				if (filePart != null && filePart.getSize() > 0) {

					// --- A. XÓA ẢNH CŨ (Nếu có và không phải là ảnh mặc định) ---
					if (oldImage != null && !oldImage.isEmpty() && !oldImage.equals("noimage.jpg")) {
						File oldFile = new File(uploadPath + File.separator + oldImage);
						if (oldFile.exists()) {
							oldFile.delete(); // Xóa file cũ đi cho đỡ rác
						}
					}

					// --- B. TẠO TÊN FILE MỚI (UUID) ---
					String submittedFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
					// Lấy đuôi file (ví dụ: .jpg, .png)
					String extension = "";
					int i = submittedFileName.lastIndexOf('.');
					if (i > 0) {
						extension = submittedFileName.substring(i);
					}

					// Tạo tên ngẫu nhiên: 550e8400-e29b... .jpg
					String newFileName = UUID.randomUUID().toString() + extension;

					// --- C. LƯU FILE MỚI ---
					filePart.write(uploadPath + File.separator + newFileName);

					// Gán tên mới để lưu vào DB
					imageName = newFileName;
				} else {
					// Nếu không chọn ảnh mới -> Giữ ảnh cũ
					if (oldImage != null && !oldImage.isEmpty()) {
						imageName = oldImage;
					}
				}

				// 3. Lưu vào DB
				Product p = new Product(id, name, price, imageName, active, categoryId);

				if (id == 0)
					ProductRepository.Instance().Create(p);
				else
					ProductRepository.Instance().Update(p);

				resp.sendRedirect(req.getContextPath() + "/product");

			} catch (Exception e) {
				e.printStackTrace();
				resp.sendRedirect(req.getContextPath() + "/product?error=save_failed");
			}
		}
	}
}