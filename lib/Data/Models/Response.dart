class ResponseClass<T> {
  bool success = false;
  String message = "";
  T? data;
  T? pagination;

  ResponseClass({
    required this.success,
    required this.message,
    this.data,
    this.pagination
  });
}
