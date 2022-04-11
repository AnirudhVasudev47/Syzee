import 'package:flutter/material.dart';
import 'package:syzee/ui/screen/single_brand_screen.dart';

class BrandTileWidget extends StatefulWidget {
  final String image;
  final String name;
  final int id;

  const BrandTileWidget(
      {Key? key, required this.image, required this.name, required this.id})
      : super(key: key);

  @override
  _BrandTileWidgetState createState() => _BrandTileWidgetState();
}

class _BrandTileWidgetState extends State<BrandTileWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SingleBrandScreen(
              name: widget.name,
              id: widget.id,
              image: widget.image,
            ),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 0),
              )
            ],
            borderRadius: BorderRadius.circular(100),
          ),
          child: Image.network(
            widget.image,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
