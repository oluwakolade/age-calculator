import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(primarySwatch: Colors.deepOrange),
      home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  double age = 0.0;
  var selectedYear;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    animation = animationController;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  void _showPicker() {
    showDatePicker(
            context: context,
            firstDate: new DateTime(1900),
            initialDate: new DateTime(2020),
            lastDate: DateTime.now())
        .then((DateTime dt) {
      selectedYear = dt.year;
      calculateAge();
    });
  }

  void calculateAge() {
    setState(() {
      age = (2020 - selectedYear).toDouble();
      animation = new Tween<double>(begin: animation.value, end: age).animate(
          new CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: animationController));

      animationController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: new AppBar(
        title: new Center(child: new Text("AGE CALCULATOR")),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new OutlineButton(
              child: new Text(
                selectedYear != null
                    ? selectedYear.toString()
                    : "Year Of Birth",
                style: TextStyle(fontFamily: 'Lato'),
              ),
              borderSide: new BorderSide(color: Colors.deepOrange, width: 3.0),
              color: Colors.white,
              textColor: Colors.white,
              onPressed: _showPicker,
            ),
            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            new AnimatedBuilder(
              animation: animation,
              builder: (context, child) => new Text(
                "You Are ${animation.value.toStringAsFixed(0)} Years Old !",
                style: new TextStyle(
                    fontFamily: 'Poiret One',
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
