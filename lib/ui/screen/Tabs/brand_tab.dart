import 'package:flutter/material.dart';
import 'package:syzee/models/brands_model.dart';
import 'package:syzee/ui/widgets/brand_product_list.dart';
import 'package:syzee/ui/widgets/brand_tile_widget.dart';
import 'package:syzee/ui/widgets/wishlist_product_list.dart';

class BrandTab extends StatefulWidget {
  const BrandTab({Key? key}) : super(key: key);

  @override
  State<BrandTab> createState() => _BrandTabState();
}

class _BrandTabState extends State<BrandTab> {

  late Future<BrandsModel> brandsList;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        BrandTileWidget(),
      ],
    );
  }
}
