import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Item {
  final String name;
  final int id;
  Item({
    required this.name,
    required this.id,
  });
}

final items = [
  Item(name: 'Keny Romero', id: 0),
  Item(name: 'Daniel Ebersole', id: 1),
  Item(name: 'Rick Waalders', id: 2),
  Item(name: 'Nadir Balcikli', id: 3),
  Item(name: 'Vadim Sherbakov', id: 4),
  Item(name: 'Guillaume', id: 5),
  Item(name: 'Radio Pink', id: 6),
];

class CurvedGallery extends StatelessWidget {
  const CurvedGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.white,
              child: ListView(
                children: items
                    .map((e) =>
                        cardImage(e.id, hasClip: e.id != 0, name: e.name))
                    .toList(),
              ),
            ),
            CustomPaint(
              size: const Size(double.infinity, 45),
              painter: RoundedClip(),
            ),
          ],
        ),
      ),
    );
  }

  Align cardImage(int idx, {bool hasClip = true, String name = 'Hello world'}) {
    return Align(
      heightFactor: 0.82,
      child: ClipPath(
        clipper: hasClip ? BackgroundClipperTop() : null,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: 320,
              child: Image.network(
                'https://picsum.photos/400/320?$idx',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops: const [0.3, 1],
                  colors: [
                    Colors.black.withOpacity(0),
                    Colors.black.withOpacity(0.8)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 320,
              child: DefaultTextStyle(
                style: GoogleFonts.lato(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.montserrat(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text('Travel gives us a taste of life'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedClip extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    var path = Path();

    var w = size.width;
    var h = size.height;

    path.lineTo(0, 45);

    path.quadraticBezierTo(5, h - 50, 70, h - 45);
    path.quadraticBezierTo(w * 0.50, h - 45, w - 70, h - 45);
    path.quadraticBezierTo(w - 5, h - 50, w, h - 0);

    path.lineTo(w, 0);

    canvas.drawShadow(path, Colors.black, 5, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class BackgroundClipperTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    var w = size.width;
    path.lineTo(0, 15);

    path.quadraticBezierTo(w * 0.01, 40, w * 0.06, 30);
    path.quadraticBezierTo(w * 0.33, -30, w * 0.56, 30);
    path.quadraticBezierTo(w * 0.67, 60, w * 0.82, 35);
    path.quadraticBezierTo(w * 0.97, 20, w, 55);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
