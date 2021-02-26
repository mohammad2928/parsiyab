import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parsiyab/pages/cart.dart';
import 'package:parsiyab/pages/models.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class SplshScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }


}


class SplashScreenState extends State <SplshScreen> with SingleTickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )
      ..addListener(() => setState(() {}));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
    
    animationController.forward();


    super.initState();
    startTime();
    _readCsvFile();
  }



  @override
  void dispose() {
   animationController.dispose();
    super.dispose();
  }



  startTime() {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  navigationPage() {
    Navigator.of(context).pushReplacementNamed('/');
    set_word_colors();
    Provider.of<Cart>(context, listen: false).makeSearchDict();
  }

  init_cart(BuildContext context){
    final cart = Provider.of<Cart>(context);
    cart.initiate();
    cart.categories();
    //cart.makeSearchDict();
    return Container();
  }

  set_word_colors() async{

    final  _faverit = await SharedPreferences.getInstance();
    List<String> colorfull_words = _faverit.getStringList('faverit') ?? [];
    for (var item in colorfull_words){
      Provider.of<Cart>(context, listen: false).word_colors[item.trim()] = Colors.red;
    }
    return Container();
  }
  auto_press_button(){
    FlatButton button = FlatButton(
      child: Text("Button"),
      onPressed: () => set_word_colors(),
    );
    button.onPressed();
    return Visibility(
      child: new Text('f'),
      visible: false,
    );
  }
  @override

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    String text = """ 
    
    """;
    return new Scaffold(
        backgroundColor: _colorFromHex("DFD8E8"),
        body: new Stack(
          children: <Widget>[



            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                new Container(
                  width: _width*0.9,
                  height: _height*0.2,
                  padding: EdgeInsets.all(0),
//                  child: Image(image: AssetImage('assets/images/logo_text.png')),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/logo_text.png"),
                      fit: BoxFit.fitWidth,),

                  ),
                ),


                new Container(
                  padding: EdgeInsets.all(0),
                  child: new InkWell(

                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: new Text("www.parsiyab.com",

                        style: TextStyle(fontSize: 20, color: Colors.blue,
                            decoration: TextDecoration.underline),
                      )
                      ,
                    ),
                    onTap: () => launch('https://www.parsiyab.com'),
                  ),

                ),
                new Container(height: _height*0.1,),
                new  Text(
                  'گردآوری و نگارش ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                new  Text(
                  'از منوچهر سلیمانی ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),



              ],
            ),
           new Padding(
             padding: EdgeInsets.only(bottom: 10),
             child: new Align(
               alignment: Alignment.bottomCenter,
               child: new CircularProgressIndicator(),
             ),
           ),
            init_cart(context),
            auto_press_button(),
          ],
        )

    );
  }

  Future<String> loadAsset(String path) async {
    return await rootBundle.loadString(path);
  }


    _readCsvFile() async{
    loadAsset('assets/csv/test.txt').then((dynamic output) {

      var string = output.toString();
      List lines = string.split('\n');
      for (var i = 0; i < lines.length; i++){
        String line = lines[i];
        List words = line.split('\t');
        final word = Data(words[0], words[1], words.getRange(4, words.length-1).toList(), words[2], words[3]);
        Provider.of<Cart>(context, listen: false).add_words(word);


      }


    });

  }




}

