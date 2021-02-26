
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:parsiyab/pages/about.dart';
import 'package:parsiyab/pages/cart.dart';
import 'package:parsiyab/pages/contact_us.dart';
import 'package:parsiyab/pages/daily_word.dart';
import 'package:parsiyab/pages/faverit.dart';
import 'package:parsiyab/pages/poyesh.dart';
import 'package:provider/provider.dart';
import 'package:search_widget/search_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';
import 'package:flutter/services.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchPage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchPageState();
  }

}


class  SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {

  final textController = TextEditingController();
  Color _faveritcolor = Colors.white;
  bool _show = false;
  bool autovisible =false;
  bool _result_visible = false;



  addToFaverit(BuildContext context, String word) async{

    var cart = Provider.of<Cart>(context, listen: false);


    if (word != null && word != ' ' && word != '' && cart.words.contains(word)){
      final  _faverit = await SharedPreferences.getInstance();
      List<String> words = _faverit.getStringList('faverit') ?? [];
      words.add(word);
      await _faverit.setStringList("faverit", words);
      if (cart.words.contains(word)){
        Provider.of<Cart>(context, listen: false).word_colors[word] = Colors.red;

      }

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
  getFaverit(BuildContext context) async{
    final cart = Provider.of<Cart>(context, listen: false);

    final _faverit = await SharedPreferences.getInstance();
    List words = _faverit.getStringList('faverit') ?? [];
    cart.makeFaveritList(words);

  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  @override


  Widget menu_widget(BuildContext context){
    final cart = Provider.of<Cart>(context, listen: false);

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    Color _menu_color = _colorFromHex('#A464A6');
    double _menu_font_size = 11.5;
    Color _select_box_color = _colorFromHex('#A2B5CD');
    Color _select_text_color = _colorFromHex('#A464A6');
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
              color:  _select_box_color,
              onPressed:   (){

              },
              child: new Text("جستجو",
              style: TextStyle(fontSize: _menu_font_size, color: _select_text_color),
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
              color:  _menu_color,
              onPressed:   (){
                cart.random_word();
                Navigator.of(context).pushReplacementNamed('/daily_word');
                },
              child: new Text("واژه روز",
                style: TextStyle(fontSize: _menu_font_size),
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


  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context, listen: false);

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    Color _menu_color = _colorFromHex('#A464A6');
    test(BuildContext context){
      final cart = Provider.of<Cart>(context, listen: false);
      print(cart.word_colors);
      return Container();
    }

    Widget autocomplete(BuildContext context){
      List<String> out_test = [];
      if (textController.text.trim() != '' ){
        for(var item in cart.words){
          if (item.contains(textController.text.trim())){out_test.add(item);}
        }
        setState(() {
          autovisible = true;
        });

        return Container(
          height: _height*0.2,
          child: ListView(
            children: <Widget>[
              for (var item in out_test) new Text(item)
            ],
          ),
        );
      }
      else{

        setState(() {
          autovisible = false;
        });

        return Container();
      }

    }

    Widget show_result(BuildContext context){
        cart.search(textController.text);
        double _text_font_size  = 20;
        double _lable_font_size = 20;
        const TextStyle _lable_style = TextStyle(
          color: Colors.blue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        );
        const TextStyle _text_style = TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,

        );

        if (cart.found_items != [] && textController.text != ''){
          setState(() {
            _result_visible = true;
          });

          return Column(
            children: <Widget>[
              for(Data found_item in cart.found_items)
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
                              new Text(found_item.word.trim(),
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Far_DastNevis',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),),
                              new Container(height: _height*0.02,),
                              new Text('واژه پارسی آن:', style: _lable_style),
                              for (String word in found_item.similar_words)
                                new Text(word, style: _text_style ),
                            ],
                          ),
                        ),
                        new Container(width: _width*0.2,),
                        new Container(
                          width: _width*0.2,
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              if (found_item.language != '-')
                                new Column(
                                  children: <Widget>[
                                    new Container(height: _height*0.04,),
                                    new Text('از زبان', style: _lable_style),
                                    new Container(height: _height*0.005,),
                                    new Text(found_item.language, style: _text_style),
                                    new Text(found_item.spell_word, style: _text_style),

                                  ],
                                ),
                              new Container(height: _height*0.02,),
                              new Column(
                                children: <Widget>[
                                  if (found_item.language == '-')
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        new Container(height: _height*0.15,),
                                        new Text('پسند', style: _text_style),
                                        new Container(

                                          child: new GestureDetector(
                                                
                                                onTap: (){
                                                  setState(() {
                                                     Color _c = cart.word_color(found_item.word);
                                                  print('dshdksgjskghdsghs');
                                                  if (_c== Colors.white){
                                                    print('texttttt');
                                                    setState(() {
                                                      addToFaverit(context, found_item.word);
                                                    });
                                                  }
                                                  else{
                                                    setState(() {
                                                      removeFromFaverit(context, found_item.word);
                                                    });

                                                  }

                                                  });
                                                 

                                                },
                                                child: new Container(
                                                  width: 0.08*_width,
                                                  height: 0.04*_height,
                                                  child: Icon(Icons.favorite, size: 30,
                                                  color: cart.word_color(found_item.word),

                                                ),

                                                ),

                                              ), 

                                        ),
                                      ],
                                    )
                                  else
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[

                                        new Text('پسند', style: _text_style),
                                        new GestureDetector(
                                          onTap: (){



                                            if (cart.word_color(found_item.word) == Colors.white){
                                              print('text');
                                              setState(() {
                                                addToFaverit(context, found_item.word);
                                              });
                                            }
                                            else{
                                              setState(() {
                                                removeFromFaverit(context, found_item.word);
                                              });

                                            }

                                          },
                                          child: Icon(Icons.favorite, size: 30,
                                            color: cart.word_color(found_item.word),

                                          ),

                                        ),
                                      ],
                                    ),

                                ],
                              ),


                            ],
                          ),
                        ),

                      ],
                    ),
                    new Container(width: _width*0.9,height: 1, color: _menu_color,)
                  ],
                ),


            ],

          );
        }

        else{return Container();}

    }

    return new Scaffold(

        backgroundColor: _colorFromHex("DFD8E8"),


        body: new ListView(
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
                menu_widget(context), //menu
                new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: <Widget>[
                        new Container(
                          width: _width*0.05,
                        ),

                        new GestureDetector(
                          child: new Image(image: AssetImage('assets/images/search1.png')
                            , width: _width*0.10, height: _height*0.1,),
                          onTap: (){

                            cart.search(textController.text);
                            setState(() { _show = true; });

                          },
                        ),
                        new Container(width: _width*0.0001,),
                        new Container(
                            height: 0.06*_height,
                            width: 0.6*_width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),


                            child: new Container(
                              color: Colors.white,
                              
                              // height: _height*0.02,
                              child: TextField(
                                cursorColor: Colors.black,
                                style: TextStyle(fontSize: 17, decoration: TextDecoration.none),
                                controller: textController,
                                decoration: InputDecoration(
            
                                  contentPadding: EdgeInsets.only(bottom:12, right: 15),
                                  
                                  hintText: '',
                                  //border:  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),


                                ),
                                maxLines: 1,

                                autofocus: false,

                                onSubmitted: (text){

                                  cart.search(text);
                                  setState(() { _show = true; });

                                },


                              ),
                              width: _width*0.60,


                            )

                        ),
                        // new GestureDetector(
                        //   child: new Image(image: AssetImage('assets/images/search2.png')
                        //     , width: _width*0.1, height: _height*0.1,),
                        //   onTap: (){},
                        // ),



                      ],
                    ),

                  ],
                ), //search
                new Container(
                  height: _height*0.0001,
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
                ),  // two lines
              new Container(
                child: new Visibility(
                    child: show_result(context),
                  visible: _result_visible,
                ),
              )





              ],

            ),


          ],
        ),


    );
  }







}


