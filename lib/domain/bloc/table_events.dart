abstract class TableEvents {}

class LoadingTablesEvent extends TableEvents {
  LoadingTablesEvent();
}

class GetAllTablesEvent extends TableEvents {
  GetAllTablesEvent();
}

class GetAllTablesByMonthYearEvent extends TableEvents {
  final int month;
  final int year;
  GetAllTablesByMonthYearEvent(this.month, this.year);
}
