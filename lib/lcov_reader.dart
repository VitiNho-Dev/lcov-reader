import 'dart:io';

class LcovReader {
  String coverage(String filePath) {
    final file = File(filePath);

    final dataOfFile = file.readAsLinesSync();

    final listLineData = getDataOfFile(dataOfFile);

    final totalCoverage = calculateCoverage(listLineData);

    return totalCoverage;
  }

  List<LineData> getDataOfFile(List<String> dataOfFile) {
    var listLineData = <LineData>[];
    var sf = '';
    var lf = 0;
    var lh = 0;

    for (var data in dataOfFile) {
      if (data == 'end_of_record') {
        final lineData = LineData(
          sourceFile: sf,
          lineFound: lf,
          lineHit: lh,
        );

        listLineData.add(lineData);

        continue;
      }

      var text = data.split(':');

      if (text[0] == 'SF') {
        sf = text[1];
      } else if (text[0] == 'LF') {
        lf = int.parse(text[1]);
      } else if (text[0] == 'LH') {
        lh = int.parse(text[1]);
      }
    }

    return listLineData;
  }

  String calculateCoverage(List<LineData> listLineData) {
    var totalLF = 0;
    var totalLH = 0;

    for (var value in listLineData) {
      totalLF = value.lineFound;
      totalLH = value.lineHit;
    }

    final total = (totalLH / totalLF) * 100;

    return '${total.round().toString()}%';
  }
}

class LineData {
  final String sourceFile;
  final int lineFound;
  final int lineHit;

  const LineData({
    required this.sourceFile,
    required this.lineFound,
    required this.lineHit,
  });
}
