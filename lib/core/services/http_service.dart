abstract interface class HttpService {
  Future<List<Map<String, dynamic>>> get(
    String url, {
    Duration? timeout,
  });
}
