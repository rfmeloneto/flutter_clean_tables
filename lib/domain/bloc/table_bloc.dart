import 'package:bloc/bloc.dart';
import 'package:table_app/domain/bloc/table_events.dart';
import 'package:table_app/domain/bloc/table_states.dart';
import 'package:table_app/domain/use_cases/table_usecade.dart';

class TableBloc extends Bloc<TableEvents, TableStates> {
  final UseCaseGetAll _useCaseGetAll;
  TableBloc(this._useCaseGetAll) : super(LoadingTablesState()) {
    on<GetAllTablesEvent>((event, emit) async {
      final tables = await _useCaseGetAll.useGetAll();
      emit(GetAllTablesState(tables));
    });
    //  on<GetAllTablesByMonthYearEvent>((event, emit) async {
    //    final tables = await GetAllTablesByMonthYearState(_tableRepository
    //        .getAll('https://api.npoint.io/fac5d9952672f587e1c1'));
    //    emit(tables);
    //  });
  }
}
