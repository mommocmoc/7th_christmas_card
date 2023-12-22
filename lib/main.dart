import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:future_lab_7th_christmas_card/generated/l10n.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
  SemanticsBinding.instance.ensureSemantics();
}

class MyApp extends StatefulWidget {
  static final List<double> _offsets =
      _generateOffsets(100, 0.05).toList(growable: false);

  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();

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

class _MyAppState extends State<MyApp> {
  final Locale _locale = const Locale("en");
  bool _showDragon = false;
  String _message = "Merry Christmas!";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //This line is important! To load the init localization data.
    S.load(_locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        // AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('ko'),
      ],
      locale: _locale,
      title: 'Christmas Card from Future Lab',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: FittedBox(
            child: _showDragon
                ? Text(
                    '${Intl.message('happynewyear')} Card',
                    style: const TextStyle(color: Colors.deepOrangeAccent),
                  )
                : Text(
                    '${Intl.message('merrychristmas')} Card',
                    style: const TextStyle(color: Colors.deepOrangeAccent),
                  ),
          ),
          actions: [
            PopupMenuButton<Locale>(
              tooltip: Intl.message('tooltip'),
              icon: const Icon(Icons.language),
              initialValue: _locale,
              itemBuilder: (context) => const AppLocalizationDelegate()
                  .supportedLocales
                  .map(
                    (locale) => PopupMenuItem(
                      value: locale,
                      child: Text(locale.languageCode),
                    ),
                  )
                  .toList(),
              onSelected: (locale) => {
                setState(() {
                  S.load(locale);
                })
              },
            )
          ],
          foregroundColor: Colors.amber,
          backgroundColor: Colors.black87,
        ),
        backgroundColor: Colors.black,
        body: Align(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 7),
              children: <Widget>[
                TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                  onPressed: onPressed,
                  child: Column(
                    children: [
                      Text(
                        Intl.message('info'),
                        style: const TextStyle(
                          // backgroundColor: Colors.amberAccent,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _showDragon
                            ? '${Intl.message('happynewyear')}!🐉'
                            : '${Intl.message('merrychristmas')}!🎄',
                        style: TextStyle(
                          color: Colors.blue[200],
                          // backgroundColor: Colors.amber[100],
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                _showDragon
                    ? Center(
                        child: Image.asset('dragon.png'),
                      )
                    : Column(
                        children: [
                          const Center(
                              child: Icon(Icons.star, color: Colors.white)),
                          const SizedBox(height: 7),
                          for (final x in MyApp._offsets) Light(x),
                          const SizedBox(height: 40),
                        ],
                      ),
              ],
            ),
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
