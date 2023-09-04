import 'package:dio/dio.dart';

class TableDataSource {
  final Dio _dio = Dio();

  Future<dynamic> getFromApi(String url) async {
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      return data;
    } else {
      throw Exception();
    }
  }
}
