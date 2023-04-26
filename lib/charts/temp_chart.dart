import 'dart:math';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TempChartPage extends StatefulWidget {
  final List tempData;

  TempChartPage({required this.tempData});

  @override
  _TempChartPageState createState() => _TempChartPageState();
}

class _TempChartPageState extends State<TempChartPage> {
  List<charts.Series<double, DateTime>> _seriesData = [];

  @override
  void initState() {
    super.initState();
    // _updateSeriesData();
    _seriesData.add(
      charts.Series<double, DateTime>(
        id: 'Temp',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (value, index) => DateTime.now()
            .subtract(Duration(seconds: widget.tempData.length - index! - 1)),
        measureFn: (value, _) => value,
        data: widget.tempData.map((value) => value as double).toList(),
      ),
    );
  }

  void _onSelectionChanged(charts.SelectionModel model) {
    final selectedDatum = model.selectedDatum;

    if (selectedDatum.isNotEmpty) {
      print(selectedDatum.first.datum);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Temperature Chart'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_seriesData.isNotEmpty)
                  SizedBox(
                      height: 300,
                      child: Expanded(
                        child: charts.TimeSeriesChart(
                          _seriesData,
                          animate: true,
                          selectionModels: [
                            charts.SelectionModelConfig(
                              type: charts.SelectionModelType.info,
                              changedListener: _onSelectionChanged,
                            )
                          ],
                          dateTimeFactory: const charts.LocalDateTimeFactory(),
                          primaryMeasureAxis: charts.NumericAxisSpec(
                            viewport: charts.NumericExtents(
                                widget.tempData
                                        .reduce((a, b) => a < b ? a : b) -
                                    5,
                                widget.tempData
                                        .reduce((a, b) => a > b ? a : b) +
                                    5),
                            tickFormatterSpec:
                                charts.BasicNumericTickFormatterSpec(
                                    (value) => '${value!.toInt()} °C'),
                          ),
                        ),
                      )),
              ],
            ),
          ),
        ));
  }
}
