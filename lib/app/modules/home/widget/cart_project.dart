import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CartProject extends StatelessWidget {
  final String namaProject;
  final String date;
  final String progress;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback? onTap;
  final double? percent;
  final VoidCallback? leadingIconOnPressed;
  final VoidCallback? tarilingIconOnPressed;

  const CartProject({
    required this.namaProject,
    required this.date,
    required this.progress,
    this.leadingIcon, // Ikon untuk bagian kiri
    this.trailingIcon,
    this.onTap,
    this.percent,
    this.leadingIconOnPressed, // Ikon untuk bagian kanan
    this.tarilingIconOnPressed, // Ikon untuk bagian kanan
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        color: Color(0XFFD6D6D6),
        child: SizedBox(
          height: 83,
          width: 350,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      if (leadingIcon != null)
                        IconButton(
                          onPressed: leadingIconOnPressed ?? onTap,
                          icon: Icon(leadingIcon),
                        ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              child: Text(
                                namaProject,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                date,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (trailingIcon != null) // Tampilkan ikon jika ada
                        IconButton(
                          onPressed: tarilingIconOnPressed ?? onTap,
                          icon: Icon(trailingIcon),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width -
                            (MediaQuery.of(context).size.width - 208.42),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color(0XFFB1B1B1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: LinearPercentIndicator(
                                  padding: EdgeInsets.zero,
                                  animation: true,
                                  lineHeight: 7.0,
                                  animationDuration: 3000,
                                  percent: percent!,
                                  progressColor: Color(0XFF197492),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        progress,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 9.06,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
