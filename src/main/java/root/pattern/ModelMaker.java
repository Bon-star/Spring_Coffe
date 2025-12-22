package root.pattern;

import root.models.Category;

public final class ModelMaker {
	private static ModelMaker _instance=null;
	private CategoryRepository cateRep;
	
	private ModelMaker() {
		cateRep=CategoryRepository.Instance();
	}
	
	public static ModelMaker Instance() {
		if (_instance==null) {
			_instance=new ModelMaker();
		}
		return _instance;
	}
	public void CreateCategory(Category item) {
		try {
			cateRep.Create(item);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
}
