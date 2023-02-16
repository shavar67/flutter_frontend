import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../network/server.dart';
import '../providers/content_provider.dart';
import 'data_content_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  @override
  void initState() {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getContentData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: requestData(),
          builder: ((context, snapshot) {
            var data = snapshot;
            if (data.hasData) {
              return const ContentDashBoard();
            } else if (data.hasError) {
              return Center(
                child: Text(data.error.toString().substring(16)),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          })),
    );
  }
}
