import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merry Christmas! from Future Lab',
      theme: ThemeData(
          textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
      )),
      home: Tree(),
    );
  }
}

class Tree extends StatefulWidget {
  static final List<double> _offsets =
      _generateOffsets(100, 0.05).toList(growable: false);

  @override
  State<Tree> createState() => _TreeState();

  static Iterable<double> _generateOffsets(
      int count, double acceleration) sync* {
    double x = 0;
    yield x;

    double ax = acceleration;
    for (var i = 0; i < count; i++) {
      x += ax;
      ax *= 1.5;

      final maxLateral = min(1, i / count);
      if (x.abs() > maxLateral) {
        x = maxLateral * x.sign;
        ax = x >= 0 ? -acceleration : acceleration;
      }
      yield x;
    }
  }
}

class _TreeState extends State<Tree> {
  bool _showDragon = false;
  String _message = "Merry Christmas!";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Align(
        child: Container(
          constraints: BoxConstraints(maxWidth: 700),
          child: ListView(
            children: <Widget>[
              TextButton(
                  onPressed: onPressed,
                  child: Text(
                    _message,
                    style: TextStyle(
                      color: Colors.blue[200],
                      backgroundColor: Colors.amber[100],
                      fontSize: 30,
                    ),
                  )),
              _showDragon
                  ? Center(
                      child: Image.asset('images/dragon.png'),
                    )
                  : Column(
                      children: [
                        Center(child: Icon(Icons.star, color: Colors.white)),
                        SizedBox(height: 7),
                        for (final x in Tree._offsets) Light(x),
                        SizedBox(height: 40),
                        Center(child: Text('(Happy Holidays from Future Lab!)'))
                      ],
                    ),
            ],
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 7),
          ),
        ),
      ),
    );
  }

  void onPressed() {
    _message == "Merry Christmas!"
        ? setState(() {
            _message = "And Happy New Year!";
            _showDragon = true;
          })
        : setState(() {
            _message = "Merry Christmas!";
            _showDragon = false;
          });
  }
}

class Light extends StatefulWidget {
  static List<Color> festiveColors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.yellow
  ];

  /// The light's offset from center.
  final double x;

  /// Pseudo-random period for the light's color change.
  final int period;

  /// One of the [festiveColors].
  final Color color;

  Light(this.x, {Key? key})
      : period = 500 + (x.abs() * 4000).floor(),
        color = festiveColors[(x.abs() * 42).floor() % festiveColors.length],
        super(key: key);

  @override
  _LightState createState() => _LightState();
}

class _LightState extends State<Light> {
  Color _newColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      height: 10,
      child: Align(
        alignment: Alignment(widget.x, 0),
        child: AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: ColorTween(begin: widget.color, end: _newColor),
            duration: Duration(milliseconds: widget.period),
            onEnd: () {
              setState(() {
                _newColor =
                    _newColor == Colors.white ? widget.color : Colors.white;
              });
            },
            builder: (_, color, __) => Container(color: color),
          ),
        ),
      ),
    );
  }
}
