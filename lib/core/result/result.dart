class Result<T> {
  final bool success;
  final String? message;
  final T? data;

  Result({required this.success, required this.message, this.data});

  factory Result.success({required T? data, String? message}) {
    return Result(success: true, message: message, data: data);
  }

  factory Result.failure(String error) {
    return Result(success: false, message: error);
  }
}
