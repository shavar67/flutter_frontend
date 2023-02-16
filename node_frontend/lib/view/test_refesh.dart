import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/data_model.dart';

class Demo extends StatefulWidget {
  final DataModel item;
  final int index;

  const Demo({super.key, required this.item, required this.index});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample'),
        leading: GestureDetector(
            onTap: () async {
              Navigator.pop(context);
            },
            child: const Icon(
              color: Colors.black,
              size: 20,
              Icons.arrow_back_ios,
            )),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Hero(
                tag: '${widget.item.title}' '${widget.index}',
                child: Material(
                    elevation: 12,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: CachedNetworkImage(
                      imageUrl: '${widget.item.img_src}',
                      imageBuilder: (context, imageProvider) => Container(
                        width: size.width,
                        height: size.height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        width: size.width,
                        height: size.height * 0.25,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
              )),
        ],
      ),
    );
  }
}
