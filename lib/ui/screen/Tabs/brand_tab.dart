import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/brands_model.dart';
import 'package:syzee/services/brands_service.dart';
import 'package:syzee/ui/widgets/brand_tile_widget.dart';

class BrandTab extends StatefulWidget {
  const BrandTab({Key? key}) : super(key: key);

  @override
  State<BrandTab> createState() => _BrandTabState();
}

class _BrandTabState extends State<BrandTab> {
  late Future<BrandsModel> brandsList;

  @override
  void initState() {
    super.initState();
    brandsList = getAllBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.0,
            vertical: 25,
          ),
          child: Text(
            'Top Grossing Brands',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        FutureBuilder(
          future: brandsList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              BrandsModel brands = snapshot.data as BrandsModel;
              return Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 25.0,
                  mainAxisSpacing: 25.0,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  children: List.generate(brands.data.length, (index) {
                    return Center(
                      child: BrandTileWidget(
                        id: brands.data[index].id,
                        image: '${AssetConstants.mockImageLink}/BRANDS/${brands.data[index].imageCarousel}',
                        name: brands.data[index].name,
                      ),
                    );
                  }),
                ),
              );
            } else {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
