package root.pattern;

import java.util.List;

public interface Icrud<T> {
	void Create(T item);
	void Update(T item);
	boolean Delete(T item);
	T GetbyID(Object id);
	List<T> Gets();
	List<T> Search(String key);
}
