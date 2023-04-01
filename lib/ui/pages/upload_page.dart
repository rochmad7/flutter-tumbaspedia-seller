part of 'pages.dart';

class UploadPage extends StatefulWidget {
  final List<Photo> photos;
  final Product product;

  UploadPage({this.product, this.photos});

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  List<File> picturesFile;
  bool isLoading = false;
  bool isLoadingPhoto = false;
  var listPhotos = <Photo>[];
  List<Photo> photos;
  String message;
  Map<String, dynamic> error;

  List<Object> images = [];
  Future<File> _imageFile;

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      onBackButtonPressed: () async {
        Get.back();
      },
      title: 'Tambah Foto Produk',
      subtitle: "Pastikan data yang diisi valid",
      child: Container(
        margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 6),
        child: Column(
          children: [
            LabelFormField(label: "Foto Utama"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: EdgeInsets.all(10),
              child: widget.product.images != null
                  ? CachedNetworkImage(
                      imageUrl: widget.product.images,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      repeat: ImageRepeat.repeat,
                    )
                  : Center(child: Text('No image')),
            ),
            LabelFormField(label: "Tambah Foto Lainnya"),
            // Text(
            //   "Anda dapat menambahkan 3 foto produk yang lain",
            //   style: blackFontStyle3.copyWith(fontSize: 14),
            // ),
            buildGridView(),
            SizedBox(
              height: 15,
            ),
            ButtonDefault(
                isLoading: isLoading,
                title: "Simpan Data",
                press: () async {
                  setState(() {
                    isLoading = true;
                  });

                  await context
                      .read<PhotoCubit>()
                      .uploadMultiple(widget.product.id, picturesFile: images);
                  PhotoState state = context.read<PhotoCubit>().state;

                  if (state is PhotoAdded) {
                    context
                        .read<ProductCubit>()
                        .getMyProducts(null, null, null, null);
                    setState(() {
                      isLoading = false;
                    });
                    Get.to(() => MainPage(initialPage: 1));
                    snackBar("Berhasil", "Foto produk berhasil ditambahkan",
                        'success');
                  } else {
                    context
                        .read<ProductCubit>()
                        .getMyProducts(null, null, null, null);
                    snackBar("Foto produk gagal ditambahkan",
                        (state as PhotoAddedFailed).message, 'error');

                    setState(() {
                      error = (state as PhotoAddedFailed).error != null
                          ? (state as PhotoAddedFailed).error
                          : null;
                      // pictureFile = null;
                      isLoading = false;
                    });
                  }
                }),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is Photo) {
          // Make a copy of the images list
          var copiedImages = List.from(images);
          Photo photo = copiedImages[index];

          if (photo.imageFile == null) {
            return Card(
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _onAddImageClick(index);
                },
              ),
            );
          }
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  photo.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        copiedImages
                            .replaceRange(index, index + 1, ['Add Image']);
                        images = copiedImages;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
    // Check if the _imageFile is null
    if (_imageFile == null) {
      setState(() {
        images.replaceRange(index, index + 1, ['Add Image']);
      });
    }
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        Photo photo = new Photo();
        photo.imageFile = file;
        images.replaceRange(index, index + 1, [photo]);
      });
    });
  }
}
