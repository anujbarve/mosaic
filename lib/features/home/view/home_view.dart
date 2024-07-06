import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mosaic_communities/constants/constants.dart';
import 'package:mosaic_communities/constants/ui_constants.dart';
import 'package:mosaic_communities/features/post/views/create_post_view.dart';
import 'package:mosaic_communities/theme/palette.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomeView());

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _pageNo = 0;
  final appBar = UIConstants.appbar();

  void onPageChange(int index){
    setState(() {
      _pageNo = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(
        index: _pageNo,
        children: UIConstants.bottomTabBarPages,
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _pageNo,
        backgroundColor: Pallete.backgroundColor,
        onTap: onPageChange,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _pageNo == 0 ? AssetsConstants.homeFilledIcon : AssetsConstants.homeOutlinedIcon,
              color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              color: Pallete.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _pageNo == 2 ? AssetsConstants.notifFilledIcon : AssetsConstants.notifOutlinedIcon,
              color: Pallete.whiteColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, CreatePostScreen.route());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
