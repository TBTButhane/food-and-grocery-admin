import 'package:uuid/uuid.dart';

String generatedId() {
  return const Uuid().v1();
}
