part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int initialPage;
  final String tumbaspediaDefinition;

  MainPage({this.initialPage = 0, this.tumbaspediaDefinition});

  @override
  _MainPageState createState() => _MainPageState(tumbaspediaDefinition: tumbaspediaDefinition);
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  String tumbaspediaDefinition;
  PageController pageController = PageController(initialPage: 0);

  _MainPageState({this.tumbaspediaDefinition});

  @override
  void initState() {
    super.initState();
    selectedPage = widget.initialPage;
    pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          SafeArea(
            child: Container(
              color: "FAFAFC".toColor(),
            ),
          ),
          SafeArea(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedPage = index;
                });
              },
              children: [
                Center(
                  child: HomePage(),
                ),
                Center(
                  child: ProductPage(),
                ),
                Center(
                  child: AddProductPage(),
                ),
                Center(
                  child: OrderHistoryPage(),
                ),
                Center(
                  child: ProfilePage(tumbaspediaDefinition: tumbaspediaDefinition),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavbar(
              selectedIndex: selectedPage,
              onTap: (index) {
                setState(() {
                  selectedPage = index;
                });
                pageController.jumpToPage(selectedPage);
              },
            ),
          ),
        ],
      ),
    );
  }
}
