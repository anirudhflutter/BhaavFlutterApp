import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'Screens/priceDetailScreen.dart';

class FarmerChart extends StatelessWidget {
  final List<FarmersMlDataGraph> data1;
  final List<FarmersMlDataGraph> data2;

  FarmerChart({this.data1,this.data2});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<FarmersMlDataGraph, String>> series = [
      charts.Series(
          id: "Subscribers",
          displayName: "Lower",
          data: data1,
          domainFn: (FarmersMlDataGraph series, _) => series.Date,
          measureFn: (FarmersMlDataGraph series, _) => double.parse(series.LowerPrice),
          colorFn: (FarmersMlDataGraph series, _) => series.barColor),
      charts.Series(
          id: "Subscribers",
          data: data2,
          displayName: "Upper",
          domainFn: (FarmersMlDataGraph series, _) => series.Date,
          measureFn: (FarmersMlDataGraph series, _) => double.parse(series.UpperPrice),
          colorFn: (FarmersMlDataGraph series, _) => series.barColor)
    ];
    return charts.BarChart(
      series,
      animate: true,
    );
  }
}
