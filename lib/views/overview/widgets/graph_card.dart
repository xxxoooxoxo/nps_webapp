import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nps_webapp/controllers/influx_controller_alpha.dart';
import 'package:nps_webapp/controllers/influx_controller_eta.dart';
import 'package:nps_webapp/controllers/influx_controller_gamma.dart';
import 'package:nps_webapp/controllers/influx_controller_theta.dart';
import 'package:nps_webapp/controllers/influx_controller_zeta.dart';
import 'package:nps_webapp/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphCard extends StatelessWidget {
  GraphCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var influxController = Get.find<InfluxControllerEta>();
    return Obx(() => Container(
          child: SfCartesianChart(
            legend: Legend(isVisible: true, position: LegendPosition.left),
            primaryXAxis: DateTimeAxis(
                labelStyle: const TextStyle(color: Colors.black),
                majorGridLines: const MajorGridLines(
                  width: 1,
                  dashArray: [2, 3],
                ),
                autoScrollingMode: AutoScrollingMode.start),
            primaryYAxis: NumericAxis(
              majorGridLines: const MajorGridLines(dashArray: [2, 3]),
              labelStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            trackballBehavior: TrackballBehavior(
              tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
              enable: true,
              activationMode: ActivationMode.singleTap,
              tooltipSettings: const InteractiveTooltip(
                color: Colors.black,
                canShowMarker: false,
                format: 'series.name : point.y',
              ),
            ),
            series: [
              LineSeries<ChartData, DateTime>(
                  color: Colors.blue,
                  name: "Temperature",
                  dataSource: influxController.dataListTemp.value,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),
              LineSeries<ChartData, DateTime>(
                  color: Colors.red,
                  name: "Humidity",
                  dataSource: influxController.dataListHumidty.value,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),
              LineSeries<ChartData, DateTime>(
                  color: Colors.orange,
                  name: "Particlate Matter (2.5)",
                  dataSource: influxController.dataListPM2_5.value,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),
              LineSeries<ChartData, DateTime>(
                  color: Colors.yellow,
                  name: "Particulate Matter (10)",
                  dataSource: influxController.dataListPM10.value,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),
              LineSeries<ChartData, DateTime>(
                  color: Colors.green,
                  name: "Sound",
                  dataSource: influxController.dataListSound.value,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y),
            ],
          ),
          height: 300,
        ));
  }
}
