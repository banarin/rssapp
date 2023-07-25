import 'package:flutter/material.dart';
import 'package:fluxrss/app/detail.dart';
import 'package:fluxrss/components/myText.dart';
import 'package:fluxrss/models/Parser.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:webfeed/webfeed.dart';

import '../components/myCard.dart';
import '../components/myIcon.dart';
import '../components/myList.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RssItem>? items;
  int? i;
  Future pars() async {
    List<RssItem> data = await Parser().loadRss();
    setState(() {
      items = data;
    });
    // print(data.items!.length);
    // data.items!.forEach((element) {
    //   print(element.title);
    //   print(element.description);
    //   print(element.enclosure!.url);
    // });
  }

  void dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: ((context) {
          return Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pars();
  }

  final GlobalKey<dynamic> _sliderKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: myText("News", TextAlign.start, 20.0, Colors.black),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () async {
                  dialog(context);
                  await pars();
                  Navigator.pop(context);
                },
                icon: myIcon(
                    FontAwesomeIcons.arrowRotateRight, 20.0, Colors.black),
              ))
        ],
      ),
      body: items == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: myText(
                          "Les News", TextAlign.start, 18.0, Colors.black),
                    ),
                    CarouselSlider.builder(
                        itemCount: items!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var image = items![itemIndex].enclosure!.url;
                          var title = items![itemIndex].title;
                          return InkWell(
                            onTap: () {
                              setState(() {
                                i = itemIndex;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          detailPage(items, i!)));
                            },
                            child: myCard(
                                image.toString(),
                                myText(title.toString(), TextAlign.center, 15,
                                    Colors.white)),
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          height: MediaQuery.sizeOf(context).height / 4,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: myText(
                          "Tous les News", TextAlign.end, 18, Colors.black),
                    ),
                    Container(
                        height: MediaQuery.sizeOf(context).height / 2,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: ((context, index) {
                              var image = items![index].enclosure!.url;
                              var title = items![index].title;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    i = index;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              detailPage(items, i!)));
                                },
                                child: myList(context, image.toString(),
                                    title.toString()),
                              );
                            })))
                  ],
                ),
              ),
            ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //       color: Colors.black12, borderRadius: BorderRadius.circular(20.0)),
      //   margin: EdgeInsets.all(15.0),
      //   child: const GNav(
      //       gap: 8,
      //       iconSize: 30,
      //       textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      //       padding: EdgeInsets.all(15),
      //       tabs: [
      //         GButton(
      //           text: 'home',
      //           icon: Icons.home,
      //           style: GnavStyle.google,
      //         ),
      //         GButton(
      //           text: 'home',
      //           icon: Icons.home,
      //         ),
      //         GButton(
      //           text: 'home',
      //           icon: Icons.home,
      //         ),
      //       ]),
      // ),
    );
  }
}
