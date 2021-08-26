class ResponseClass<T> {
  bool success = false;
  String message = "";
  T? data;

  ResponseClass({
    required this.success,
    required this.message,
    this.data,
  });
}
