import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/datasource/tables_datasource.dart';
import '../data/repository/table_repository_implementation.dart';
import '../domain/bloc/table_bloc.dart';
import '../domain/bloc/table_events.dart';
import '../domain/bloc/table_states.dart';
import '../domain/use_cases/table_usecade.dart';
import 'mp_table_widget.dart';

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
              return Column(
                children: [
                  if (tables.isNotEmpty)
                    Expanded(
                      flex: 2,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.infinity,
                            child: MpTableWidget(
                              header: tables.first.json.keys.toList(),
                              body: tables.map((e) => e.json).toList(),
                              onTap: (int index) {
                                print('Tapped index: $index');
                                // final item = chartData.elementAt(index);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
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
