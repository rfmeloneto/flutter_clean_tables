import 'package:bloc/bloc.dart';

import '../use_cases/table_usecade.dart';
import 'table_events.dart';
import 'table_states.dart';

class TableBloc extends Bloc<TableEvents, TableStates> {
  final UseCaseGetAll _useCaseGetAll;
  TableBloc(this._useCaseGetAll) : super(LoadingTablesState()) {
    on<GetAllTablesEvent>((event, emit) async {
      final tables = await _useCaseGetAll.useGetAll();
      emit(GetAllTablesState(tables));
    });
    on<GetAllTablesByYearEvent>((event, emit) async {
      final tables = await _useCaseGetAll.useGetAllByYear(
          'https://api.npoint.io/fac5d9952672f587e1c1', event.year);
      emit(GetAllTablesState(tables));
    });
  }
}
