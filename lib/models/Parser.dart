import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class Parser {
  Future loadRss() async {
    final url = Uri.parse("https://www.france24.com/fr/rss");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      RssFeed feed = RssFeed.parse(response.body.toString());
      return feed.items;
    } else {
      print("erreur: ${response.statusCode}");
    }
  }
}
