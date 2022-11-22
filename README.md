# flutter_video_player

## [flutter] 그라디언트 사용법 / Gradient

- `Container()` 위젯에 `decoration` 속성을 사용한다.
- `decoration` 속성을 사용할 경우 `color` 속성을 따로 사용 X(에러)

```dart
Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter, // 기준점 시작
          end: Alignment.bottomCenter, // 기준점 종료
          colors: [
            Color(0xff2a3a7c),
            Color(0xff000118),
          ],
      )
    ),
```

## [flutter] 같은 위젯내 스타일 지정

- build 함수 내에 변수를 생성하여 위젯에 적용한다.
- `.copyWith()`를 사용하여 변수를 확장해서 사용 

```dart
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
        Text('VIDEO', style: textStyle1,),
        Text('PLAYER', style: textStyle1.copyWith(fontWeight: FontWeight.w700),),
      ],
    );
  }
}
```

## [flutter] 핸드폰 접근 권한 부여, 비디오, 사진

- `<project root>/ios/Runner/Info.plist` 파일 <dict> 안에 아래 형식으로 추가

```plist
	<key>NSPhotoLibraryUsageDescription</key>
	<string>사진첩 권한을 허가 해주세요!</string>
	<key>NSCameraUsageDescription</key>
	<string>카메라 권한을 허가 해주세요!</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>마이크 권한을 허가 해주세요!</string>
</dict>
```

## [flutter] 투명색 사용

- `.withOpacity()` 메소드를 사용

```dart
Container(
  color: Colors.black.withOpacity(0.2),
),
```

## [flutter] 위젯 겹치기

- Stack 을 사용한다.
- Positioned 로 위치를 자유자재로 움직일 수 있다.

```dart
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
```

## [flutter] 텍스트 자릿수 고정, 문자 넣기

- padLeft() 메소드를 사용한다.

```dart
'${maxPosition.inMinutes}:${(maxPosition.inSeconds % 60).toString().padLeft(2, '0')}',
```

## [flutter] StatefulWidget constructor 로 받은 변수로 컴포넌트 업데이트

- StatefulWidget 은 constructor 로 받은 변수를 받아도 state 가 업데이트 되지는 않는다.
- 최초 실행시 한번 init 되고, 저번에 생성한 state를 연결하기 때문!
- didUpdateWidget() 를 사용

```dart
  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget){
    super.didUpdateWidget(oldWidget);

    if(oldWidget.video.path != widget.video.path){
      initializeController();
    }
  }
```