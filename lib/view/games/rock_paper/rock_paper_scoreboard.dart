import 'package:flutter/material.dart';
class RockPaperScoreboardPage extends StatefulWidget {
  const RockPaperScoreboardPage({Key? key}) : super(key: key);

  @override
  _RockPaperScoreboardPageState createState() {
    return _RockPaperScoreboardPageState();
  }
}

class _RockPaperScoreboardPageState extends State<RockPaperScoreboardPage> {
  _RockPaperScoreboardPageState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Scoreboard",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[900]),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(side: BorderSide()),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  " : ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 60.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
