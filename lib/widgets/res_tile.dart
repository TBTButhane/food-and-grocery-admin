import 'package:flutter/material.dart';
import 'package:shop4you_admin/widgets/big_text.dart';
import 'package:shop4you_admin/widgets/dimentions.dart';

class ResTile extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Widget kwidget;
  const ResTile(
      {Key? key,
      required this.text,
      required this.imageUrl,
      required this.kwidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 5),
      padding: const EdgeInsets.all(0),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.green),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(width: 120, height: 100, image: NetworkImage(imageUrl)),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: BigText(
              text: text,
              fontColor: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            width: Dimensions.width30 * 2,
          ),
          kwidget,
        ],
      ),
    );
  }
}
