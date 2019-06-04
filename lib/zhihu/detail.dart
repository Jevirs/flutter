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
  ScrollController controller = ScrollController();
  bool textShow = false;

  void getList() async {
    var res = await dio.get('/${widget.id}');
    DetailData detailData = DetailData.fromJson(res.data);
    setState(() {
      body = detailData.body;
      title = detailData.title;
      image = detailData.image;
      imageSource = detailData.imageSource;
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
    return CustomScrollView(
      controller: controller,
      slivers: <Widget>[
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
        ),
        SliverFillRemaining(
          child: new HtmlView(data: body),
        ),
      ],
    );
  }
}
