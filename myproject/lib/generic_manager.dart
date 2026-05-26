class GenericManager<T> {
  List<T> items = [];

  // CREATE
  void addItem(T item) {
    items.add(item);
  }

  // READ
  List<T> getAllItems() {
    return items;
  }

  // DELETE
  void deleteItem(bool Function(T) condition) {
    items.removeWhere(condition);
  }
}