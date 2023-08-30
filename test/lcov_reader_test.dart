import 'package:licov_reader/lcov_reader.dart';
import 'package:test/test.dart';

void main() {
  test('It should get the data from the LCOV file and return the percentage',
      () {
    final result = LcovReader().coverage('coverage/lcov.info');

    expect(result, '100%');
  });

  test('The percentage must be calculated', () {
    final result = LcovReader().calculateCoverage([
      LineData(sourceFile: '', lineFound: 18, lineHit: 9),
      LineData(sourceFile: '', lineFound: 10, lineHit: 5),
    ]);

    expect(result, '50%');
  });
}
