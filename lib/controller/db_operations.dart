
abstract class DbOperation<T>{

  /**
   * CRUD => Create, Read, Update, Delete
   */

  Future<int> create(T object);

  Future<List<T>> read();

  Future<bool> update(T object);

  Future<T?> show(int id);

  Future<bool> delete(int id);


}