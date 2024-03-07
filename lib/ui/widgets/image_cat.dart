import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/helpers/code_utils.dart';
import '../../config/helpers/screen_size.dart';

class ImageCatWidget extends StatelessWidget {
  const ImageCatWidget({Key? key, required this.imageUrl, required this.height})
      : super(key: key);

  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  Container buildBody() {
    return Container(
      height: height,
      width: ScreenSize.width,
      padding: EdgeInsets.only(bottom: ScreenSize.width * 0.02),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FastCachedImage(
          height: height,
          url: imageUrl,
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return buildImageNotFound(); // Widget a mostrar en caso de error
          },
          loadingBuilder: (_, __) {
            return buildImageLoading();
          },
        ),
      ),
    );
  }

  Container buildImageLoading() {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: CodeUtils.showLottie('assets/lotties/loading.json'),
    );
  }

  Container buildImageNotFound() {
    return Container(
      alignment: Alignment.center,
      height: height,
      child: CodeUtils.showLottie('assets/lotties/image_not_found.json'),
    );
  }
}
