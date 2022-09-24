import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import 'dart:convert';

class QuoteList with ChangeNotifier {
  Random randomSeed = Random();
  List<Quote> _list = [Quote(title: 'There are no Quotes')];
  final String key = "quoteList";

  // _initPref() is to iniliaze  the _pref variable
  late SharedPreferences _pref;
  _initPrefs() async {
    _pref = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    List<String>? listString = _pref.getStringList(key);
    if (listString != null) {
      _list =
          listString.map((item) => Quote.fromMap(json.decode(item))).toList();
    }
    genRandom();
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    List<String> stringList =
        _list.map((item) => json.encode(item.toMap())).toList();
    _pref.setStringList(key, stringList);
  }

  String _random = '';

  List<Quote> get quotes => _list;
  String get random => _random;

  QuoteList() {
    //initializer
    _loadFromPrefs();
  }

  void addQuote(Quote item) {
    if (item.title == '') return;
    _list.insert(0, item);
    notifyListeners();
  }

  void editQuote(Quote item, String title) {
    if (title == '') return;
    item.title = title;
    notifyListeners();
  }

  void deleteQuote(Quote item) {
    _list.remove(item);
    notifyListeners();
  }

  void saveData() {
    _saveToPrefs();
  }

  void genRandom() {
    if (_list.isEmpty) return;
    _random = _list[randomSeed.nextInt(_list.length)].title;
    notifyListeners();
  }

  void writeList(List<Quote> arg) {
    _list = arg;
  }

  void restoreDefaults() async {
    await _pref.clear();
    _list = [
      Quote(
          title:
              "愛是恆久忍耐，又有恩慈；愛是不嫉妒；愛是不自誇，不張狂，不做害羞的事，不求自己的益處，不輕易發怒，不計算人的惡。哥林多前書13:4-5"),
      Quote(title: "要常常喜樂，不住的禱告，凡事謝恩；因為這是神在基督耶穌裡向你們所定的旨意。帖撒羅尼迦前書5:16-18"),
      Quote(
          title:
              "應當一無罣慮，只要凡事藉著禱告、祈求，和感謝，將你們所要的告訴神。神所賜、出人意外的平安必在基督耶穌裡保守你們的心懷意念。腓立比書4:6-7"),
      Quote(
          title: "我今日所吩咐你的話都要記在心上，也要殷勤教訓你的兒女。無論你坐在家裡，行在路上，躺下，起來，都要談論。申命記6:6-7"),
      Quote(
          title:
              "倚靠耶和華、以耶和華為可靠的，那人有福了！他必像樹栽於水旁，在河邊扎根，炎熱來到，並不懼怕，葉子仍必青翠，在乾旱之年毫無掛慮，而且結果不止。耶利米書17:7-8"),
      Quote(title: "願耶和華賜福給你，保護你。願耶和華使他的臉光照你，賜恩給你。願耶和華向你仰臉，賜你平安。民數記6:24-26"),
      Quote(title: "所以我告訴你們，凡你們禱告祈求的，無論是甚麼，只要信是得著的，就必得著。馬可福音11:24"),
      Quote(title: "凡你們所做的都要憑愛心而做。哥林多前書16:14"),
      Quote(title: "但那等候耶和華的必從新得力。他們必如鷹展翅上騰；他們奔跑卻不困倦，行走卻不疲乏。以賽亞書40:31"),
      Quote(
          title:
              "求他按著他豐盛的榮耀，藉著他的靈，叫你們心裡的力量剛強起來，使基督因你們的信，住在你們心裡，叫你們的愛心有根有基。以弗所書3:16-17"),
      Quote(
          title:
              "你不要害怕，因為我與你同在；不要驚惶，因為我是你的神。我必堅固你，我必幫助你；我必用我公義的右手扶持你。以賽亞書41:10"),
      Quote(title: "你所做的，要交託耶和華，你所謀的，就必成立。箴言16:3"),
      Quote(title: "求你使我清晨得聽你慈愛之言，因我倚靠你；求你使我知道當行的路，因我的心仰望你。詩篇143:8"),
      Quote(title: "耶和華說：我知道我向你們所懷的意念是賜平安的意念，不是降災禍的意念，要叫你們末後有指望。耶利米書29:11"),
      Quote(title: "因我們行事為人是憑著信心，不是憑著眼見。哥林多後書5:7"),
      Quote(title: "凡事謙虛、溫柔、忍耐，用愛心互相寬容。以弗所書4:2"),
      Quote(title: "但願使人有盼望的神，因信將諸般的喜樂、平安充滿你們的心，使你們藉著聖靈的能力大有盼望。羅馬書15:13"),
      Quote(title: "你們要事奉耶和華你們的神，他必賜福與你的糧與你的水，也必從你們中間除去疾病。出埃及記23:25"),
    ];
  }
}

class Quote {
  String title;
  bool completed;

  Quote({
    required this.title,
    this.completed = false,
  });

  Quote.fromMap(Map map)
      : title = map['title'],
        completed = map['completed'];

  Map toMap() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}
