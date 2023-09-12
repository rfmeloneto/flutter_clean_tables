import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_app/ui/mp_bar_chart.dart';
import 'package:table_app/ui/mp_pie_chart.dart';

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
  String entrancia = 'todas';

  @override
  void initState() {
    bloc = TableBloc(
        UseCaseGetAll(TableRepositoryImplementation(TableDataSource())));
    chartbloc = ChartBloc(
        UseCaseGetAll(TableRepositoryImplementation(TableDataSource())));
    bloc.add(GetAllTablesByYearMonthEvent(selectedYear, selectedMonth));
    chartbloc
        .add(ChartEventByYearMonth(entrancia, selectedYear, selectedMonth));
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
                      color: Colors.blue,
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
                          child: DropdownButton(
                              value: entrancia,
                              items: const [
                                DropdownMenuItem(
                                  value: null,
                                  child: Text('Selecione uma Entrância'),
                                ),
                                DropdownMenuItem(
                                    value: "todas", child: Text('Todas')),
                                DropdownMenuItem(
                                    value: "Primeira Entrância",
                                    child: Text('Primeira Entrância')),
                                DropdownMenuItem(
                                    value: "Segunda Entrância",
                                    child: Text('Segunda Entrância')),
                                DropdownMenuItem(
                                    value: "Terceira Entrância",
                                    child: Text('Terceira Entrância')),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  entrancia = value!;
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
                                    entrancia, selectedYear, selectedMonth));
                              },
                              child: const Text('Pesquisar')),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  BlocBuilder<ChartBloc, ChartStates>(
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
                        return Padding(
                          padding: const EdgeInsets.only(left: 100, right: 100),
                          child: Expanded(
                            child: SizedBox(
                              height: 300,
                              child: Row(
                                children: [
                                  Card(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 32.0),
                                          child: Row(
                                            children: [
                                              Text(map['vagas'].toString()),
                                              vertDivader,
                                              Text(map['ocupadas'].toString()),
                                              vertDivader,
                                              Text(map['saldo'].toString()),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: PieChartTeste(map)),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 300,
                                      child: Card(
                                        child: BarChartSample1(map),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }

                      return Container();
                    },
                  ),
                  if (tables.isNotEmpty)
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 100, right: 100),
                        child: Card(
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 50, right: 50),
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
