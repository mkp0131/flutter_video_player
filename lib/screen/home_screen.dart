import 'package:flutter/material.dart';
import 'package:flutter_video_player/component/c_video_player.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video == null ? renderDefault() : renderVideo(),
    );
  }

  uploadContent() async {
    print('✅ upload');
    final ImagePicker _picker = ImagePicker();
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  Widget renderDefault() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter, // 기준점 시작
        end: Alignment.bottomCenter, // 기준점 종료
        colors: [
          Color(0xff2a3a7c),
          Color(0xff000118),
        ],
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Logo(onTap: uploadContent),
          SizedBox(
            height: 10,
          ),
          _AppName(),
        ],
      ),
    );
  }

  Widget renderVideo() {
    return Center(
      child: CVideoPlayer(
        video: video!,
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/image/logo.png',
        width: 200,
        height: 200,
      ),
    );
  }
}

class _AppName extends StatelessWidget {
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 26,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'VIDEO',
          style: textStyle1,
        ),
        Text(
          'PLAYER',
          style: textStyle1.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
