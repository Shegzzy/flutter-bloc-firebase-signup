import 'package:flutter/material.dart';

class CurvedWidget extends StatelessWidget {
  final Widget child;
  final double curvedWidth = 80;
  final double curvedHeight = 80;

  const CurvedWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedBackgroundClipper(
        curvedHeight: curvedHeight,
        curvedWidth: curvedWidth,
      ),
      child: child,
    );
  }
}

class CurvedBackgroundClipper extends CustomClipper<Path>{
  final double curvedWidth;
  final double curvedHeight;

  CurvedBackgroundClipper({required this.curvedHeight, required this.curvedWidth});

  @override
  getClip(Size size) {
    Path clippedPath = Path();
    clippedPath.lineTo(size.width, 0);
    clippedPath.lineTo(size.width, size.height - curvedWidth - curvedHeight);
    clippedPath.quadraticBezierTo(size.width, size.height - curvedHeight, size.width - curvedWidth, size.height - curvedHeight);
    clippedPath.lineTo(curvedWidth, size.height - curvedHeight);
    clippedPath.quadraticBezierTo(0, size.height - curvedHeight, 0, size.height);
    clippedPath.lineTo(0, 0);
    return clippedPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
  
}
