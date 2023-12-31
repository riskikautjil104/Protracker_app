import 'package:flutter/material.dart';

class CardTarget extends StatelessWidget {
  final String week;
  final String label;
  final String date;
  final String progress;

  const CardTarget({
    Key? key,
    required this.week,
    required this.label,
    required this.date,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      color: Color(0XFFD6D6D6),
      child: SizedBox(
        height: 100,
        width: 344,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.centerLeft,
                      clipBehavior: Clip.antiAlias,
                      child: Text(
                        "Week " + week,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0XFF737373),
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      progress,
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0XFF000000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0XFFB1B1B1),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
