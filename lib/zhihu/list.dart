import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/zhihu/detail.dart';
import 'package:flutter_demo/zhihu/home_model.dart';
import 'package:flutter_demo/zhihu/http.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeList extends StatefulWidget {
  String date;

  HomeList({this.date});

  @override
  State<StatefulWidget> createState() {
    return new _ListState();
  }
}

class _ListState extends State<HomeList> {
  List<Story> stories = [];
  bool isError = false;

  void getList() {
    getData().then((res) {
      HomeData homeData = new HomeData.fromJson(res.data);
      setState(() {
        stories = homeData.stories;
      });
    }).catchError((onError) {
      setState(() {
        isError = true;
      });
    });
  }

  Future<dynamic> getData() async {
    setState(() {
      stories = [];
      isError = false;
    });
    return await new API().get('/before/${widget.date}');
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  void didUpdateWidget(HomeList oldWidget) {
    super.didUpdateWidget(oldWidget);
    getList();
  }

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return new Center(
          child: new Column(
        children: <Widget>[
          new Icon(Icons.error),
          new Text("something wrong with network!")
        ],
      ));
    }
    if (stories.length == 0) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new ListView.builder(
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return new Divider();
          }

          final i = index ~/ 2;
          final item = stories[i].toJson();

          return new ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: new CachedNetworkImage(
              imageUrl: item['images'][0],
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
            title: new Text(item['title']),
            onTap: () => {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return new Scaffold(
                      body: new Container(
                        child: new Detail(id: item['id'].toString()),
                      ),
                    );
                  }))
                },
          );
        },
        itemCount: stories.length,
      );
    }
  }
}
