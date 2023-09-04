abstract class TableEvents {}

class LoadingTablesEvent extends TableEvents {
  LoadingTablesEvent();
}

class GetAllTablesEvent extends TableEvents {
  GetAllTablesEvent();
}

class GetAllTablesByYearEvent extends TableEvents {
  final int year;
  GetAllTablesByYearEvent(this.year);
}
