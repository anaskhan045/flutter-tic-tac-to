import 'package:flutter/material.dart';

import 'game_buttons.dart';
class FriendPage extends StatefulWidget {

  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List<GameButton> buttonList;
  var player1 = new List();
  var player2 = new List();
  var activePlayer = 1;
  String winString = "";
  String reString = "";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonList = doInit();
  }

  List<GameButton> doInit() {
    var gameButton = <GameButton>[
      new GameButton(id: 1),
      new GameButton(id: 2),
      new GameButton(id: 3),
      new GameButton(id: 4),
      new GameButton(id: 5),
      new GameButton(id: 6),
      new GameButton(id: 7),
      new GameButton(id: 8),
      new GameButton(id: 9),
    ];
    return gameButton;
  }

  void playGame(GameButton gb) {
    setState(() {

      if (activePlayer == 1) {
        gb.text = "X";
        gb.bc = Colors.red;
        player1.add(gb.id);
        activePlayer = 2;
      } else {
        gb.text = "O";
        gb.bc = Colors.black;
        player2.add(gb.id);
        activePlayer = 1;
      }
      gb.enabled = false;
      int winner = checkWinner();

      if (winner == -1) {
        if (buttonList.every((p) => p.text != "")) {
          winString = "Game Tied!";
          reString = "Press the Reset Button to Restart";
        }
      }
    });
  }

  int checkWinner() {
    int winner = -1;
    //Row1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(2) &&
        player2.contains(3)) {
      winner = 2;
    }

    //Row2
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    } else if (player2.contains(4) &&
        player2.contains(5) &&
        player2.contains(6)) {
      winner = 2;
    }

//Row3
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(7) &&
        player2.contains(8) &&
        player2.contains(9)) {
      winner = 2;
    }

    //Column1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(4) &&
        player2.contains(7)) {
      winner = 2;
    }

    //Column2
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    } else if (player2.contains(2) &&
        player2.contains(5) &&
        player2.contains(8)) {
      winner = 2;
    }

    //Column3
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(3) &&
        player2.contains(6) &&
        player2.contains(9)) {
      winner = 2;
    }

    //diagonal1
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(5) &&
        player2.contains(9)) {
      winner = 2;
    }

    //Diagonal2
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    } else if (player2.contains(3) &&
        player2.contains(5) &&
        player2.contains(7)) {
      winner = 2;
    }
    if (winner != -1) {
      if (winner == 1) {
        for(int i=0;i<9;i++)
          {
            buttonList[i].enabled=false;
          }
        winString = "";
        reString = "Press the Reset Button to Restart";
        var alert = AlertDialog(
          title: Center(
            child: Text("Player(X) win",style: TextStyle(
                color: Colors.white70,
                fontSize: 30
            ),),
          ),
          content: Text("Pressn on Reset to Restart",style: TextStyle(
              color: Colors.white70,
              fontSize: 20
          ),),
          backgroundColor: Colors.black54,
        );
        showDialog(context: context,
        builder: (_)=> alert);
      } else {
        for(int i=0;i<9;i++)
        {
          buttonList[i].enabled=false;
        }
        var alert = AlertDialog(
          title: Center(
            child: Text("Player(O) win",style: TextStyle(
                color: Colors.white70,
                fontSize: 30
            ),),
          ),
          content: Text("Pressn on Reset to Restart",style: TextStyle(
              color: Colors.white70,
              fontSize: 20
          ),),
          backgroundColor: Colors.black54,
        );
        showDialog(context: context,
            builder: (_)=> alert);
      }
    }
    return winner;
  }

  void reset() {
    if (Navigator.canPop(context)) Navigator.canPop(context);
    setState(() {
      buttonList = doInit();
      activePlayer = 1;winString = "";
      reString = "";

      player1.clear();
      player2.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tic Tac To"),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: <Widget>[
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, i) =>
                    Container(
                      child: RaisedButton(
                          child: Text(
                            buttonList[i].text,
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          padding: const EdgeInsets.all(10),
                          onPressed: buttonList[i].enabled
                              ? () => playGame(buttonList[i])
                              : null),
                      color: buttonList[i].bc,
                    ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(winString, style: TextStyle(
                    color: Colors.red,
                    fontSize: 30
                ),),

              ],
            ),

            RaisedButton(
              onPressed: reset,
              padding: EdgeInsets.all(20),
              child: Text("Reset", style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),),
              color: Colors.red,
            )
          ],
        ));

  }
}
