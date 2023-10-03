import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:coa_progress_tracking_app/utilities/app_bar_wrapper.dart';
import 'package:coa_progress_tracking_app/utilities/reward_animator.dart';
import 'package:audioplayers/audioplayers.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {

  bool oTurn = true;
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  String winner_result = "";
  final RewardAnimator _rewardAnimator = RewardAnimator();

  @override
  void initState()
  {
    super.initState();
    //_rewardAnimator = RewardAnimator();
  }

  bool checkWinner()
  {
    //CHECK ROWS
    //1st row check
    if(board[0] == board[1] && board[0] == board[2] && board[0] != '')
      {
        setState(() {
          winner_result = 'Player ' + board[0] + ' Wins!';
        });
        return true;
      }
    //2st row check
    else if(board[3] == board[4] && board[3] == board[5] && board[3] != '')
    {
      setState(() {
        winner_result = 'Player ' + board[3] + ' Wins!';
      });
      return true;
    }
    //3st row check
    else if(board[6] == board[7] && board[6] == board[8] && board[6] != '')
    {
      setState(() {
        winner_result = 'Player ' + board[6] + ' Wins!';
      });
      return true;
    }

    //CHECK COLUMNS
    else if(board[0] == board[3] && board[0] == board[6] && board[0] != '')
    {
      setState(() {
        winner_result = 'Player ' + board[0] + ' Wins!';
      });
      return true;
    }
    //2st row check
    else if(board[1] == board[4] && board[1] == board[7] && board[1] != '')
    {
      setState(() {
        winner_result = 'Player ' + board[1] + ' Wins!';
      });
      return true;
    }
    //3st row check
    else if(board[2] == board[5] && board[2] == board[8] && board[2] != '')
    {
      setState(() {
        winner_result = 'Player ' + board[2] + ' Wins!';
      });
      return true;
    }

    //CHECK DIAGONALS
    else if(board[0] == board[4] && board[0] == board[8] && board[0] != '')
    {
      setState(() {
        winner_result = 'Player ' + board[0] + ' Wins!';
      });
      return true;
    }
    //3st row check
    else if(board[6] == board[4] && board[6] == board[2] && board[2] != '')
    {
      setState(() {
        winner_result = 'Player ' + board[2] + ' Wins!';
      });
      return true;
    }
    else
      {
        return false;
      }
  }

  void updateBoard(int index, RewardAnimator _rewardAnimator){
    setState(() {
      if(oTurn && board[index] == '') {
        board[index] = 'O';
      }
      else if(!oTurn && board[index] == '')
      {
        board[index] = 'X';
      }
      else{
        oTurn = !oTurn;
      }
      oTurn = !oTurn;
      bool winner = checkWinner();
      if(winner)
      {
        //do confetti
        _rewardAnimator.doConfetti();
      }
    });
  }

  void resetBoard() {
    setState(() {
      for(int i = 0; i < board.length; i++)
      {
        board[i] = '';
      }
      winner_result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    //final RewardAnimator _rewardAnimator = RewardAnimator();
    Size size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      /// ***** App Bar ***** ///
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBarWrapper(
          title: "Games",
        ),
      ),
      body: Stack(
        children: [
          Container(
          //padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              //_rewardAnimator,
              Container(
                margin: EdgeInsets.only(bottom: 0.02 * height),
                  child: Text('Tic Tac Toe',
                    style: TextStyle(
                      fontSize: 0.05 * height,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          //_rewardAnimator.doConfetti();
                          updateBoard(index, _rewardAnimator);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 5,
                              color: Colors.green[900]!,
                            ),
                            color: Colors.black,
                          ),
                          child: Center(
                            child: Text(
                              board[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 0.12 * MediaQuery.of(context).size.height,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 0.05 * height),
                  child: Text(winner_result,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 0.05 * MediaQuery.of(context).size.height,
                  ),)
              ),
              SizedBox(
                  child: ElevatedButton(
                    onPressed: () => resetBoard(),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green[700]!),
                    ),
                    child: Text('Reset Board')
                  )),
            ],

          ),
        ),
      _rewardAnimator
      ])
    );
  }
}