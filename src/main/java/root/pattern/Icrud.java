package root.pattern;

import java.util.HashSet;

public interface Icrud<T> {
	void Create(T Item);
	void Update(T Item);
	boolean Delete(T item);
	T GetbyID(Object id);
	HashSet<T> Gets();
	HashSet<T> Search(String key);
}