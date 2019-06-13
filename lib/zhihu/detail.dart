import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/zhihu/detail_model.dart';
import 'package:flutter_demo/zhihu/http.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Detail extends StatefulWidget {
  final String id;
  Detail({this.id});

  @override
  State<StatefulWidget> createState() {
    return _DetailState();
  }
}

class _DetailState extends State<Detail> {
  String body = "";
  String title = "";
  String image = "";
  String imageSource = "";
  ScrollController controller = new ScrollController();
  bool textShow = false;
  bool isLoaded = false;
  bool isError = false;

  Future<dynamic> getData() async {
    return await new API().get('/${widget.id}');
  }

  void getList() {
    getData().then((res) {
      DetailData detailData = new DetailData.fromJson(res.data);
      setState(() {
        body = detailData.body;
        title = detailData.title;
        image = detailData.image;
        imageSource = detailData.imageSource;
      });
    }).catchError((err) {
      isError = true;
    });
    new Future.delayed(
        new Duration(milliseconds: 1500),
        () => {
              setState(() {
                isLoaded = true;
              })
            });
  }

  void addListener() {
    controller.addListener(() => {
          setState(() {
            if (controller.offset > 100) {
              textShow = true;
            } else {
              textShow = false;
            }
          })
        });
  }

  @override
  void initState() {
    super.initState();
    getList();
    addListener();
  }

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return new Center(
        child: new Column(
          children: <Widget>[
            new Icon(Icons.error),
            new Text("Network Error!"),
          ],
        ),
      );
    }
    if (!isLoaded) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: new FlexibleSpaceBar(
                title: textShow
                    ? new Text(
                        title,
                        style: new TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                background: new Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                collapseMode: CollapseMode.parallax,
              ),
            )
          ];
        },
        controller: controller,
        body: new SingleChildScrollView(
          child: HtmlWidget(
            body,
            webView: true,
          ),
        ),
      );
    }
  }
}
