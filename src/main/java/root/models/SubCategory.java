package root.models;

import java.util.ArrayList;
import java.util.List;

public class SubCategory {
	private int id;
	private String name;
	private int categoryId;
	private int active;

	private String categoryName;

	private List<Product> products = new ArrayList<>();

	public SubCategory() {
	}

	public SubCategory(int id, String name, int categoryId, int active) {
		this.id = id;
		this.name = name;
		this.categoryId = categoryId;
		this.active = active;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}
}