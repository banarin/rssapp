import 'package:flutter/material.dart';
import 'package:fluxrss/components/myText.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class detailPage extends StatefulWidget {
  detailPage(this.items, this.i, {super.key});
  List<RssItem>? items;
  int i;

  @override
  State<detailPage> createState() => _detailPageState();
}

class _detailPageState extends State<detailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height / 2.5,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: NetworkImage(
                    widget.items![widget.i].enclosure!.url.toString(),
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.8,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(20.0)),
                    child: myText(widget.items![widget.i].pubDate.toString(),
                        TextAlign.center, 15, Colors.white),
                  ),
                  myText(widget.items![widget.i].title.toString(),
                      TextAlign.start, 20, Colors.white)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Text(
                'Description',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: myText(widget.items![widget.i].description.toString(),
                  TextAlign.start, 17, Colors.grey),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: () async {
                  _launchUrl();
                },
                child: Text(
                  widget.items![widget.i].link!,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ));
  }
  Future<void> _launchUrl() async {
  final Uri _url = Uri.parse(widget.items![widget.i].link!.toString());
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
}


