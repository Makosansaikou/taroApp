// main.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/',
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'taro',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        routes: {
        "/": (context) => OnePage(),
        "/main": (context) => HomePage(),
        "/result":(context) => ResultPage(),
        },
      );
  }
}
class ResultPage extends StatefulWidget{
  const ResultPage({Key? key}) :super(key: key);
   @override
  _ResultPageState createState() => _ResultPageState();
}
class _ResultPageState extends State<ResultPage>{
  
  @override
  Widget build(BuildContext context){
    dynamic con = ModalRoute.of(context)?.settings.arguments;
    // String gpt = con[0];
    // Future.delayed(Duration(seconds: 20));
    // gptresult = gptresult[0];
    // String? card1 = result[0].toString();
    // String? card2 = result[1].toString();
    // String? card3 = result[2].toString();
    
    return  Container(
      height: 160.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("taro-image/background.jpg"),
          fit: BoxFit.cover
        )
      ),
      child: Column(
        children:[
          SizedBox(
              height: 120,
              width: 40,
            ),
          Text(con,style: TextStyle(fontSize: 50,color: Color.fromRGBO(137, 90, 191, 75),decoration: TextDecoration.none,fontWeight: FontWeight.bold),textAlign: TextAlign.center),
          SizedBox(
              height: 120,
              width: 40,
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 255, 82, 241), //background color of button
            side: BorderSide(width:3, color:Colors.brown), //border width and color
            elevation: 1, //elevation of button
            shape: RoundedRectangleBorder( //to set border radius to button
            borderRadius: BorderRadius.circular(15)
            ),
            padding: EdgeInsets.all(5) //content padding inside button
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
            child: Text('返回')),
          ]
      )
    );
  }
}
class OnePage extends StatefulWidget {
  const OnePage({Key? key}) : super(key: key);
  @override
  _OnePageState createState() => _OnePageState();
}

