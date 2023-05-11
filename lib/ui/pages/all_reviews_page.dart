part of 'pages.dart';

class AllReviewsPage extends StatefulWidget {
  final int productId;
  AllReviewsPage({this.productId});
  @override
  _AllReviewsPageState createState() => _AllReviewsPageState();
}

class _AllReviewsPageState extends State<AllReviewsPage> {
  static const _pageSize = 8;
  String query;

  final PagingController<int, Rating> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await RatingServices.getRatings(
          pageKey, _pageSize, widget.productId, null);

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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          SizedBox(height: 16),
          TitlePage(
            title: "Penilaian Produk",
            subtitle: "Semua Penilaian Produk",
            onBackButtonPressed: () {
              Get.back();
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => _pagingController.refresh(),
              ),
              child: PagedListView<int, Rating>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Rating>(
                  itemBuilder: (context, item, index) => Container(
                      margin: EdgeInsets.only(bottom: 12, left: 16, right: 16),
                      child: CommentRating(rating: item)),
                  firstPageErrorIndicatorBuilder: (context) =>
                      CustomIllustration(
                    picturePath: unexpectedError,
                    title: "Maaf",
                    subtitle: "Review gagal dimuat",
                  ),
                  noItemsFoundIndicatorBuilder: (context) => CustomIllustration(
                    picturePath: notFound,
                    title: "Maaf",
                    subtitle: "Review tidak ditemukan",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
