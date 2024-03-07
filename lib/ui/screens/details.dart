import 'package:catbreeds/config/helpers/screen_size.dart';
import 'package:catbreeds/config/services/navigation_service.dart';
import 'package:catbreeds/data/models/cat_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cat_provider.dart';
import '../widgets/image_cat.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.cat});
  final CatModel cat;

  @override
  Widget build(BuildContext context) {
    CatProvider catProvider = context.read<CatProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          forceMaterialTransparency: true,
          leading: GestureDetector(
            onTap: () => NavigationService.goback(),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: ScreenSize.width * 0.06,
              color: Colors.black,
            ),
          ),
          title: buildNameBreed(),
        ),
        body: buildBody(catProvider),
      ),
    );
  }

  Padding buildBody(CatProvider catProvider) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04),
      child: Column(
        children: [
          ImageCatWidget(
            imageUrl: '${catProvider.baseUrl}${cat.referenceImageId}.jpg',
            height: ScreenSize.absoluteHeight * 0.5,
          ),
          buildDetailsBreed(catProvider),
        ],
      ),
    );
  }

  SizedBox buildDetailsBreed(CatProvider catProvider) {
    return SizedBox(
      height: ScreenSize.absoluteHeight * 0.42,
      width: ScreenSize.width,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            catProvider.detailsToShow.length,
            (index) {
              String nameInfo =
                  catProvider.detailsToShow[index] == 'Description'
                      ? ''
                      : catProvider.detailsToShow[index];
              String info = getInfo(catProvider.detailsToShow[index]);
              if (info.isEmpty) return const SizedBox();
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ScreenSize.width * 0.015,
                ),
                child: buildInfo(
                  nameInfo: nameInfo,
                  info: info,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String getInfo(String info) {
    switch (info) {
      case 'Description':
        return info = cat.description;
      case 'Origin':
        return info = cat.origin;
      case 'Intelligence':
        return info = cat.intelligence.toString();
      case 'Energy level':
        return info = cat.energyLevel.toString();
      case 'Temperament':
        return info = cat.temperament;
      case 'Adaptability':
        return info = cat.adaptability.toString();
      case 'Life span':
        return info = cat.lifeSpan;
      case 'Alt names':
        return info = cat.altNames;
      case 'Dog friendly':
        return info = cat.dogFriendly.toString();
      case 'Child friendly':
        return info = cat.childFriendly.toString();
      case 'Affection level':
        return info = cat.affectionLevel.toString();
    }
    return '';
  }

  Text buildNameBreed() {
    return Text(
      cat.name,
      style: TextStyle(
        fontSize: ScreenSize.width * 0.05,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  RichText buildInfo({required String nameInfo, required String info}) {
    return RichText(
      text: TextSpan(
        text: nameInfo.isEmpty ? '' : '$nameInfo: ',
        style: TextStyle(
          fontSize: ScreenSize.width * 0.04,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: info,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: ScreenSize.width * 0.04,
            ),
          )
        ],
      ),
    );
  }
}
