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
              String nameInfo = catProvider.detailsToShow[index];
              String info = '';
              switch (catProvider.detailsToShow[index]) {
                case 'Description':
                  info = cat.description;
                  break;
                case 'Origin':
                  info = cat.origin;
                  break;
                case 'Intelligence':
                  info = cat.intelligence.toString();
                  break;
                case 'Energy level':
                  info = cat.energyLevel.toString();
                  break;
                case 'Temperament':
                  info = cat.temperament;
                  break;
                case 'Adaptability':
                  info = cat.adaptability.toString();
                  break;
                case 'Life span':
                  info = cat.lifeSpan;
                  break;
                case 'Alt names':
                  info = cat.altNames;
                  break;
                case 'Dog friendly':
                  info = cat.dogFriendly.toString();
                  break;
                case 'Child friendly':
                  info = cat.childFriendly.toString();
                  break;
                case 'Affection level':
                  info = cat.affectionLevel.toString();
                  break;
                default:
              }
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
        text: '$nameInfo: ',
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
