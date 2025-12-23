package root.models;

public class PageSection {
	private int id;
	private String sectionCode;
	private String title;
	private String subtitle;
	private String description;
	private String image;

	public PageSection() {
	}

	public PageSection(String sectionCode, String title, String subtitle, String description, String image) {
		this.sectionCode = sectionCode;
		this.title = title;
		this.subtitle = subtitle;
		this.description = description;
		this.image = image;
	}
	

	public String getSectionCode() {
		return sectionCode;
	}

	public void setSectionCode(String sectionCode) {
		this.sectionCode = sectionCode;
	}

	public String getTitle() {
		return title;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
}