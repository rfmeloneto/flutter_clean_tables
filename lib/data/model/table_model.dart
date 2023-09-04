import 'package:table_app/domain/entities/table_entities.dart';

class TableModel extends TableEntities {
  TableModel(
      {required super.year,
      required super.month,
      required super.position,
      required super.entrancia,
      required super.speciality,
      required super.occupiedPositions,
      required super.vacantPositions,
      required super.totalPositions,
      required super.json});

  static List<TableEntities> fromMapList(dynamic data) {
    List<TableEntities> entities = [];
    for (var item in data['collection']) {
      entities.add(TableModel(
          json: item,
          year: item['year'],
          month: item['month'],
          position: item['position'],
          entrancia: item['entrancia'],
          speciality: item['speciality'],
          occupiedPositions: item['number_of_occupied'],
          vacantPositions: item['number_of_vacancies'],
          totalPositions: item['total_vacancies']));
    }
    return entities;
  }
}
