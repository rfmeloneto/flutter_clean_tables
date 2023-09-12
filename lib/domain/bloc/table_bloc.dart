import 'package:bloc/bloc.dart';

import '../use_cases/table_usecade.dart';
import 'table_events.dart';
import 'table_states.dart';

class TableBloc extends Bloc<TableEvents, TableStates> {
  final UseCaseGetAll _useCaseGetAll;
  TableBloc(this._useCaseGetAll) : super(LoadingTablesState()) {
    on<GetAllTablesEvent>((event, emit) async {
      final tables = await _useCaseGetAll
          .useGetAll('https://api.npoint.io/fac5d9952672f587e1c1');
      emit(GetAllTablesState(tables));
    });
    on<GetAllTablesByYearMonthEvent>((event, emit) async {
      final tables = await _useCaseGetAll.useGetAllByYear(
          'https://api.npoint.io/fac5d9952672f587e1c1',
          event.year,
          event.month);
      emit(GetAllTablesState(tables));
    });
  }
}

class ChartBloc extends Bloc<ChartEvents, ChartStates> {
  final UseCaseGetAll _useCaseGetAll;
  ChartBloc(this._useCaseGetAll) : super(LoadingChartState()) {
    on<ChartEventByYearMonth>((event, emit) async {
      final map = await _useCaseGetAll.useGetByYearMonthPie(
          'https://api.npoint.io/fac5d9952672f587e1c1',
          event.entrancia,
          event.year,
          event.month);
      emit(GetChartByYearMonth(map));
    });
  }
}
