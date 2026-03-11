import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  int index = 5;

  increment() {
    index++;

    update();
  }

  decrement() {
    update();
  }
}
