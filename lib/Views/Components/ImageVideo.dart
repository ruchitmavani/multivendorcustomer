import 'package:flutter/material.dart';
import 'package:multi_vendor_customer/Constants/StringConstants.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class ImageVideo extends StatefulWidget {
  String url;
  bool isVideo;

  ImageVideo({Key? key, required this.isVideo, required this.url})
      : super(key: key);

  @override
  _ImageVideoState createState() => _ImageVideoState();
}

class _ImageVideoState extends State<ImageVideo> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 230,
        child: widget.isVideo
            ? VideoPlayer(VideoPlayerController.network(
                "${StringConstants.api_url + widget.url}")..initialize()..play())
            : Image.network("${StringConstants.api_url+widget.url}"));
  }
}
