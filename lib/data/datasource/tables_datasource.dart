import 'package:dio/dio.dart';
import 'package:table_app/domain/entities/table_entities.dart';

class TableDataSource {
  final Dio _dio = Dio();

  Future<List<TableEntities>> getFromApi(String url) async {
    final response = await _dio.get(url);
    if (response.statusCode == 200) {
      final data = response.data;
      return data;
    } else {
      throw Exception();
    }
  }
}
