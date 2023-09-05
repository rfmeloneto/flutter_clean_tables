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
  late final ChartBloc chartbloc;
  int selectedYear = 2023;
  int selectedMonth = 1;

  @override
  void initState() {
    bloc = TableBloc(
        UseCaseGetAll(TableRepositoryImplementation(TableDataSource())));
    chartbloc = ChartBloc(
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
                  const SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Saldo de Vagas',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                              value: selectedYear,
                              items: const [
                                DropdownMenuItem(
                                  value: null,
                                  child: Text('Selecione um Ano'),
                                ),
                                DropdownMenuItem(
                                    value: 2023, child: Text('2023')),
                                DropdownMenuItem(
                                    value: 2022, child: Text('2022')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value!;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                              value: selectedMonth,
                              items: const [
                                DropdownMenuItem(
                                  value: null,
                                  child: Text('Selecione um Mês'),
                                ),
                                DropdownMenuItem(value: 1, child: Text('1')),
                                DropdownMenuItem(value: 3, child: Text('3')),
                                DropdownMenuItem(value: 6, child: Text('6')),
                                DropdownMenuItem(value: 8, child: Text('8')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedMonth = value!;
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                bloc.add(GetAllTablesByYearMonthEvent(
                                    selectedYear, selectedMonth));
                                chartbloc.add(ChartEventByYearMonth(
                                    selectedYear, selectedMonth));
                              },
                              child: const Text('Pesquisar')),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Card(
                    child: BlocBuilder<ChartBloc, ChartStates>(
                      bloc: chartbloc,
                      builder: (context, state) {
                        final vertDivader = Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.black,
                            width: 1,
                            height: 20,
                          ),
                        );
                        if (state is LoadingChartState) {
                          return const CircularProgressIndicator();
                        } else if (state is GetChartByYearMonth) {
                          final map = state.map;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(map['vagas'].toString()),
                              vertDivader,
                              Text(map['ocupadas'].toString()),
                              vertDivader,
                              Text(map['total'].toString()),
                            ],
                          );
                        }

                        return Container();
                      },
                    ),
                  ),
                  if (tables.isNotEmpty)
                    Expanded(
                      flex: 2,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
