import 'dart:math';


import 'package:flutter/material.dart';

import 'game_buttons.dart';

class PhonePage extends StatefulWidget {
  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  List<GameButton> buttonList;


  var activePlayer = 1;

var  player1 = new List();
 var player2 = new List();



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
        gb.text = 'X';
        gb.bc = Colors.red;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = 'O';
        gb.bc = Colors.black;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonList.every((p) => p.text != "")) {

       var alert=   AlertDialog(

            title: Center(child: Text("Game Tied!",style: TextStyle(
                color: Colors.white70,
                fontSize: 30
            ),)),
            content: Text("Press on Reset to Restart",style: TextStyle(
                color: Colors.white70,
                fontSize: 20
            ),),
         backgroundColor:Colors.black54,

          );
          showDialog(context: context,
            builder: (_) =>alert
          );

        }else{
          activePlayer==2?autoPlay(buttonList) : null;
        }
      }
    });
  }

  void autoPlay(List <GameButton> buttonList)
  {
    int bestValue =-1000;
    int moveValue;
    int bestMove;
    for(int i=0; i<9; i++)
    {
      if(buttonList[i].text == "")
      {
        buttonList[i].text="O";

        moveValue = miniMax(buttonList,false);
        buttonList[i].text="";
        if(moveValue > bestValue)
        {
          bestValue=moveValue;
          bestMove=i;
        }

      }
    }
    playGame(buttonList[bestMove]);

  }

  int miniMax(List <GameButton> buttonList, bool isMax)
  {
    int score = evalvate(buttonList);

    if(score==10)
      return score;
    if(score== -10)
      return score;
    if(isMoveLeft(buttonList)==false)
      return 0;
    if(isMax)
    {
      int best =-1000;
      for(int i=0; i<9;i++)
      {
        if(buttonList[i].text=="")
        {
          buttonList[i].text="O";
          best = [best,miniMax(buttonList, false)].reduce(max);
          buttonList[i].text="";
        }
      }
      return best;
    }
    else
    {
      int best=1000;
      for(int i=0; i<9;i++)
      {
        if(buttonList[i].text=="")
        {
          buttonList[i].text="X";
          best = [best,miniMax(buttonList, true)].reduce(min);
          buttonList[i].text="";
        }
      }
      return best;

    }
  }
  int evalvate(List <GameButton> bl)
  {
    //row1
    if(bl[0].text==bl[1].text && bl[1].text==bl[2].text)
    {
      if(bl[0].text=="X")
        return -10;
      else if(bl[0].text=="O")
        return 10;
    }
    //row2

    if(bl[3].text==bl[4].text && bl[4].text==bl[5].text)
    {
      if(bl[3].text=="X")
        return -10;
      else if(bl[3].text=="O")
        return 10;
    }
    //row3
    if(bl[6].text==bl[7].text && bl[7].text==bl[8].text)
    {
      if(bl[6].text=="X")
        return -10;
      else if(bl[6].text=="O")
        return 10;
    }
    //col1
    if(bl[0].text==bl[3].text && bl[3].text==bl[6].text)
    {
      if(bl[0].text=="X")
        return -10;
      else if(bl[0].text=="O")
        return 10;
    }
    //col2
    if(bl[1].text==bl[4].text && bl[4].text==bl[7].text)
    {
      if(bl[1].text=="X")
        return -10;
      else if(bl[1].text=="O")
        return 10;
    }
    //col3
    if(bl[2].text==bl[5].text && bl[5].text==bl[8].text)
    {
      if(bl[2].text=="X")
        return -10;
      else if(bl[2].text=="O")
        return 10;
    }

    //diagonal1
    if(bl[0].text==bl[4].text && bl[4].text==bl[8].text)
    {
      if(bl[0].text=="X")
        return -10;
      else if(bl[0].text=="O")
        return 10;
    }
    //diagonal2
    if(bl[2].text==bl[4].text && bl[4].text==bl[6].text)
    {
      if(bl[2].text=="X")
        return -10;
      else if(bl[2].text=="O")
        return 10;
    }

    return 0;

  }

  bool isMoveLeft(List <GameButton> buttonList)
  {
    for(int i=0; i<9; i++)
    {
      if(buttonList[i].text=="")
        return true;
    }
    return false;
  }

  int checkWinner() {
    var winner = -1;
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

        var alert=   AlertDialog(

          title: Center(child: Text( "Congratulations! You Win",style: TextStyle(
              color: Colors.white70,
              fontSize: 30
          ),)),
          content: Text("Press on Reset to Restart",style: TextStyle(
              color: Colors.white70,
              fontSize: 20
          ),),
          backgroundColor:Colors.black54,

        );
        showDialog(context: context,
            builder: (_) =>alert
        );

      } else{
        for(int i=0;i<9;i++)
        {
          buttonList[i].enabled=false;
        }
      var alert=   AlertDialog(

        title: Center(child: Text("Sorry! You Lose",style: TextStyle(
            color: Colors.white70,
            fontSize: 30
        ),)),
        content: Text("Press on Reset to Restart",style: TextStyle(
            color: Colors.white70,
            fontSize: 20
        ),),
        backgroundColor:Colors.black54,

      );
      showDialog(context: context,
          builder: (_) =>alert
      );

    }}
    return winner;
  }

  void resetGame() {

    setState(() {
      buttonList = doInit();

      activePlayer=1;
      player1.clear();
      player2.clear();


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac TO"),
        centerTitle: true,
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 9.0,
                    mainAxisSpacing: 9.0
                ),
                itemCount: 9,
                itemBuilder: (context, i) =>
                    SizedBox(
                      width: 100.0,
                      height: 100.0,
                      child: RaisedButton(
                        padding: const EdgeInsets.all(10.0),
                        onPressed: buttonList[i].enabled ? () =>
                            playGame(buttonList[i]) : null,
                        child: Text(buttonList[i].text, style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white
                        ),),
                        color: buttonList[i].bc,
                        disabledColor: buttonList[i].bc,
                      ),
                    ),
              ),
            ),

            RaisedButton(
              padding: const EdgeInsets.all(20),
              child: Text("Reset", style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),),
              color: Colors.red,
              onPressed: resetGame,
            )
          ],
        ),
      ),
    );
  }
}

