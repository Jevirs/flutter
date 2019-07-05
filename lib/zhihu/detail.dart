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
  ScrollController controller = ScrollController();
  bool textShow = false;
  bool isLoaded = false;
  bool isError = false;

  Future<dynamic> getData() async {
    return await API().get('/${widget.id}');
  }

  void getList() {
    getData().then((res) {
      DetailData detailData = DetailData.fromJson(res.data);
      setState(() {
        body = detailData.body;
        title = detailData.title;
        image = detailData.image;
        imageSource = detailData.imageSource;
      });
    }).catchError((err) {
      isError = true;
    });
    Future.delayed(
        Duration(milliseconds: 1500),
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
      return Center(
        child: Column(
          children: <Widget>[
            Icon(Icons.error),
            Text("Network Error!"),
          ],
        ),
      );
    }
    if (!isLoaded) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                title: textShow
                    ? Text(
                        title,
                        style: TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      )
                    : null,
                background: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                collapseMode: CollapseMode.parallax,
              ),
            )
          ];
        },
        controller: controller,
        body: SingleChildScrollView(
          child: HtmlWidget(
            body,
            webView: true,
          ),
        ),
      );
    }
  }
}
