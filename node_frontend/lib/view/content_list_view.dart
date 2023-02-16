import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../providers/content_provider.dart';
import 'test_refesh.dart';

class ContentListView extends StatefulWidget {
  const ContentListView({super.key});

  @override
  State<ContentListView> createState() => _ContentListViewState();
}

class _ContentListViewState extends State<ContentListView> {
  final Logger _logger = Logger();

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  late ScrollController _scrollController;
  List<MaterialColor> colors = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.amber,
    Colors.blueGrey,
    Colors.yellow,
    Colors.indigo,
  ];

  @override
  void initState() {
    _scrollController = ScrollController(keepScrollOffset: true);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        _logger.d('finished loading');
        loadContent();
      }
    });
  }

  Future loadContent() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getContentData();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: LiveList.options(
          physics: const BouncingScrollPhysics(),
          options: options,
          controller: _scrollController,
          padding: const EdgeInsets.all(8.0),
          itemCount: data.dataModel.isEmpty ? 0 : (data.dataModel.length) + 1,
          itemBuilder: (context, index, Animation<double> animation) {
            if (index < data.dataModel.length) {
              final item = data.dataModel[index];
              return FadeTransition(
                opacity: Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(animation),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, -0.1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: SizedBox(
                    width: size.width,
                    height: size.height * .25,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        elevation: 8,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Demo(
                                        index: index,
                                        item: item,
                                      ))),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Hero(
                                tag: '${item.title}' '$index',
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    height: size.height * 0.25,
                                    width: size.width,
                                    child: Material(
                                      child: ListTile(
                                        title: Text('${item.title}'),
                                        subtitle: Text(
                                          '${item.content}',
                                          style: const TextStyle(),
                                        ),
                                        leading: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage('${item.img_src}'),
                                            backgroundColor:
                                                colors[index % colors.length],
                                            child: Text(
                                              '$index',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: Center(child: CupertinoActivityIndicator()),
              );
            }
          }),
    );
  }

  final options = const LiveOptions(
    // Start animation after (default zero)
    delay: Duration(milliseconds: 250),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 250),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 250),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: false,
  );
}
