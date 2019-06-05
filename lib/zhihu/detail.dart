import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_demo/zhihu/detail_model.dart';
import 'package:flutter_demo/zhihu/http.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

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

  void getList() async {
    var res = await dio.get('/${widget.id}');
    DetailData detailData = new DetailData.fromJson(res.data);
    setState(() {
      body = detailData.body;
      title = detailData.title;
      image = detailData.image;
      imageSource = detailData.imageSource;
      isLoaded = true;
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
        body: new Container(
          child: new HtmlView(data: body),
        ),
      );
    }
  }
}
