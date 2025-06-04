import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

void main() {
  runApp(const MaterialApp(
    home: TextTest(),
  ));
}

class TextTest extends StatelessWidget {
  const TextTest({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.red,
          width: width/2,
          height: 25,
          child: const Text(
            '11111111122222222222223333333333333333333333',
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}

class CacheImageExample extends StatefulWidget {
  const CacheImageExample({super.key});

  @override
  State<CacheImageExample> createState() => _CacheImageExampleState();
}

class _CacheImageExampleState extends State<CacheImageExample> {
  @override
  void initState() {
    super.initState();

    () async {
      await DefaultCacheManager().downloadFile(
        '/i.pinimg.com/736x/22/d1/1e/22d11e8dcd4662ab144c3bb390ef4282.jpg',
      );
      await DefaultCacheManager().downloadFile(
        'https://storage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
      );
    }.call();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: MaterialButton(
            child: const Text('lol'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TestImageWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TestImageWidget extends StatelessWidget {
  const TestImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          imageUrl:
              'https://img.goodfon.com/wallpaper/big/5/eb/dmc-5-devil-may-cry-5-dante-fokus.webp',
        ),
      ),
    );
  }
}
