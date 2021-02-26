
import 'package:flutter/material.dart';
import 'package:parsiyab/pages/about.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cart.dart';
import 'package:email_launcher/email_launcher.dart';

class contactUs extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return contactUsPage();
  }

}

class contactUsPage extends State<contactUs> with SingleTickerProviderStateMixin {

    final _toController = TextEditingController();
  final _ccController = TextEditingController();
  final _bccController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  
  
  @override

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
                color: _select_box_color,
                onPressed: (){
                },
                child: new Text("تماس", style: TextStyle(fontSize: _menu_font_size, color: _select_text_color),),
              ),
              width: _width/7.1,
            ) ,
            new Container(width: _width*0.009,),



          ],
        )

    );

  }

  void _launchEmail() async {
    List<String> to = ["parsiyab@gmail.com"];

    String subject = "Your Subject";
    String body = "Your body";

    Email email = Email(to: to,  subject: subject, body: body);
    await EmailLauncher.launch(email);
  }

final Uri _emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'parsiyab@gmail.com',
  queryParameters: {
    'subject': 'Subject'
  }
);

  Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
  String long_text = """
    خواهشمندیم اگر از برنامه ما خوشتان آمد به دوستان خود پیشنهاد کنید و روی اپ استور امتیاز بدهید.
    سپاس!
  """;
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: _colorFromHex("DFD8E8"),
//        appBar: PreferredSize(
//          preferredSize: Size.fromHeight(_width*0.18),
//
//          child: AppBar(
//            elevation: 0.0,
//            backgroundColor: _colorFromHex("DFD8E8"),
//            brightness: Brightness.dark ,
//            automaticallyImplyLeading: false,
//
//            flexibleSpace: new Container(
//
//              alignment: Alignment.center,
//              decoration: new BoxDecoration(
//
//                image: new DecorationImage(image: new AssetImage("assets/images/logo.png"), fit: BoxFit.fitHeight ),
//              ),
//            ),
//          ),
//        ),
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
                    height: _height*0.03,
                  ),
                  new Column(
                    children: <Widget>[
                      new Directionality(
                        textDirection: TextDirection.rtl,
                        child: new Text("ایمیل تماس با ما:",
                          style: TextStyle(fontSize: 25, color: Colors.black87, fontWeight: FontWeight.bold ),
                        )
                        ,
                      ),

                    new InkWell(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: new Text("parsiyab@gmail.com",

                              style: TextStyle(fontSize: 25, color: Colors.blue, fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline),
                            )
                            ,
                          ),
                          onTap: () => launch(_emailLaunchUri.toString()),
                        ),
                      new Container(height: _height*0.05,),
                      new InkWell(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: new Text("www.parsiyab.org",

                            style: TextStyle(fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          )
                          ,
                        ),
                        onTap: () => launch('https://www.parsiyab.org'),
                      ),
                      new Container(height: _height*0.05,),
                      new InkWell(
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: new Text("www.manouchehrsoleimani.com",

                            style: TextStyle(fontSize: 20, color: Colors.blue,
                                decoration: TextDecoration.underline),
                          )
                          ,
                        ),
                        onTap: () => launch('http://manouchehrsoleimani.com/'),
                      ),
                      new Container(height: _height*0.01,),
                      new Container(height: _height*0.05,),
                      new Container(
                        child: new Directionality(
                          textDirection: TextDirection.rtl,
                          child: new Text(long_text,

                            style: TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                          ,
                        ),
                        width: _width*0.97,
                      ),
                      new Container(height: _height*0.06,),
                      new Container(
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: _width*0.05),
                        child: new Directionality(
                          textDirection: TextDirection.ltr,
                          child: new Text('© 2020-2021 Manouchehr Soleimani',

                            style: TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                          ,
                        ),

                      ),

                    ],
                  )

                ]
            ),
          ],
        )
    );
  }
}