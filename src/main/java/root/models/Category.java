package root.models;

public final class Category {
	private int id=0;
	private String name="";
	private int active=1;
	
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
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}
	
	public Category(int id, String name, int active) {
		super();
		this.id = id;
		this.name = name;
		this.active = active;
	}
	public Category() {
		id = 0;
		name = "untitle";
		active = 1;
	}
}
