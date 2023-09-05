abstract class TableEvents {}

abstract class ChartEvents {}

class LoadingTablesEvent extends TableEvents {
  LoadingTablesEvent();
}

class GetAllTablesEvent extends TableEvents {
  GetAllTablesEvent();
}

class GetAllTablesByYearMonthEvent extends TableEvents {
  final int year;
  final int month;
  GetAllTablesByYearMonthEvent(this.year, this.month);
}

class LoadingChartEvent extends ChartEvents {
  LoadingChartEvent();
}

class ChartEventByYearMonth extends ChartEvents {
  final int year;
  final int month;
  ChartEventByYearMonth(this.year, this.month);
}
