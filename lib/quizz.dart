
import 'package:flutter/material.dart';
import 'package:quizz_flutter/data.dart';

class Quizz extends StatefulWidget{
  @override
  QuizzState createState() => QuizzState();
}

class QuizzState extends State<Quizz>{
  int score = 0;
  int questionIndx = 0;
  Datas Data = Datas();
  bool endGame = false;
  late bool answer;
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        title: Text("score : ${score}") ,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Text(
                'Question n° ${questionIndx+1}/${Data.listeQuestions.length}',
                style: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 20,
                ) ,
              ),
          Text(Data.listeQuestions[questionIndx].question + " ?",
            style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Container(
            width: MediaQuery.of(context).size.width/1.1,
            height: MediaQuery.of(context).size.height/2.5,
            child: Image.asset(Data.listeQuestions[questionIndx].getImage(),fit: BoxFit.cover,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: (){
                setState(() {
                  answer = false;
                  checkAnswerAndShowDialog(ans: answer, index: questionIndx);
                });
              }, child: const Text("Faux",style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.redAccent)),),
              TextButton(onPressed: (){
                answer = true;
                checkAnswerAndShowDialog(ans: answer, index: questionIndx);

              }, child: Text("Vrai",style: TextStyle(color: Colors.white)),style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.greenAccent)),),
            ],
          )

        ],
      )
    );
  }
  void checkAnswerAndShowDialog({required bool ans,required int index}){
    if(index == 9){
      showMyDialog(simpleAlert("C'est fini"));
      return;
    }
    if(Data.listeQuestions[index].reponse == ans){
      setState(() {
        score++;
        showMyDialog(
            GoodOrFalseDialog("C'est très bien 😊😊", Data.listeQuestions[questionIndx].explication, "quizz_image/vrai.jpg")
        );
      }
      );
    }else{
      showMyDialog(
          GoodOrFalseDialog("C'est faux 😭😭", Data.listeQuestions[questionIndx].explication, "quizz_image/faux.jpg")
      );
    }
  }

  SimpleDialog GoodOrFalseDialog(title,String explication,String ImagePath){
    return SimpleDialog(
      title: Text(title,textAlign: TextAlign.center,),
      children: [
        Text(explication,textAlign: TextAlign.center,),
        Container(
          child: Image.asset(ImagePath),
        ),
        SimpleDialogOption(
          onPressed:(){
            setState(() {
              questionIndx++;
              Navigator.of(context).pop();
            });
          } ,
          child: Expanded(
    child: Text("Question suivante",style: TextStyle(color: Colors.deepOrange),textAlign: TextAlign.center,),
    )

        )
      ],
    );
  }

  AlertDialog simpleAlert(String title){
    return AlertDialog(
      title: Text("C'est fini !!!"),
      content: Text("Votre score est de :${score}"),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop()
          ;Navigator.of(context).pop();
          }, child: Text("Ok")),
      ]
    );
  }
  Future showMyDialog(Widget dialog) async{
    await showDialog(context: context, builder: (BuildContext ctx){
      return dialog;
    });
  }
}