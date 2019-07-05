import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/zhihu/detail.dart';
import 'package:flutter_demo/zhihu/home_model.dart';
import 'package:flutter_demo/zhihu/http.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeList extends StatefulWidget {
  final String date;
  HomeList({this.date});

  @override
  State<StatefulWidget> createState() {
    return _ListState();
  }
}

class _ListState extends State<HomeList> {
  List<Story> stories = [];
  bool isError = false;

  void getList() {
    getData().then((res) {
      HomeData homeData = HomeData.fromJson(res.data);
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
    return await API().get('/before/${widget.date}');
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
      return Center(
          child: Column(
        children: <Widget>[
          Icon(Icons.error),
          Text("something wrong with network!")
        ],
      ));
    }
    if (stories.length == 0) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return Divider();
          }

          final i = index ~/ 2;
          final item = stories[i].toJson();

          return ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: CachedNetworkImage(
              imageUrl: item['images'][0],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(item['title']),
            onTap: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return Scaffold(
                      body: Container(
                        child: Detail(id: item['id'].toString()),
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
