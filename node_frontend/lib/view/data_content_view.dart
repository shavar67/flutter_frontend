import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/content_provider.dart';
import 'content_list_view.dart';

class ContentDashBoard extends StatefulWidget {
  const ContentDashBoard({super.key});

  @override
  State<ContentDashBoard> createState() => _ContentDashBoardState();
}

class _ContentDashBoardState extends State<ContentDashBoard> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: AnimateIfVisibleWrapper(
        child: SingleChildScrollView(
          child: Column(
            children: [
              data.dataModel.isEmpty
                  ? const Center(child: Text('Nothing to display'))
                  : const ContentListView(),
            ],
          ),
        ),
      ),
    );
  }
}
