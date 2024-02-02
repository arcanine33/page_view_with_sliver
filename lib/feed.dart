import 'dart:math';

import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  final int pageIndex;
  const Feed(this.pageIndex, {super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (context) {
        return CustomScrollView(
          controller: scrollController,
          key: PageStorageKey<String>('feed ${widget.pageIndex}'),
          slivers: [
            SliverList.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: getRandomColor(),
                    title: Text('Item $index'),
                  );
                }),
          ],
        );
      }),
    );
  }

  Color getRandomColor() {
    Random random = Random(); // Random 클래스의 인스턴스 생성
    // 0에서 255 사이의 랜덤한 정수 값을 생성하여 RGB 값으로 사용
    int r = random.nextInt(256);
    int g = random.nextInt(256);
    int b = random.nextInt(256);
    // Color 클래스를 사용하여 RGB 값을 기반으로 색상 객체 생성
    return Color.fromRGBO(r, g, b, 1); // 알파 값은 1로 설정하여 불투명하게 설정
  }

  @override
  bool get wantKeepAlive => true;

}
