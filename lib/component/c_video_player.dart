import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CVideoPlayer extends StatefulWidget {
  final XFile video;
  const CVideoPlayer({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  State<CVideoPlayer> createState() => _CVideoPlayerState();
}

class _CVideoPlayerState extends State<CVideoPlayer> {
  VideoPlayerController? videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVideoController();
  }

  initVideoController() async {
    videoController = VideoPlayerController.file(
      File(widget.video.path), // XFile 형태를 File 형태로 변환
    );
    await videoController!.initialize();
    setState(() {}); // 해당 함수가 끝난후 위젯을 RE랜더링!
  }

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      return CircularProgressIndicator();
    }

    return AspectRatio(
      // 해당 위젯의 비유을 맞춰주기
      aspectRatio: videoController!.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(
            videoController!,
          ),
          _Controls(),
          // 포지션 이동 위젯
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () {
                print('ddd');
              },
              icon: Icon(
                Icons.photo_camera_back,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  const _Controls({Key? key}) : super(key: key);

  Widget btnIcon(
      {required IconData iconData, required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        size: 32,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          btnIcon(
            iconData: Icons.rotate_left,
            onPressed: () {},
          ),
          btnIcon(
            iconData: Icons.play_arrow,
            onPressed: () {},
          ),
          btnIcon(
            iconData: Icons.rotate_right,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
