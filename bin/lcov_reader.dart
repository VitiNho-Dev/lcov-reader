import 'package:licov_reader/lcov_reader.dart';

void main(List<String> arguments) {
  final coverage = LcovReader().coverage('coverage/lcov.info');

  print('Coverage: $coverage');
}
