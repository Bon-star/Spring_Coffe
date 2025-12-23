package root.pattern;

import root.models.Category;

public final class ModelMaker {
    private static ModelMaker _instance = null;
    
    // Không dùng CategoryRepository nữa, mà dùng AdminRepository
    private AdminRepository adminRep;
    
    private ModelMaker() {
        adminRep = AdminRepository.Instance();
    }
    
    public static ModelMaker Instance() {
        if (_instance == null) {
            _instance = new ModelMaker();
        }
        return _instance;
    }

    public void CreateCategory(Category item) {
        try {
            // Gọi hàm SaveCategory bên AdminRepository (Hàm này xử lý cả thêm mới và sửa)
            adminRep.SaveCategory(item);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}