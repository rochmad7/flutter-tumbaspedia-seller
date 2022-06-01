part of 'pages.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController keywordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  int selectedIndex = 0;
  SortMethod _selectedSortMethod = SortMethod.acak;
  String message;
  String query;
  String categoryname;
  List<Category> categories;
  var categoriesname = [];
  var category = <Category>[];
  AnimationController animationController;

  static const _pageSize = 1;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    fetchCategories();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      ApiReturnValue<List<Product>> newItems;
      if (selectedIndex == 0) {
        newItems = await ProductServices.getMyProducts(
            query, pageKey, _pageSize, null, _selectedSortMethod);
      } else {
        newItems = await ProductServices.getMyProducts(
            query, pageKey, _pageSize, selectedIndex, _selectedSortMethod);
      }

      final isLastPage = newItems.value.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems.value);
      } else {
        final nextPageKey = pageKey + newItems.value.length;
        _pagingController.appendPage(newItems.value, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void fetchCategories() async {
    isLoading = true;
    try {
      final response = await http.get(baseURLAPI + '/categories', headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI
      });
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            var data = jsonDecode(response.body);
            categories = (data['data'] as Iterable)
                .map((e) => Category.fromJson(e))
                .toList();
            category.clear();
            category.addAll(categories);
            categoriesname.addAll(category);
            isLoading = false;
          });
        }
      }
    } on SocketException {
      setState(() {
        message = socketException;
      });
    } on HttpException {
      setState(() {
        message = httpException;
      });
    } on FormatException {
      setState(() {
        message = formatException;
      });
    } catch (e) {
      setState(() {
        message = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = (context.watch<UserCubit>().state is UserLoadedWithShop);
    categoryname =
        selectedIndex == 0 ? '' : categoriesname[selectedIndex - 1].name;
    if (context.watch<UserCubit>().state is UserLoadingFailed)
      return IllustrationPage(
        title: 'Gagal memuat!',
        sizeTitle: 20,
        subtitle:
            (context.watch<UserCubit>().state as UserLoadingFailed).message,
        picturePath: notFound,
      );
    else if (context.watch<UserCubit>().state is UserInitial)
      return IllustrationPage(
        title: 'Oops!',
        subtitle: notLogin,
        picturePath: notFound,
        buttonTap1: () => Get.to(() => SignInPage()),
        buttonTitle1: 'Login',
      );
    else if (isLogin)
      return Stack(
        children: [
          InkWell(
            splashColor: Colors.white,
            focusColor: Colors.white,
            highlightColor: Colors.white,
            hoverColor: Colors.white,
            onTap: () {},
            child: Column(
              children: [
                Expanded(
                  child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                64,
                                        padding: EdgeInsets.only(
                                            left: defaultMargin,
                                            right: 2,
                                            top: 15),
                                        child: SearchField(
                                          onChanged: _updateSearchTerm,
                                          searchController: keywordController,
                                          title: "Cari Produk UKM Saya",
                                        ),
                                      ),
                                      RefreshButton(
                                        press: () {
                                          _pagingController.refresh();
                                        },
                                      ),
                                      SizedBox(width: 10),
                                      // getSearchBarUI(),
                                    ],
                                  ),
                                  SortMethodGroup(
                                      selectedItem: _selectedSortMethod,
                                      onOptionTap: (option) {
                                        setState(
                                          () => _selectedSortMethod = option.id,
                                        );
                                        _pagingController.refresh();
                                      }),
                                ],
                              );
                            }, childCount: 1),
                          ),
                          SliverPersistentHeader(
                            pinned: true,
                            floating: true,
                            delegate: ContestTabHeader(
                              Stack(
                                children: [
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: defaultMargin,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              offset: const Offset(0, -2),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      color: Colors.white,
                                      child: message != null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  defaultMargin,
                                                              vertical:
                                                                  defaultFontSize /
                                                                      2),
                                                      child: Text(
                                                        message,
                                                        style: redFontStyle,
                                                      )),
                                                ),
                                              ],
                                            )
                                          : (isLoading)
                                              ? Container(
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                  color: Colors.white,
                                                  child: ShimmerRow(
                                                      ratio: 1,
                                                      itemCount: 4,
                                                      color: Colors.white,
                                                      isSymmetric: false,
                                                      height: 30))
                                              : SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: category
                                                        .map(
                                                          (e) => ItemTabBar(
                                                            left: defaultMargin,
                                                            right: (e ==
                                                                    category
                                                                        .last)
                                                                ? defaultMargin
                                                                : 0,
                                                            category: e,
                                                            selectedIndex:
                                                                selectedIndex,
                                                            onTap: (index) {
                                                              setState(() {
                                                                selectedIndex =
                                                                    index;
                                                              });
                                                              _pagingController
                                                                  .refresh();
                                                            },
                                                          ),
                                                        )
                                                        .toList(),
                                                  ),
                                                )),
                                  const Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Divider(
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                      body: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        color: Colors.white,
                        child: RefreshIndicator(
                          onRefresh: () => Future.sync(
                            () => _pagingController.refresh(),
                          ),
                          child: PagedGridView<int, Product>(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.65,
                            ),
                            pagingController: _pagingController,
                            showNewPageErrorIndicatorAsGridChild: false,
                            showNoMoreItemsIndicatorAsGridChild: false,
                            showNewPageProgressIndicatorAsGridChild: false,
                            builderDelegate: PagedChildBuilderDelegate<Product>(
                              itemBuilder: (context, item, index) =>
                                  ProductCard(
                                product: item,
                                press: () => Get.to(
                                  () => ProductDetailsPage(
                                    transaction: Transaction(
                                      product: item,
                                      user: (context.read<UserCubit>().state
                                              as UserLoadedWithShop)
                                          .user,
                                    ),
                                    onBackButtonPressed: () {
                                      Get.back();
                                    },
                                  ),
                                ),
                              ),
                              firstPageErrorIndicatorBuilder: (context) =>
                                  CustomIllustration(
                                picturePath: foodWishes,
                                title: "Maaf",
                                subtitle: "Produk gagal dimuat",
                              ),
                              noItemsFoundIndicatorBuilder: (context) =>
                                  CustomIllustration(
                                picturePath: notFound,
                                title: selectedIndex != 0 ? "Kosong" : "Oops",
                                subtitle: selectedIndex != 0
                                    ? "Produk di toko Anda dengan\nkategori '" +
                                        categoryname +
                                        "' tidak ditemukan"
                                    : "Produk di toko Anda\n masih kosong",
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ],
      );
    else
      return loadingIndicator;
  }

  void _updateSearchTerm(String searchTerm) {
    query = searchTerm;
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );

  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

Widget getGeneralBarUI() {
  return Column(
    children: [
      Container(
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Produk Saya",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Temukan Produk UKM milik Saya",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    color: "8D92A3".toColor(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      Container(
        height: defaultMargin / 2,
        width: double.infinity,
        color: "FAFAFC".toColor(),
      ),
    ],
  );
}

class ProductTabHeader extends SliverPersistentHeaderDelegate {
  ProductTabHeader(
    this.getGeneralBarUI,
  );

  final Widget getGeneralBarUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return getGeneralBarUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
