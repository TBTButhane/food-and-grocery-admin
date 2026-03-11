import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  //dynamic height padding and margin
  static double height10 = screenHeight / 84.4;
  static double height15 = screenHeight / 56.27;
  static double height20 = screenHeight / 42.2;
  static double height30 = screenHeight / 28.13;
  static double height45 = screenHeight / 18.76;

  //dynamic width padding and margin
  static double width10 = screenWidth / 184.4;
  static double width15 = screenWidth / 56.4;
  static double width20 = screenWidth / 42.2;
  static double width30 = screenWidth / 28.13;

  //font size
  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.46;
}
