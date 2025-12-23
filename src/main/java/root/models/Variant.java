package root.models;
public class Variant {
    private int id;
    private int productId;
    private String name;
    private long price;
    public Variant() {}
    public Variant(int id, int productId, String name, long price) {
        this.id = id; this.productId = productId; this.name = name; this.price = price;
    }
    // Getters & Setters...
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public int getProductId() { return productId; } public void setProductId(int productId) { this.productId = productId; }
    public String getName() { return name; } public void setName(String name) { this.name = name; }
    public long getPrice() { return price; } public void setPrice(long price) { this.price = price; }
}