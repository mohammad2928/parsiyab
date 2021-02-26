

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parsiyab/pages/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import  'package:string_similarity/string_similarity.dart';


class Cart with ChangeNotifier {

  List<Data> all_words = [];
  List<Data> found_items = [];
  Map<String, Data> dict_words = {};
  List<String> words = [];
  List<Data> faverit_words = [];
  Data daily_word;
  Map<String, List<Data>> all_categories= {};
  Map<String, bool> visibility = {};
  Map<String, Color> word_colors = {};

  List<Data> closets_words= [];
  List<String> alphabet = [];
  Map<String, List<Data>> search_dict= {};

  String preprocessing(String x){
    x = x.replaceAll('آ', 'ا');
    x = x.replaceAll('ُ', '');
    x = x.replaceAll('َ', '');
    x = x.replaceAll('ِ', '');
    x = x.toLowerCase();
    return x;
  }

  void makeSearchDict(){
    List<String> seenwords = [];
    for (String word in dict_words.keys ){
      String p_word = preprocessing(word);
      if (seenwords.contains(p_word)){
        search_dict[p_word].add(dict_words[word]);
      }
      else{
        search_dict[p_word] = [dict_words[word]];
        seenwords.add(p_word);
      }




    }


    for (String word in dict_words.keys ) {
      String p_word = preprocessing(dict_words[word].spell_word);
      if (p_word != '-') {
        if (seenwords.contains(p_word)) {
          search_dict[p_word].add(dict_words[word]);
        }
        else {
          search_dict[p_word] = [dict_words[word]];
          seenwords.add(p_word);
        }
      }
    }

  }

  void makeFaveritList(List<String> f_words){
    List<Data> faverit_words1= [];
    for(var item in f_words){
      if (dict_words.containsKey(item.trim())){
        faverit_words1.add(dict_words[item.trim()]);
      }
    }
    faverit_words = faverit_words1;

  }
  void random_word() async{
    DateTime now = new DateTime.now();
    final yesterday = await SharedPreferences.getInstance();
    DateTime old_day  = yesterday.getStringList('yesterday') ?? now;
    final _random = new Random();
    if (old_day != now){
      daily_word = all_words[_random.nextInt(all_words.length)];
    }else{
      daily_word = daily_word ?? all_words[0];
    }
    
  }

void change_random_word() async{

    final _random = new Random();

    daily_word = all_words[_random.nextInt(all_words.length)];

    
  }

  void categories(){
    List<String> cats = [];
    for(var item in all_words){
      if (cats.contains(item.category)){
        all_categories[item.category].add(item);
      }
      else{
        all_categories[item.category] = [item];
        cats.add(item.category);
        visibility[item.category] = false;
      }
    }

  }

  Color word_color(String word){
    if (words.contains(word)){
      return word_colors[word];
    }else{
      return Colors.white;
    }

  }
  void add_words(Data newword){

    all_words.add(newword);
    notifyListeners();
  }
  void initiate(){
    for(var item in all_words){
      dict_words[item.word] = item;
      words.add(item.word);
      word_colors[item.word] = Colors.white;
    }


  }
  void search(String word){

    String p_word = preprocessing(word.trim());

    if (search_dict.containsKey(p_word)){
      found_items = search_dict[p_word];
    }
    else{
      found_items = [];
      var match_string = StringSimilarity.findBestMatch(p_word, search_dict.keys.toList());
      print(match_string);
      int index = match_string.bestMatchIndex;
      found_items = search_dict[search_dict.keys.toList()[index]];
    }

  }

}
