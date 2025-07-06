import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/database/glucose_measurements/glucose_measurements.dart';
import 'package:intl/intl.dart';

class GlucoseLineChart extends StatelessWidget {
  final List<GlucoseMeasurements> measurements;

  const GlucoseLineChart({Key? key, required this.measurements})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(Duration(days: 7));
    final filteredMeasurements =
        measurements.where((m) => m.created_at.isAfter(sevenDaysAgo)).toList();

    Map<String, List<double>> dailyAverages = {};
    for (var measurement in filteredMeasurements) {
      final day = DateFormat(
        'EEEE',
      ).format(measurement.created_at); // اسم اليوم
      dailyAverages.putIfAbsent(day, () => []).add(measurement.glucose);
    }

    const daysOrder = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];
    List<FlSpot> spots = [];
    for (int i = 0; i < daysOrder.length; i++) {
      final day = daysOrder[i];
      final values = dailyAverages[day] ?? [];
      final average =
          values.isNotEmpty
              ? values.reduce((a, b) => a + b) / values.length
              : 0.0;
      spots.add(FlSpot(i.toDouble(), average));
    }

    final maxGlucose =
        filteredMeasurements.isNotEmpty
            ? filteredMeasurements
                .map((m) => m.glucose)
                .reduce((a, b) => a > b ? a : b)
            : 100.0;
    final minGlucose =
        filteredMeasurements.isNotEmpty
            ? filteredMeasurements
                .map((m) => m.glucose)
                .reduce((a, b) => a < b ? a : b)
            : 0.0;

    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: (maxGlucose - minGlucose) / 5,
            verticalInterval: 1,
            getDrawingHorizontalLine:
                (value) =>
                    FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
            getDrawingVerticalLine:
                (value) =>
                    FlLine(color: Colors.grey.withOpacity(0.2), strokeWidth: 1),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: (maxGlucose - minGlucose) / 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final dayIndex = value.toInt();
                  if (dayIndex >= 0 && dayIndex < daysOrder.length) {
                    return Text(
                      daysOrder[dayIndex].substring(0, 3), // اختصار اسم اليوم
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    );
                  }
                  return Text('');
                },
              ),
            ),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.grey.withOpacity(0.3)),
          ),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: (maxGlucose + 20).clamp(
            0,
            300,
          ), 
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.cyanAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter:
                    (spot, percent, bar, index) => FlDotCirclePainter(
                      radius: 4,
                      color: Colors.blueAccent,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    ),
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.3),
                    Colors.cyanAccent.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  final day = daysOrder[spot.x.toInt()];
                  return LineTooltipItem(
                    '$day\n${spot.y.toStringAsFixed(1)} mg/dL',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
