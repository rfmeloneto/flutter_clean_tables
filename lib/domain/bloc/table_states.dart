import '../entities/table_entities.dart';

abstract class TableStates {}

abstract class ChartStates {}

class LoadingTablesState extends TableStates {
  LoadingTablesState();
}

class GetAllTablesState extends TableStates {
  List<TableEntities> tables;
  GetAllTablesState(this.tables);
}

class LoadingChartState extends ChartStates {
  LoadingChartState();
}

class GetChartByYearMonth extends ChartStates {
  Map<String, dynamic> map;
  GetChartByYearMonth(this.map);
}
