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
      required super.totalPositions});

  static List<TableEntities> fromMapList(dynamic data) {
    List<TableEntities> entities = [];
    for (var item in data) {
      entities.add(TableModel(
          year: item['collection']['year'],
          month: item['collection']['month'],
          position: item['collection']['position'],
          entrancia: item['collection']['entrancia'],
          speciality: item['collection']['speciality'],
          occupiedPositions: item['collection']['number_of_occupied'],
          vacantPositions: item['collection']['number_of_vacancies'],
          totalPositions: item['collection']['total_vacancies']));
    }
    return entities;
  }
}
