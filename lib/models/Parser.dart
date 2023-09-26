import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class Parser {
  Future loadRss() async {
    final url = Uri.parse("https://www.france24.com/fr/rss");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      RssFeed feed = RssFeed.parse(response.body.toString());
      return feed.items;
    } else {
      debugPrint("erreur: ${response.statusCode}");
    }
  }
}
