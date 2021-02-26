
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parsiyab/pages/about.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart.dart';



class faverit extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _faverit();
  }

}

class  _faverit extends State<faverit>
    with SingleTickerProviderStateMixin {
  @override

  Color _color = Colors.white;

  getFaverit(BuildContext context) async{
    final cart = Provider.of<Cart>(context);
    final _faverit = await SharedPreferences.getInstance();
    List words = _faverit.getStringList('faverit') ?? [];
    cart.makeFaveritList(words);

  }
  Widget menu_widget(BuildContext context){
    final cart = Provider.of<Cart>(context);
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
                color:  _select_box_color,
                onPressed:  (){
                },
                child: new Text("پسندها",
                  style: TextStyle(fontSize: _menu_font_size, color: _select_text_color),
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
    double _padding_size = 0.01* _width;

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
                  new Container(height: _height*0.003,),
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
                  new Container(
                    height: _height*0.02,
                  ),
                  new Container(
                    child: new Column(
                      children: <Widget>[
                        new Container(height: _height*0.02,),
                        new Table(
                          textDirection: TextDirection.rtl,
                          columnWidths: {0: FractionColumnWidth(.17),
                            1: FractionColumnWidth(.40),
                            2: FractionColumnWidth(.17),
                            3: FractionColumnWidth(.22)},
                          border: TableBorder.all(color: Colors.black),
                          children: [
                            TableRow(
                                decoration: new BoxDecoration(
                                    color: _colorFromHex('2F5597') ) ,
                                children: [
                                  TableCell(
                                    child: Container(
                                      padding: EdgeInsets.only(right:_padding_size),
                                      child: new Directionality(textDirection: TextDirection.rtl,
                                        child: new Text('واژه', style: TextStyle(fontSize: 13,
                                            fontWeight: FontWeight.bold, color: Colors.white),)),
                                    ),
                                  ),
                                  TableCell(
                                    child: new Container(
                                      padding: EdgeInsets.only(right:_padding_size),
                                      child: new Directionality(textDirection: TextDirection.rtl,
                                        child: new Text('برگردان', style: TextStyle(fontSize: 13,
                                            fontWeight: FontWeight.bold, color: Colors.white),)),
                                    ),
                                  ),
                                  TableCell(
                                      child: Container(
                                        padding: EdgeInsets.only(right:_padding_size),
                                        alignment: Alignment.center,
                                        child: new Directionality(textDirection: TextDirection.rtl,
                                          child: new Text(

                                            'زبان بنیادی',

                                            style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.white),
                                          )
                                      ),
                                      ),
                                  ),
                                  TableCell(
                                      child: Container(
                                        padding: EdgeInsets.only(right:_padding_size),
                                        alignment: Alignment.center,
                                        child: new Directionality(textDirection: TextDirection.rtl,
                                          child: new Text(

                                            'نویسه بنیادی',

                                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
                                          )
                                      ),
                                      ),
                                  ),
                                ]
                            ),
                            for (var item in cart.faverit_words)

                              TableRow(
                                  decoration: new BoxDecoration(
                                      color: change_color() ) ,
                                  children: [
                                    TableCell(
                                      child: new Container(
                                        padding: EdgeInsets.only(right:_padding_size),
                                        child: new Directionality(textDirection: TextDirection.rtl,
                                          child: new Text(item.word, style: TextStyle(fontSize: 13),)),
                                      ),
                                    ),
                                    TableCell(
                                        child: Container(
                                          padding: EdgeInsets.only(right:_padding_size),
                                          child: new Directionality(textDirection: TextDirection.rtl,
                                            child: new Text(
                                              _convertListToString(item.similar_words),
                                              style: TextStyle(fontSize: 13),
                                            )
                                        ),
                                        ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: EdgeInsets.only(right:_padding_size),
                                        alignment: Alignment.center,
                                        child: new Directionality(textDirection: TextDirection.rtl,
                                          child: new Text(item.language != '-' ? item.language : ' ', style: TextStyle(fontSize: 13),)),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        padding: EdgeInsets.only(right:_padding_size),
                                        alignment: Alignment.center,
                                        child: new Directionality(textDirection: TextDirection.rtl,
                                          child: new Text( item.spell_word != '-' ? item.spell_word : ' ', style: TextStyle(fontSize: 13),)),
                                      ),
                                    ),

                                  ]
                              )
                          ],
                        ),
                        new Container(height: _height*0.02,),


                      ],
                    ),
                    color: _colorFromHex('DFD8E8'),

                  ),
//                  new RaisedButton(
//                    child: Text('برگشت'),
//                    onPressed: () {
//                      Navigator.pop(context);
//                    },
//                  ),

                ]
            ),
          ],
        )
    );
  }
}