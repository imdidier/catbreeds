import 'package:catbreeds/config/helpers/screen_size.dart';
import 'package:catbreeds/config/services/navigation_service.dart';
import 'package:catbreeds/data/models/cat_model.dart';
import 'package:catbreeds/ui/providers/cat_provider.dart';
import 'package:catbreeds/ui/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widgets/image_cat.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CatProvider catProvider = context.watch<CatProvider>();
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'CatBreeds',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenSize.width * 0.06,
              ),
            ),
            forceMaterialTransparency: true,
            centerTitle: true,
          ),
          body: Stack(
            children: [
              buildBody(catProvider),
              Positioned(
                top: ScreenSize.width * 0.005,
                left: ScreenSize.width * 0.02,
                child: buildCustomSearch(catProvider),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildCustomSearch(CatProvider catProvider) {
    return Container(
      height: ScreenSize.absoluteHeight * 0.05,
      width: ScreenSize.width - ScreenSize.width * 0.08,
      margin: EdgeInsets.symmetric(
        horizontal: ScreenSize.width * 0.02,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: TextFormField(
        controller: catProvider.breedController,
        onChanged: (query) => catProvider.filterCatsByBreed(query),
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black45,
          ),
          hintText: 'Search by breed',
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: ScreenSize.width * 0.04),
        ),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }

  Container buildBody(CatProvider catProvider) {
    return Container(
      height: ScreenSize.absoluteHeight,
      width: ScreenSize.width,
      padding: EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.04)
          .copyWith(top: ScreenSize.top * 1.4),
      child: catProvider.filteredCats.isNotEmpty
          ? ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemBuilder: (context, index) {
                CatModel cat = catProvider.filteredCats[index];
                return buildItemCat(cat, catProvider);
              },
              itemCount: catProvider.filteredCats.length,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: ScreenSize.absoluteHeight * 0.4,
                  child: Lottie.asset(
                    'assets/lotties/breed_not_found.json',
                    frameRate: FrameRate.max,
                  ),
                ),
                Text(
                  'Breed not found',
                  style: TextStyle(
                    fontSize: ScreenSize.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }

  Container buildItemCat(CatModel cat, CatProvider catProvider) {
    return Container(
      height: ScreenSize.absoluteHeight * 0.4,
      margin: EdgeInsets.only(bottom: ScreenSize.width * 0.03),
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.width * 0.02,
        horizontal: ScreenSize.width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            spreadRadius: 0,
            blurRadius: 2,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          buildNameAndMoreDetails(cat),
          ImageCatWidget(
            imageUrl: '${catProvider.baseUrl}${cat.referenceImageId}.jpg',
            height: ScreenSize.absoluteHeight * 0.31,
            key: Key(cat.referenceImageId),
          ),
          buildOriginAndIntelligence(cat)
        ],
      ),
    );
  }

  Row buildOriginAndIntelligence(CatModel cat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Origin: ${cat.origin}',
          style: TextStyle(
            fontSize: ScreenSize.width * 0.04,
          ),
        ),
        Text(
          'Intelligence: ${cat.intelligence}',
          style: TextStyle(
            fontSize: ScreenSize.width * 0.04,
          ),
        ),
      ],
    );
  }

  Row buildNameAndMoreDetails(CatModel cat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          cat.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: ScreenSize.width * 0.05,
          ),
        ),
        GestureDetector(
          onTap: () {
            NavigationService.navigateTo(
              screen: DetailsScreen(cat: cat),
            );
          },
          child: Text(
            'Show more',
            style: TextStyle(
              fontSize: ScreenSize.width * 0.03,
              color: Colors.blueAccent,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
