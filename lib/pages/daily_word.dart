
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parsiyab/pages/about.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart.dart';



class dailyWord extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _dailyWord();
  }

}

class  _dailyWord extends State<dailyWord>
    with SingleTickerProviderStateMixin {
  @override

  addToFaverit(BuildContext context, final String word) async {
    var cart = Provider.of<Cart>(context, listen: false);
    if (word != null && word != ' ' && word != '' &&
        cart.words.contains(word)) {
      final _faverit = await SharedPreferences.getInstance();
      List<String> words = _faverit.getStringList('faverit') ?? [];
      words.add(word);
      await _faverit.setStringList("faverit", words);
        Provider.of<Cart>(context, listen: false).word_colors[word] = Colors.red;

    }
  }


  removeFromFaverit(BuildContext context, String word) async{
    var cart = Provider.of<Cart>(context, listen: false);
    if(word != null && word != ' ' && word != '' && cart.words.contains(word)){
      final _faverit = await SharedPreferences.getInstance();
      List<String> words = _faverit.getStringList('faverit') ?? [];
      words.remove(word);
      await _faverit.setStringList("faverit", words);
      cart.word_colors[word] = Colors.white;
    }

  }


  Color _color = Colors.white;
  bool _a_visible = false;
  bool _b_visible = false;


  getFaverit(BuildContext context) async{
    final cart = Provider.of<Cart>(context, listen: false);
    final _faverit = await SharedPreferences.getInstance();
    List<String> words = _faverit.getStringList('faverit') ?? [];
    cart.makeFaveritList(words);

  }
  Widget menu_widget(BuildContext context){
    final cart = Provider.of<Cart>(context);
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    Color _menu_color = _colorFromHex('#A464A6');
    Color _select_box_color = _colorFromHex('#A2B5CD');
    Color _select_text_color = _colorFromHex('#A464A6');
    double _menu_font_size = 11.5;
    return(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Container(
              width: _width*0.005,
            ),
            new SizedBox(
                child: new RaisedButton(

                  textColor: Colors.white,
                  color:  _menu_color,
                  onPressed:   (){
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  child: new Text("جستجو",
                    style: TextStyle(fontSize: _menu_font_size),
                  ),
                ),
                width: _width/6
            ),
            new Container(
              width: _width*0.004,
            ),
            new SizedBox(
              child: new RaisedButton(

                textColor: Colors.white,
                color:  _select_box_color,
                onPressed:   (){
                },
                child: new Text("واژه روز",
                  style: TextStyle(fontSize: _menu_font_size, color: _select_text_color ),
                ),
              ),
              width: _width/5.8,
            ) ,
            new Container(width: _width*0.004,),
            new SizedBox(
              child: new RaisedButton(

                textColor: Colors.white,
                color:  _menu_color,
                onPressed:  (){
                  getFaverit(context);
                  Navigator.of(context).pushReplacementNamed('/faverit');
                },
                child: new Text("پسندها",
                  style: TextStyle(fontSize: _menu_font_size),
                ),
              ),
              width: _width/6.3,
            ) ,
            new Container(width: _width*0.004,),
            new SizedBox(
              child: new RaisedButton(

                textColor: Colors.white,
                color:  _menu_color,
                onPressed:   (){
                  Navigator.of(context).pushReplacementNamed('/poyesh');
                },
                child: new Text("پویشگری",
                  style: TextStyle(fontSize: _menu_font_size),
                ),
              ),
              width: _width/5.6,
            ) ,
            new Container(width: _width*0.004,),
            new SizedBox(
              child: new RaisedButton(

                textColor: Colors.white,
                color:  _menu_color,
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed('/about');
                },
                child: new Text("درباره",
                  style: TextStyle(fontSize: _menu_font_size),
                ),
              ),
              width: _width/6.8,
            ) ,
            new Container(width: _width*0.004,),
            new SizedBox(
              child: new RaisedButton(

                textColor: Colors.white,
                color:  _menu_color,
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed('/contact_us');
                },
                child: new Text("تماس", style: TextStyle(fontSize: _menu_font_size),),
              ),
              width: _width/7.1,
            ) ,
            new Container(width: _width*0.009,),



          ],
        )

    );

  }

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
  Color _faveritcolor = Colors.white;
  bool _show = false;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }
  change_color(){
    setState(() {
      if(_color == Colors.yellow[100]){
        _color = Colors.white;
      }else{
        _color = Colors.yellow[100];
      }
    });
    return _color;
  }

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final cart = Provider.of<Cart>(context, listen: false);
    Color _menu_color = _colorFromHex('#A464A6');

    const TextStyle _lable_style = TextStyle(
      color: Colors.blue,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    const TextStyle _text_style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,

    );

    return Scaffold(
        backgroundColor: _colorFromHex("DFD8E8"),
        body:  new ListView(
          children: <Widget>[
            new Column(

                children: <Widget>[

                  new Container(
                    width: _width*0.8,
                    height: _height*0.20,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/logo_text.png"),
                        fit: BoxFit.fill,),

                    ),
                  ),
                  menu_widget(context),
                  new Directionality(
                      textDirection: TextDirection.rtl,
                      child: new Row(

                        children: <Widget>[
                          new Container(
                            width: _width*0.05,

                          ),
                          new Text('واژه روز', style: TextStyle(
                              fontSize: 50, color: Colors.black87, fontFamily: 'IranNastaliq',

                          ),),
                          new Container(
                            width: _width*0.05,
                          ),
                          new Container(
                            width: _width*0.50,
                            height: 0.06*_height,
                            child: new FlatButton(
                              onPressed: (){},

                              color: Colors.grey,
                              textColor: Colors.red,

                              padding: EdgeInsets.all(0.0),
                              child: new Text(cart.daily_word.word,
                                style: TextStyle(fontSize: 0.03*_height, fontWeight: FontWeight.bold),),

                            ),
                          ),
                          new Container(width: _width*0.01,),
                          new Container(
                            width: 0.12*_width,
                            height: 0.06*_height,
                            child: new GestureDetector(
                            child: new Image(image: AssetImage('assets/images/undo.png'),
                              fit: BoxFit.fill, ),
                            onTap: (){

                              setState(() {
                                cart.change_random_word();
                              });

                            },
                          ),
                          ),
                        ],

                      ),
                  ),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        height: 1,
                        width: _width*0.9,
                        color: _menu_color,
                      ),
                      new Container(
                        height: 3,
                      ),
                      new Container(
                        height: 1,
                        width: _width*0.9,
                        color: _menu_color,
                      )


                    ],
                  ),
                  new Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: <Widget>[
                            new Column(
                              children: <Widget>[
                                new Container(height: _height*0.02,),
                                new Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Container(width: _width*0.1, ),
                                    new Container(
                                      width: _width*0.4,
                                      child: new Column(
                                        children: <Widget>[
                                          new Text(cart.daily_word.word.trim(),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'Far_DastNevis',
                                              fontSize: 30,
                                            ),),
                                            new Container(height: _height*0.005,),
                                          new Text(' واژه پارسی آن:', style: _lable_style),
                                          for (String word in cart.daily_word.similar_words)
                                            new Text(word, style: _text_style ),
                                        ],
                                      ),
                                    ),
                                    new Container(width: _width*0.2,),
                                    new Container(
                                      width: _width*0.3,
                                      child: new Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          if (cart.daily_word.spell_word != '-')
                                            new Column(
                                              children: <Widget>[
                                                new Container(height: _height*0.04,),
                                                new Text('از زبان', style: _lable_style),
                                                new Container(height: _height*0.005,),
                                                new Text(cart.daily_word.language, style: _text_style),
                                                new Text(cart.daily_word.spell_word, style: _text_style),

                                              ],
                                            ),
                                          new Container(height: _height*0.02,),
                                          new Column(
                                            children: <Widget>[
                                              new Text('پسند', style: _text_style),
                                              new GestureDetector(
                                                onTap: (){
                                                  print('salam');
                                                  setState(() {
                                                        if (cart.word_color(cart.daily_word.word) == Colors.white){
                                                    print('text');
                                                    setState(() {
                                                      addToFaverit(context, cart.daily_word.word);
                                                    });
                                                  }
                                                  else{
                                                    setState(() {
                                                      removeFromFaverit(context, cart.daily_word.word);
                                                    });

                                                  }
                                                
                                                  });
                                                },
                                                child:
                                                new Container(
                                                  width: 0.08*_width,
                                                  height: 0.04*_height,
                                                  child:  Icon(Icons.favorite, size: 30,
                                                  color: cart.word_color(cart.daily_word.word),

                                                ),

                                                ),
                                                
                                                
                                               

                                              ),

                                            ],
                                          ),


                                        ],
                                      ),
                                    )

                                  ],
                                ),
                                new Container(width: _width*0.9,height: 1, color: _menu_color,)
                              ],
                            ),


                        ],

                      ),
                  ),


                ]
            ),
          ],
        )
    );
  }
}