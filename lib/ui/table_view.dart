import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_app/domain/bloc/table_bloc.dart';
import 'package:table_app/domain/use_cases/table_usecade.dart';

import '../data/datasource/tables_datasource.dart';
import '../data/repository/table_repository_implementation.dart';
import '../domain/bloc/table_events.dart';
import '../domain/bloc/table_states.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  late final TableBloc bloc;

  @override
  void initState() {
    bloc = TableBloc(
        UseCaseGetAll(TableRepositoryImplementation(TableDataSource())));
    bloc.add(GetAllTablesEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables'),
      ),
      body: Center(
        child: BlocBuilder<TableBloc, TableStates>(
          bloc: bloc,
          builder: (context, state) {
            if (state is LoadingTablesState) {
              return const CircularProgressIndicator();
            } else if (state is GetAllTablesState) {
              final tables = state.tables;
              return ListView.builder(
                itemCount: tables.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    tables[index].position,
                  ),
                ),
              );
            }
            // Add a default return statement if needed
            return Container();
          },
        ),
      ),
    );
  }
}
