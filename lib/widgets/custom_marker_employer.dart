import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';

class CustomMarkerEmployer extends StatelessWidget {
  final JobSeeker nearbyJobSeeker;

  CustomMarkerEmployer(this.nearbyJobSeeker);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Label(),
      child: Container(
        width: 56,
        height: 20,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              nearbyJobSeeker.jobCategory == 'Home'
                  ? Image.asset(
                      'assets/images/ic_house.png',
                      width: 8,
                      height: 8,
                    )
                  : nearbyJobSeeker.jobCategory == 'Auto'
                      ? Image.asset(
                          'assets/images/ic_auto.png',
                          width: 8,
                          height: 8,
                        )
                      : nearbyJobSeeker.jobCategory == 'Leisure'
                          ? Image.asset(
                              'assets/images/ic_leisure.png',
                              width: 8,
                              height: 8,
                            )
                          : nearbyJobSeeker.jobCategory == 'Other'
                              ? Image.asset(
                                  'assets/images/ic_other.png',
                                  width: 8,
                                  height: 8,
                                )
                              : nearbyJobSeeker.jobCategory == 'Self Care'
                                  ? Image.asset(
                                      'assets/images/ic_personal.png',
                                      width: 8,
                                      height: 12,
                                    )
                                  : null,
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    nearbyJobSeeker.jobCategory,
                    style: TextStyle(
                        fontFamily: 'Kayak', fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Label extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = new LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [accentColor, accentColor],
      tileMode: TileMode.clamp,
    );

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = new Paint()
      ..shader = gradient.createShader(colorBounds);

    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(-8, size.height / 2);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
