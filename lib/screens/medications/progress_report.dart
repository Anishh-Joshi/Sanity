import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sanity/blocs/home/home_bloc.dart';
import 'package:sanity/model/log_model.dart';
import 'package:sanity/widgets/circle_avatar.dart';
import 'package:sanity/widgets/circular_progress.dart';
import 'package:sanity/widgets/filead_header.dart';
import 'package:sanity/widgets/mapper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import '../../blocs/log_bloc/log_bloc_bloc.dart';

class ProgressReport extends StatefulWidget {
  static const String routeName = 'progress';
  const ProgressReport({Key? key}) : super(key: key);
  static Route route(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (context) => const ProgressReport(), settings: settings);
  }

  @override
  State<ProgressReport> createState() => _ProgressReportState();
}

class _ProgressReportState extends State<ProgressReport> {
  int? selectedMonth;
  late List<ProgressData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  List<ProgressData> monthlyLogs = <ProgressData>[];
  void classifiyMonths(List lists) {
    monthlyLogs.clear();
    for (int i = 0; i < lists.length; i++) {
      LogModel log = LogModel.fromJson(lists[i]);
      final String formatted = formatter.format(DateTime.parse(log.createdAt));
      if (int.parse(formatted.split("-")[1]) == selectedMonth) {
        monthlyLogs.add(ProgressData(
            int.parse(log.createdAt.split("-")[2]), log.depressionScore));
      }

      monthlyLogs.sort((a, b) => a.day.compareTo(b.day));
    }
  }

  @override
  void initState() {
    selectedMonth = getSelectedMonth();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  int getSelectedMonth() {
    final DateTime now = DateTime.now();
    final String formatted = formatter.format(now);
    return int.parse(formatted.split("-")[1]);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarInfo(
                    height: height,
                    onPressed: () {},
                    showDone: false,
                    title: "Progress Report"),
                BlocBuilder<LogBlocBloc, LogBlocState>(
                  builder: (context, state) {
                    if (state is LogRetrieved) {
                      return Stack(children: [
                        SfCircularChart(series: <CircularSeries>[
                          RadialBarSeries<AvgData, String>(
                              trackColor: Theme.of(context).cardColor,
                              dataSource: [
                                AvgData(
                                    "Avg",
                                    double.parse(state.avgPattern!
                                            .toStringAsFixed(2)) *
                                        100),
                                AvgData(
                                    "You",
                                    double.parse(state.selfPattern!
                                            .toStringAsFixed(2)) *
                                        100),
                              ],
                              dataLabelSettings:
                                   const DataLabelSettings(
                                    textStyle:TextStyle(fontSize: 10),
                                    isVisible: true,),
                              xValueMapper: (AvgData data, _) => data.x,
                              yValueMapper: (AvgData data, _) => data.y,
                              cornerStyle: CornerStyle.bothCurve)
                        ]),
                        Positioned(
                            top: MediaQuery.of(context).size.height * 0.1260,
                            left: MediaQuery.of(context).size.width * 0.335,
                            child: BlocBuilder<HomeBloc, HomeState>(
                              builder: (context, state) {
                                if (state is HomeLoaded) {
                                  return CircleAvatarCustom(
                                    url: state.user!.profileImgUrl!,
                                    radius: MediaQuery.of(context).size.height *
                                        0.06,
                                  );
                                }
                                return const SizedBox();
                              },
                            ))
                      ]);
                    }
                    return const CircularProgressIndicatorCustom();
                  },
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 161, 229),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    Text(" Your Score",
                        style: Theme.of(context).textTheme.headline4)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 57, 156, 236),
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    Text(" Average Score",
                        style: Theme.of(context).textTheme.headline4)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (selectedMonth != 1) {
                              selectedMonth = selectedMonth! - 1;
                            }
                          });
                        },
                        icon: const Icon(Icons.arrow_back)),
                    Text(
                      mapper[selectedMonth]['month'],
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (selectedMonth != 12) {
                              selectedMonth = selectedMonth! + 1;
                            }
                          });
                        },
                        icon: const Icon(Icons.arrow_forward)),
                  ],
                ),
                BlocBuilder<LogBlocBloc, LogBlocState>(
                    builder: (context, state) {
                  if (state is LogRetrieved) {
                    classifiyMonths(state.log);
                    return Center(
                        child: SfCartesianChart(
                      legend: Legend(isVisible: false),

                      
                      series: <LineSeries>[
                        LineSeries<ProgressData, int>(
                          dataSource: List.from(monthlyLogs.reversed),
                          xValueMapper: (ProgressData data, _) => data.day,
                          yValueMapper: (ProgressData data, _) => data.number*100,
                          yAxisName: "Score",
                          xAxisName: "Days",
                          
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          enableTooltip: false,
                          color: Colors.orange,
                          width: 2,
                          opacity: 1,
                          dashArray: <double>[5, 5],
                        )
                      ],
                      primaryXAxis: NumericAxis(
                        edgeLabelPlacement: EdgeLabelPlacement.shift,
                      ),
                    ));
                  }
                  return const CircularProgressIndicatorCustom();
                }),
                Text("*The lower the better!*",
                        style: Theme.of(context).textTheme.headline6)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProgressData {
  ProgressData(this.day, this.number);
  final int day;
  final double number;
}

class AvgData {
  AvgData(this.x, this.y);
  final String x;
  final double y;
}
