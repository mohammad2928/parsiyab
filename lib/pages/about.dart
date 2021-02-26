
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parsiyab/pages/poyesh.dart';
import 'package:parsiyab/pages/search_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cart.dart';
import 'contact_us.dart';
import 'daily_word.dart';
import 'faverit.dart';

class about extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return aboutPage();
  }

}

class aboutPage extends State<about> with SingleTickerProviderStateMixin {
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
                color:  _select_box_color,
                onPressed: (){
                },
                child: new Text("درباره",
                  style: TextStyle(fontSize: _menu_font_size, color: _select_text_color),
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

  String text1 =  """ 
  
فرهنگستان ایران درخرداد ۱۳۱۴ بفرمان رضاشاه بزرگ بنیاد نهاده شد، تا استادان و فرهیختگان بلند پایه ایران گرد هم آیند وجایگزینی برای واژگان بیگانه که درزبان پارسی فراوان بود بیابند و زبان پارسی را پاکیزه کنند.  این فرهنگستان تا اسفند ۱۳۱۹ برپا بود. سپس درزمان پادشاهی محمد رضا شاه دوباره بکار خود پیگیر شد تا توانست بسیاری ازواژگان بیگانه را به واژگان پارسی  برگردان کند.
گرچه استادان بزرگی چون دهخحدا، معین، عمید، ابوالقاسم پرتو، ذبیح بهروز وکسانی که درپایان این دفتر نام آنها آمده است، با نوشتن فرهنگنامه ها برای پالایش زبان پارسی، کوشش فراوان کرده اند، ولی جای یک واژه نامه برگزیده و کوچک شده درتارنما خالی بود. نویسنده با بهره گیری ازفرهنگ نامه ها وواژه نامه های ارزشمند این استادان، و دیگر دیوانها چون شاهنامه این پالیده را که دست رسی بآن آسان است، درتارنما گذاشت وبه خوانندگان وبهره وران پیشکش کرد تا دوستداران گفتار ونوشتار پارسی بشیوه رایگان ازآن بهره مند شوند. دراین واژه نامه برای همه واژگان بیگانه چندین برابر پارسی آمده است، تا پارسی گویان بتوانند برپایه نیاز، یکی ازآنها را در گفتار ونوشتار خود بکار گیرند.
بن مایه ها در پایان آمده است.
پروردگار جان وخرد را سپاس باد، که بمن زندگی داد تا درهشتاد ونهمین سال زندگی و درروز پنجشنبه ۲۳ شهریور ۱۳۹۸ برابر با ۱۲ سپتامر ۲۰۱۹ ترسایی ، اینکارسترگ را که بازده تلاش دانشمندان بزرگی درگذشته بود، رایگان برروی تارنما ودردسترس همگان بگذارم.  
""";



  String text3 = """
  برای فراهم آوری این واژه نامه افزون برواژه های پذیرفته شده ازسوی فرهنگستان ایران، از واژه نامه های پارسى چون فرهنگ معین، فرهنگ دهخدا، برهان قاطع، فرهنگ آنندراج، همچنین از نسک های زیر نیز بهره برده شده است:
  """;

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    double _padding_size = _width*0.05;
    String text2 = """
      منوچهرسلیمانی
      استاکتون، کالیفرنیا، آمریکا
      """;
    Widget bullet(BuildContext context){
      return new Container(
        height: 8.0,
        width: 8.0,
        padding: EdgeInsets.only(right: 20),
        decoration: new BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      );
    }
    return Scaffold(
      backgroundColor: _colorFromHex("DFD8E8"),
//      appBar: PreferredSize(
//        preferredSize: Size.fromHeight(_width*0.18),
//
//        child: AppBar(
//          elevation: 0.0,
//          backgroundColor: _colorFromHex("DFD8E8"),
//          brightness: Brightness.dark ,
//          automaticallyImplyLeading: false,
//
//          flexibleSpace: new Container(
//
//            alignment: Alignment.center,
//            decoration: new BoxDecoration(
//
//              image: new DecorationImage(image: new AssetImage("assets/images/logo.png"), fit: BoxFit.fitHeight ),
//            ),
//          ),
//        ),
//      ),
      body:  new ListView(
        children: <Widget>[
          new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              new Center(
                  child: new Container(
                    width: _width*0.8,
                    height: _height*0.20,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("assets/images/logo_text.png"),
                        fit: BoxFit.fill,),

                    ),
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
                  height: _height*0.005,
                ),
                new Padding(padding: EdgeInsets.only(right:_padding_size),
                child: new Text(text1,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16,  color: Colors.black87, ),
                ),
                ),
                
                
                new Row(

                  children: [
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  new Container(padding: EdgeInsets.only(right:_padding_size),
                              child: new Text('منوچهر سلیمانی',
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 16,  color: Colors.black87, ),
                              ),
                            ),
                  new Container(height: 0.01*_height,),   
                  new Container(
                    padding: EdgeInsets.only(right:_padding_size),
                    child:    new InkWell(
                    child: Directionality(
                          textDirection: TextDirection.rtl,

                          child: new Text("www.manouchehrsoleimani.com",
                            style: TextStyle(fontSize: 15, color: Colors.blue,
                              decoration: TextDecoration.underline,),
                          ),
                        ),
                        onTap: () => launch('https://www.manouchehrsoleimani.com'),
                  ),
                  ),

                 new Container(height: 0.02*_height,),                 
                new Container(padding: EdgeInsets.only(right:_padding_size),
                    child: new InkWell(
                      child: Directionality(
                        textDirection: TextDirection.rtl,

                        child: new Text("www.parsiyab.org",
                          style: TextStyle(fontSize: 15, color: Colors.blue,
                            decoration: TextDecoration.underline,),
                        ),
                      ),
                      onTap: () => launch('https://www.parsiyab.org'),
                    )
                ),

                      ],

                    ),
                    new Container(
                      width: 0.35*_width,
                      height: 0.2*_height,
                      child: Image.asset('assets/images/baba.jpg'),
                    )
                  ],
                ),
           
            
        //link

                new Container(height: _height*0.09,),
                new Container(padding: EdgeInsets.only(right:_padding_size),
                  child: new Text('بن مایه ها',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,  color: Colors.blue, ),
                  ),
                ),
                new Container(padding: EdgeInsets.only(right:_padding_size),
                  child: new Text(text3,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 16,  color: Colors.black87, ),
                  ),
                ),
                new Column(
                    children: <Widget>[
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('ابولقاسم پرتو: " :فرهنگ برابرهای پارسى واژگان بیگانه" درسه پوشینه ازانتشارات اساطیر۱۳۷۷'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('همورس جاللى: "فرهنگ پایه به پارسى سره" انتشارات ابن سینا، تهران ۱۳۵۴'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text(' كسروی:" واژه نامه پارسى پاک، چاپ باهماد آزادگان و شركت سهامى چاپاک، تهران ۱۳۲۳'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('محسن شاملو:" واژه های فارسى" انتشارات پدیده، تهران ۱۳۵۴'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('مهرانگیز فرمین: "واژه نامه كوچک زبان پارسى" انتشارات فرهنگ ایران، پاریس ۱۳۸۶'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('فریده رازی: "فرهنگ واژه های فارسى سره" نشر مركز، تهران ۱۳۸۹'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('امیرحسین اكبری شالچى: ،" فرهنگ گویشى خراسان بزرگ" نشر مركز، تهران، ۱۳۷۰'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('بهرام فره وشى : "فرهنگ زبان پهلوی" انتشارات دانشگاه تهران، ۱۳۸۵'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('محمود پاینده لنگرودی: "فرهنگ گیل دیلم" ، فارسی به گیلکی، انتشارات امیر کبیر، تهران ۱۳۶۶'),
                      ),
                      new ListTile(
                        leading: bullet(context),
                        title: new Text('"فارسى تاجیكى" انتشارات فرهنگ معاصر تهران،  ۱۳۸۵'),
                      ),
                    ],
                ),



              ]
          ),
        ],
      )
    );
  }
}