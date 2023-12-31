import 'package:flutter/widgets.dart';

class ListText extends StatelessWidget {
  const ListText({
    super.key,
    required this.bodyHeight,
    required this.mediaQuerywidth,
    required this.text1,
    required this.text2,
  });

  final double bodyHeight;
  final double mediaQuerywidth;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32, top: 14),
      height: bodyHeight * 0.1 / 4,
      width: mediaQuerywidth,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            // color: Colors.red,
            child: Text(
              text1,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9E9E9E),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            // color: Colors.blue,
            child: Text(
              text2,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}