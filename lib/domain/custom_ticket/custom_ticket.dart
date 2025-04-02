import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app/components/constants/getSize/getSize.dart';

class TicketWidget extends StatelessWidget {
  final String imageUrl;

  TicketWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ClipPath(
            clipper: TrapezoidClipper(),
            child: Container(
              height: GetSize.heightValue(550, context),
              width: GetSize.widthValue(364, context),
              child: CachedNetworkImage(imageUrl: imageUrl),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                    Radius.circular(GetSize.widthValue(20, context))),
              ),
            ),
          ),
        ),
        Positioned(
          left: GetSize.widthValue(30, context),
          top: MediaQuery.sizeOf(context).height / 2,
          child: Container(
            height: GetSize.heightValue(50, context),
            width: GetSize.widthValue(50, context),
            decoration:
                BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
          ),
        ),
        Positioned(
          right: GetSize.widthValue(30, context),
          top: MediaQuery.sizeOf(context).height / 2,
          child: Container(
            height: GetSize.heightValue(50, context),
            width: GetSize.widthValue(50, context),
            decoration:
                BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
          ),
        ),
        Positioned(
          left: GetSize.widthValue(10, context),
          top: GetSize.heightValue(110, context),
          child: Container(
            height: GetSize.heightValue(100, context),
            width: GetSize.widthValue(100, context),
            decoration:
                BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
          ),
        ),
        Positioned(
          right: GetSize.widthValue(10, context),
          top: GetSize.heightValue(110, context),
          child: Container(
            height: GetSize.heightValue(100, context),
            width: GetSize.widthValue(100, context),
            decoration:
                BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
          ),
        ),
        Positioned(
          bottom: GetSize.heightValue(30, context),
          right: (MediaQuery.sizeOf(context).width / 2) -
              GetSize.widthValue(150, context),
          child: Align(
            alignment: Alignment.center,
            child: CustomPaint(
              painter: TicketPainter(),
              child: Container(
                width: GetSize.widthValue(300, context),
                height: GetSize.heightValue(200, context),
                padding: EdgeInsets.all(GetSize.widthValue(20, context)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(size.width * 0.05),
    ));

    double circleRadius = size.width * 0.04;
    path.addOval(Rect.fromCircle(
        center: Offset(0, size.height / 2), radius: circleRadius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: circleRadius));

    canvas.drawShadow(path, Colors.black54, 4, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    double topWidth = size.width;
    double bottomWidth = size.width * 0.75;
    double height = size.height;

    double dx = (topWidth - bottomWidth) / 2;

    path.moveTo(0, 0);
    path.lineTo(topWidth, 0);
    path.lineTo(topWidth - dx, height);
    path.lineTo(dx, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
