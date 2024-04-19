import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minly_media_mobile/constants/minly_colors.dart';
import 'package:minly_media_mobile/presentation/screens/home_tabs/create_post.dart';
import 'package:minly_media_mobile/presentation/screens/home_tabs/feeds.dart';
import 'package:minly_media_mobile/presentation/screens/home_tabs/profile.dart';
import 'package:minly_media_mobile/presentation/screens/home_tabs/reels.dart';
import 'package:minly_media_mobile/presentation/screens/home_tabs/search.dart';
import 'package:minly_media_mobile/presentation/widgets/gradientText.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const FeedsTab(),
    const SearchTab(),
    const CreatePostTab(),
    const ReelsTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        title: GradientText(
          widget.title,
          style: GoogleFonts.pacifico(
            fontSize: 30,
          ),
          gradient: LinearGradient(colors: [
            MinlyColor.primary_2,
            MinlyColor.primary_1,
          ]),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/heart-lined.svg'),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/tags.svg'),
          ),
        ],
      ),
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0.0,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 0
                  ? 'assets/icons/home-bold.svg'
                  : 'assets/icons/home-outline.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 1
                  ? 'assets/icons/search-bold.svg'
                  : 'assets/icons/search-outline.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 2
                  ? 'assets/icons/add-square-bold.svg'
                  : 'assets/icons/add-square-outline.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(_selectedIndex == 3
                  ? 'assets/icons/video-play-bold.svg'
                  : 'assets/icons/video-play-outline.svg'),
              label: ''),
          const BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(
                  'JD',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              label: ''),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
