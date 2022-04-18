part of 'widgets.dart';

class ImagePickerDefault extends StatelessWidget {
  final File pictureFile;
  final Function press;
  final String imageURL;
  final bool isCircle;
  final double width;
  final double height;
  final bool isMargin;
  final bool isPadding;
  ImagePickerDefault(
      {this.isMargin = false,
      this.isPadding = false,
      this.press,
      this.height = 110,
      this.width = 110,
      this.pictureFile,
      this.imageURL,
      this.isCircle = true});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
          width: width,
          height: height,
          margin: isMargin ? EdgeInsets.all(0) : EdgeInsets.only(top: 26),
          padding: isPadding ? EdgeInsets.all(0) : EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isCircle
                    ? 'assets/images/user/photo_border.png'
                    : 'assets/images/user/add_border.png',
              ),
            ),
          ),
          child: (pictureFile != null)
              ? Container(
                  decoration: BoxDecoration(
                    shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                    image: DecorationImage(
                      image: FileImage(pictureFile),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : (imageURL) != null
                  ? CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape:
                              isCircle ? BoxShape.circle : BoxShape.rectangle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      imageUrl: imageURL,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      repeat: ImageRepeat.repeat,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(
                            isCircle
                                ? 'assets/images/user/photo.png'
                                : 'assets/images/user/add.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
    );
  }
}
