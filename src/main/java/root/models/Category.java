package root.models;

import java.util.ArrayList;
import java.util.List;

public class Category {
	private int id;
	private String name;
	private int rootId;
	private int active;

	private String rootName;

	private List<SubCategory> subCategories = new ArrayList<>();

	public Category() {
	}

	public Category(int id, String name, int rootId, int active) {
		this.id = id;
		this.name = name;
		this.rootId = rootId;
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

	public int getRootId() {
		return rootId;
	}

	public void setRootId(int rootId) {
		this.rootId = rootId;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public String getRootName() {
		return rootName;
	}

	public void setRootName(String rootName) {
		this.rootName = rootName;
	}

	public List<SubCategory> getSubCategories() {
		return subCategories;
	}

	public void setSubCategories(List<SubCategory> subCategories) {
		this.subCategories = subCategories;
	}
}