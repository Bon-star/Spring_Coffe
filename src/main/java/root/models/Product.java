package root.models;
import java.util.ArrayList;
import java.util.List;

public class Product {
    private int id;
    private String name;
    private String image;
    private int subCategoryId;
    private String subCategoryName;
    private int active;
    
    // DANH SÁCH BIẾN THỂ (SIZE/GIÁ)
    private List<Variant> variants = new ArrayList<>();

    public Product() {
        this.id = 0;
        this.active = 1;
        this.image = "noimage.jpg";
    }

    public Product(int id, String name, String image, int subCategoryId, int active) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.subCategoryId = subCategoryId;
        this.active = active;
    }

    public long getMinPrice() {
        if (variants.isEmpty()) return 0;
        long min = variants.get(0).getPrice();
        for (Variant v : variants) {
            if (v.getPrice() < min) min = v.getPrice();
        }
        return min;
    }

    // Getters Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
    public int getSubCategoryId() { return subCategoryId; }
    public void setSubCategoryId(int subCategoryId) { this.subCategoryId = subCategoryId; }
    public String getSubCategoryName() { return subCategoryName; }
    public void setSubCategoryName(String subCategoryName) { this.subCategoryName = subCategoryName; }
    public int getActive() { return active; }
    public void setActive(int active) { this.active = active; }
    public List<Variant> getVariants() { return variants; }
    public void setVariants(List<Variant> variants) { this.variants = variants; }
}