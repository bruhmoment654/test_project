import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:svg_clip/internal/svg_asset.dart';
import 'package:svg_clip/internal/svg_clip.dart';


class ClipExampleWidget extends StatelessWidget {
  const ClipExampleWidget({super.key});

    @override
    Widget build(BuildContext context) {
      return Center(
        child: SvgClip(
          asset: ClipAsset.local(path: 'assets/shape.svg'),
          child: Image.asset('assets/cow.png', width: 300, height: 300,),
        ),
      );
    }
}
