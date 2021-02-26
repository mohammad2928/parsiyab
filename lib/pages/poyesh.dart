
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parsiyab/pages/about.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart.dart';



class poyesh extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _poyesh();
  }

}

class  _poyesh extends State<poyesh>
    with SingleTickerProviderStateMixin {
  @override


  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
  Color _color = Colors.white;
  bool _a_visible = false;
  bool _b_visible = false;
  String i_category = 'ا';
  getFaverit(BuildContext context) async{
    final cart = Provider.of<Cart>(context);
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
                color:  _select_box_color,
                onPressed:   (){
                },
                child: new Text("پویشگری",
                  style: TextStyle(fontSize: _menu_font_size, color: _select_text_color),
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

   change_color(){
    setState(() {
      if(_color == _colorFromHex('#4472C4')){
        _color = _colorFromHex('#DFD8E8');
      }else{ 
        _color = _colorFromHex('#4472C4');
      }
    });
    return _color;
  }

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    final cart = Provider.of<Cart>(context);

    String _convertListToString(List<String> items){
      String out = '';
      for(var item in items) {
        out += item.trim();
        if (item != items[items.length-1]) {
          out += ' . ';
        }
      }
      return out;
    }

    Widget _show_results(BuildContext context){
      print(i_category);
      double _padding_size = 0.01* _width;
      if (cart.all_categories[i_category] != null){
        return Visibility(
          child: new Table(
            textDirection: TextDirection.rtl,
            columnWidths: {
              0: FractionColumnWidth(.17),
              1: FractionColumnWidth(.40),
              2: FractionColumnWidth(.17),
              3: FractionColumnWidth(.22)
            },
            border: TableBorder.all(color: Colors.blue),
            children: [
              TableRow(
                  decoration: new BoxDecoration(
                      color: _colorFromHex('#2F5597') ) ,
                  children: [
                    TableCell(
                      child: new Container(
                        padding: EdgeInsets.only(right:_padding_size),
                        child:  new Directionality(textDirection: TextDirection.rtl,
                          child: new Text('واژه', style: TextStyle(fontSize: 13, color: Colors.white,
                              fontWeight: FontWeight.bold))),
                      ),
                    ),
                    TableCell(
                      child: new Container(
                        padding: EdgeInsets.only(right:_padding_size),
                        child: new Directionality(textDirection: TextDirection.rtl,
                          child: new Text('برگردان', style: TextStyle(fontSize: 13,
                              fontWeight: FontWeight.bold, color: Colors.white,),)),
                    ),
                      ),
                    TableCell(
                        child: new Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(right:_padding_size),
                          child:  new Directionality(textDirection: TextDirection.rtl,
                            child: new Text(

                              'زبان بنیادی',

                              style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.white,),
                            )
                        ),
                        ),
                    ),
                    TableCell(
                        child: new Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(right:_padding_size),
                          child: new Directionality(textDirection: TextDirection.rtl,
                            child: new Text(

                              'نویسه بنیادی',

                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white,),
                            )
                        ),
                        ),
                    ),
                  ]
              ),

              for (var item in cart.all_categories[i_category])

                TableRow(
                    decoration: new BoxDecoration(
                        color: change_color()),
                    children: [
                      TableCell(
                        child: Container(
                          padding: EdgeInsets.only(right:_padding_size),
                          child: new Directionality(
                            
                            textDirection: TextDirection
                                .rtl,
                            child: new Text(item.word, style: TextStyle(fontSize: 13),)),
                      ),
                        ),
                      TableCell(
                          child: new Container(
                            padding: EdgeInsets.only(right:_padding_size),
                            child: new Directionality(
                            textDirection: TextDirection
                                .rtl,
                            child: new Text(_convertListToString(item.similar_words)),
                          ),
                          ),
                      ),
                      TableCell(
                        child: new Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(right:_padding_size),
                          child: new Directionality(
                            textDirection: TextDirection
                                .rtl,
                            child: new Text( item.language != '-' ? item.language : ' ' , style: TextStyle(fontSize: 13),)),
                        ),
                      ),
                      TableCell(
                        child: new Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(right:_padding_size),
                          child: new Directionality(
                            textDirection: TextDirection
                                .rtl,
                            child: new Text(  item.spell_word != '-' ? item.spell_word : ' ', style: TextStyle(fontSize: 13),)),
                        ),
                      ),

                    ]
                )
            ],
          ),
          visible: cart.visibility[i_category],
        );
      }
      else{
        return Container();
      }


    }

    Widget alphabet_butons(){

      return Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var w_i in ['ا', 'ب', 'پ', 'ت', 'ث', 'ج', 'چ', 'ن' ])
              new SizedBox(
                child: new FlatButton(
                  padding: const EdgeInsets.all(1),
                  child: new Stack(
                    children: <Widget>[
                      Image.asset('assets/images/icon1.png',),
                      new Padding(
                          padding: EdgeInsets.all(1),
                          child: new Center(child: new Text(w_i,

                            style: TextStyle(fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),)
                      )
                    ],
                  ),

                  onPressed: () {
                    setState(() {
                      Provider
                          .of<Cart>(context, listen: false)
                          .visibility[w_i] =  !Provider
                          .of<Cart>(context, listen: false)
                          .visibility[w_i];
                    });
                    i_category = w_i;

                  },
                ),
                width: _width * 0.12,
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var w_i in ['ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'ژ', 'و' ])
                new SizedBox(
                  child: new FlatButton(
                    padding: const EdgeInsets.all(1),
                    child: new Stack(
                      children: <Widget>[
                        Image.asset('assets/images/icon1.png',),
                        new Padding(
                            padding: EdgeInsets.all(1),
                            child: new Center(child: new Text(w_i,

                              style: TextStyle(fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),)
                        )
                      ],
                    ),

                    onPressed: () {
                      setState(() {
                        Provider
                            .of<Cart>(context, listen: false)
                            .visibility[w_i] =  !Provider
                            .of<Cart>(context, listen: false)
                            .visibility[w_i];
                      });
                      i_category = w_i;

                    },
                  ),
                  width: _width * 0.12,
                ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var w_i in ['س', 'ش', 'ص', 'ض', 'ط', 'ظ', 'ع', 'ه' ])
                new SizedBox(
                  child: new FlatButton(
                    padding: const EdgeInsets.all(1),
                    child: new Stack(
                      children: <Widget>[
                        Image.asset('assets/images/icon1.png',),
                        new Padding(
                            padding: EdgeInsets.all(1),
                            child: new Center(child: new Text(w_i,

                              style: TextStyle(fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),)
                        )
                      ],
                    ),

                    onPressed: () {
                      setState(() {
                        Provider
                            .of<Cart>(context, listen: false)
                            .visibility[w_i] =  !Provider
                            .of<Cart>(context, listen: false)
                            .visibility[w_i];
                      });
                      i_category = w_i;

                    },
                  ),
                  width: _width * 0.12,
                ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              for (var w_i in ['غ', 'ف', 'ق', 'ک', 'گ', 'ل', 'م', 'ی' ])
                new SizedBox(
                  child: new FlatButton(
                    padding: const EdgeInsets.all(1),
                    child: new Stack(
                      children: <Widget>[
                        Image.asset('assets/images/icon1.png',),
                        new Padding(
                            padding: EdgeInsets.all(1),
                            child: new Center(child: new Text(w_i,

                              style: TextStyle(fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),
                            ),)
                        )
                      ],
                    ),

                    onPressed: () {
                      setState(() {
                        Provider
                            .of<Cart>(context, listen: false)
                            .visibility[w_i] =  !Provider
                            .of<Cart>(context, listen: false)
                            .visibility[w_i];
                      });
                      i_category = w_i;

                    },
                  ),
                  width: _width * 0.12,
                ),
            ],
          ),

        ],

      );

    }



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
                  new Container(height: _height*0.01,),
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        height: 1,
                        width: _width*0.9,
                        color: _colorFromHex('#A464A6'),
                      ),
                      new Container(
                        height: 3,
                      ),
                      new Container(
                        height: 1,
                        width: _width*0.9,
                        color: _colorFromHex('#A464A6'),
                      )


                    ],
                  ),
                  alphabet_butons(),
                  new Container(height: _height*0.05,),
                  _show_results(context),


                ]
            ),
          ],
        )
    );
  }
}