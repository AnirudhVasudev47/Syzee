import 'package:flutter/material.dart';

enum SelectedTab {
  products,
  brands,
}

class ProductOrBrand extends StatefulWidget {
  const ProductOrBrand({Key? key, required this.tab, required this.isProduct, required this.onTap}) : super(key: key);

  final SelectedTab tab;
  final bool isProduct;
  final VoidCallback onTap;

  @override
  State<ProductOrBrand> createState() => _ProductOrBrandState();
}

class _ProductOrBrandState extends State<ProductOrBrand> {

  SelectedTab selectedTab = SelectedTab.products;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedTab = widget.tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        widget.isProduct
            ? ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff169B93),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 45,
            ),
          ),
          child: const Text(
            'Products',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        )
            : OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Color(0xff169B93),
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 45,
            ),
          ),
          onPressed: widget.onTap,
          child: const Text(
            'Products',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        !widget.isProduct
            ? ElevatedButton(
          onPressed: widget.onTap,
          style: ElevatedButton.styleFrom(
            primary: const Color(0xff169B93),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 45,
            ),
          ),
          child: const Text(
            'Brands',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        )
            : OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Color(0xff169B93),
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 45,
            ),
          ),
          onPressed: widget.onTap,
          child: const Text(
            'Brands',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