class _OnePageState extends State<OnePage> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 160.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("taro-image/background.jpg"),
          fit: BoxFit.cover
        )
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 90,
              width: 40,
            ),
            Text("想要問的方面",style: TextStyle(fontSize: 30,color: Color.fromARGB(255, 255, 255, 255),decoration: TextDecoration.none)),
            SizedBox(
              height: 120,
              width: 40,
            ),
            // Horizontal Flipping
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(170, 90, 191, 75), //background color of button
                side: BorderSide(width:2, color:Colors.brown), //border width and color
                elevation: 5, //elevation of button
                shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(15)
                ),
                padding: EdgeInsets.all(5) //content padding inside button
                ),
                onPressed: () {
                  String name = "工作";
                  Navigator.pushNamed(context, '/main', arguments: name);
                },
                child: Text('工作')),
                SizedBox(
                  height: 100,
                  width: 40,
                ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(170, 90, 191, 75), //background color of button
                side: BorderSide(width:2, color:Colors.brown), //border width and color
                elevation: 1, //elevation of button
                shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(15)
                ),
                padding: EdgeInsets.all(5) //content padding inside button
                ),
                onPressed: () {
                  String name = "感情";
                  Navigator.pushNamed(context, '/main', arguments: name);
                },
                child: Text('感情')),
                SizedBox(
                  height: 100,
                  width: 40,
                ),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(170, 90, 191, 75), //background color of button
                side: BorderSide(width:2, color:Colors.brown), //border width and color
                elevation: 1, //elevation of button
                shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(15)
                ),
                padding: EdgeInsets.all(5) //content padding inside button
                ),
                onPressed: () {
                  String name = "健康";
                  Navigator.pushNamed(context, '/main', arguments: name);
                },
                child: Text('健康')),
                SizedBox(
                  height: 100,
                  width: 40,
                ),
          ]
        ),
      );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State with SingleTickerProviderStateMixin {
  List<int> resultList=[];
  String? url1,url2,url3,buttonText,card1,card2,card3,con,gptresult;
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;
  @override
  void initState() {
    super.initState();
    buttonText="翻開";
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    dynamic name = ModalRoute.of(context)?.settings.arguments;
    return  Container(
      height: 160.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("taro-image/background.jpg"),
          fit: BoxFit.cover
        )
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            // Horizontal Flipping
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateX(pi * _animation.value),
              child: Card(
                child: _animation.value <= 0.5
                    ? Container(
                        color: Colors.deepPurple,
                        width: 120,
                        height: 150,
                        child: Image.asset("taro-image/taroback.jpg"))
                    : Container(
                        width: 120,
                        height: 150,
                        color: Colors.grey,
                        child: RotatedBox(
                          quarterTurns:2,
                          child:  Image.asset(url1!),
                        )),
              ),
            ),
            // Vertical Flipping
            SizedBox(
              height: 15,
            ),
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateX(pi * _animation.value),
              child: Card(
                child: _animation.value <= 0.5
                    ? Container(
                        color: Colors.deepPurple,
                        width: 120,
                        height: 150,
                        child: Image.asset("taro-image/taroback.jpg"))
                    : Container(
                        width: 120,
                        height: 150,
                        color: Colors.grey,
                        child: RotatedBox(
                          quarterTurns:2,
                          child:  Image.asset(url2!),
                        )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateX(pi * _animation.value),
              child: Card(
                child: _animation.value <= 0.5
                    ? Container(
                        color: Colors.deepPurple,
                        width: 120,
                        height: 150,
                        child: Image.asset("taro-image/taroback.jpg"))
                    : Container(
                        width: 120,
                        height: 150,
                        color: Colors.grey,
                        child: RotatedBox(
                          quarterTurns: 2,
                          child: Image.asset(url3!),
                        )),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(170, 90, 191, 75), //background color of button
                side: BorderSide(width:3, color:Colors.brown), //border width and color
                elevation: 1, //elevation of button
                shape: RoundedRectangleBorder( //to set border radius to button
                borderRadius: BorderRadius.circular(15)
                ),
                padding: EdgeInsets.all(5) //content padding inside button
                ),
                onPressed: () {
                  gptresult="無";
                  if(buttonText=="查看結果"){
                      // con = gptresult!;
                      Navigator.pushNamed(context, "/result",arguments:con);
                    // resultList.clear();
                  }
                  else{
                    resultList.clear();
                    var count = 0;
                    var rn = new Random();
                    while (count < 3){
                      int index = rn.nextInt(78);//0~77
                      if(!resultList.contains(index)){
                        resultList.add(index);
                        count++;
                        }
                      }
                    url1="taro-image/"+resultList[0].toString()+".jpg";
                    url2="taro-image/"+resultList[1].toString()+".jpg";
                    url3="taro-image/"+resultList[2].toString()+".jpg";
                    final String apiKey = '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'; // 将YOUR_API_KEY替换为您的OpenAI API密钥
                    final String apiUrl = 'https://api.openai.com/v1/engines/text-davinci-003/completions'; // GPT-3.5 Turbo API 端点
                    final Map<String, String> headers = {
                      'Content-Type': 'application/json',
                      'Authorization': 'Bearer $apiKey',
                    };
                  final Map<String, int> tarotCards = {'愚者': 0,'魔術師': 1,'女教皇': 2,'皇后': 3,'皇帝': 4,'教皇': 5,'戀人': 6,'戰車': 7,'力量': 8,'隱士': 9,'命運之輪': 10,'正義': 11,'吊人': 12,'死神': 13,'節制': 14,'惡魔': 15,'塔樓': 16,'星星': 17,'月亮': 18,'太陽': 19,'審判': 20,'世界': 21,'權杖1': 22,'權杖2': 23,'權杖3': 24,'權杖4': 25,'權杖5': 26,'權杖6': 27,'權杖7': 28,'權杖8': 29,'權杖9': 30,'權杖10': 31,'權杖侍者': 32,'權杖騎士': 33,'權杖皇后': 34,'權杖國王': 35,'聖杯1': 36,'聖杯2': 37,'聖杯3': 38,'聖杯4': 39,'聖杯5': 40,'聖杯6': 41,'聖杯7': 42,'聖杯8': 43,'聖杯9': 44,'聖杯10': 45,'聖杯侍者': 46,'聖杯騎士': 47,'聖杯皇后': 48,'聖杯國王': 49,'寶劍1': 50,'寶劍2': 51,'寶劍3': 52,'寶劍4': 53,'寶劍5': 54,'寶劍6': 55,'寶劍7': 56,'寶劍8': 57,'寶劍9': 58,'寶劍10': 59,'寶劍侍者': 60,'寶劍騎士': 61,'寶劍皇后': 62,'寶劍國王': 63,'錢幣1': 64,'錢幣2': 65,'錢幣3': 66,'錢幣4': 67,'錢幣5': 68,'錢幣6': 69,'錢幣7': 70,'錢幣8': 71,'錢幣9': 72,'錢幣10': 73,'錢幣侍者': 74,'錢幣騎士': 75,'錢幣皇后': 76,'錢幣國王': 77};
                  String? findKeyByValue(Map<String, int> dictionary, int targetValue) {
                  for (var entry in dictionary.entries) {
                    if (entry.value == targetValue) {
                      return entry.key;
                      }
                    }
                    return null; // 如果找不到匹配的键，返回null或其他适当的默认值
                  }
                  card1 = resultList[0].toString();
                  card2= resultList[1].toString();
                  card3 = resultList[2].toString();
                  card1 = findKeyByValue(tarotCards, int.parse(card1!));
                  card2 = findKeyByValue(tarotCards, int.parse(card2!));
                  card3 = findKeyByValue(tarotCards, int.parse(card3!));
                  final Map<String, dynamic> requestData = {
                    'prompt': '你是一位占卜師,我想問有關'+name+',我抽了三張牌分別是:'+card1!+card2!+card3!+',請解出三張牌合再一起的含意並直接回答,回答請不要有換行符號,回答使用15個字以內',
                    'max_tokens': 50,
                  };
                  String fullGeneratedText = '';
                  void getResponse(String prompt) {
                      final Map<String, dynamic> currentRequestData = {...requestData, 'prompt': prompt};
                      http.post(Uri.parse(apiUrl), headers: headers, body: json.encode(currentRequestData)).then((response) {
                        if (response.statusCode == 200) {
                          Map<String, dynamic> data = json.decode(response.body);
                          String generatedText = data['choices'][0]['text'];
                          fullGeneratedText += generatedText + '\n';
                          String remainingText = data['choices'][0]['text'];
                          if (remainingText.endsWith('...')) {
                            // 如果回复以 "..." 结尾，继续获取下一部分
                            getResponse(prompt + generatedText);
                          } else {
                            String jsonText = json.encode({'generatedText': utf8.decode(fullGeneratedText.runes.toList())});
                            print('Generated Text as JSON: $jsonText');
                            // 打印完整的回复
                            print('Full Generated Text:');
                            print(utf8.decode(fullGeneratedText.runes.toList()));
                            gptresult=utf8.decode(fullGeneratedText.runes.toList());
                            gptresult=gptresult?.trim();
                            print('gptresult:'+gptresult!);
                            con = gptresult!;
                          }
                        } else {
                          print('Error: ${response.statusCode} - ${response.reasonPhrase}');
                        }
                      }).catchError((error) {
                        print('Error: $error');
                      });
                    }
                    getResponse(requestData['prompt']);
                  }
                  // resultList.sort();
                  if (_status == AnimationStatus.dismissed) {
                    _controller.forward();//翻面
                    buttonText="查看結果";
                  } else {
                    url1="taro-image/taroback.jpg";
                    url2="taro-image/taroback.jpg";
                    url3="taro-image/taroback.jpg";
                    _controller.reverse();//翻回去
                  }
                },
                child: Text(buttonText!)),
          ],
        ),
      );
  }
}

