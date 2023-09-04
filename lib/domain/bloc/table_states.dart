import '../entities/table_entities.dart';

abstract class TableStates {}

class LoadingTablesState extends TableStates {
  LoadingTablesState();
}

class GetAllTablesState extends TableStates {
  List<TableEntities> tables;
  GetAllTablesState(this.tables);
}
