import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'feed.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late ScrollController _scrollController;

  double tabbarheight = 72;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.depth >= 2) {
              if (notification.direction == ScrollDirection.forward &&
                  _scrollController.offset != 0) {
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              } else if (notification.depth >= 2 &&
                  notification.direction == ScrollDirection.reverse &&
                  _scrollController.offset != tabbarheight) {
                _scrollController.animateTo(tabbarheight,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease);
              }
            }
            return false;
          },
          child: NestedScrollView(
            controller: _scrollController,
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    toolbarHeight: 0,
                    floating: true,
                    snap: false,
                    forceElevated: innerBoxIsScrolled,
                    bottom: _tabBar(),
                  ),
                ),
                //),
              ];
            },
            body: TabBarView(
              controller: tabController,
              children: [
                for (int i = 0; i < 3; i++) Feed(i),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _tabBar() {
    return TabBar(
      controller: tabController,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
      ),
      tabs: const [
        Tab(text: "Tab 1"),
        Tab(text: "Tab 2"),
        Tab(text: "Tab 3"),
      ],
    );
  }
}
