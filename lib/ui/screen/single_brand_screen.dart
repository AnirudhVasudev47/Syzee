import 'package:flutter/material.dart';
import 'package:syzee/models/single_brands_model.dart';
import 'package:syzee/services/brands_service.dart';
import 'package:syzee/ui/widgets/appbar.dart';
import 'package:syzee/ui/widgets/brand_product_list.dart';

class SingleBrandScreen extends StatefulWidget {
  final String name;
  final String image;
  final int id;

  const SingleBrandScreen(
      {Key? key, required this.name, required this.image, required this.id})
      : super(key: key);

  @override
  State<SingleBrandScreen> createState() => _SingleBrandScreenState();
}

class _SingleBrandScreenState extends State<SingleBrandScreen> {
  late var brand;
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    brand = getBrandsProducts(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(),
        body: FutureBuilder(
          future: brand,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              SingleBrandsModel data = snapshot.data as SingleBrandsModel;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.contain,
                      alignment: Alignment.center,
                      height: 90,
                      width: 125,
                    ),
                  ),
                  Text(
                    '${data.data.length} Items',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    color: const Color.fromRGBO(0, 0, 0, 0.65),
                    child: Text(
                      'Welcome to ${widget.name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BrandProductList(
                      model: data,
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

/*

          SizedBox(
            height: 40,
            child: ListView.builder(
              itemCount: listData.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTab = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: index == selectedTab
                              ? const Color(0xff0A5F5B)
                              : const Color(0xffD3D3D3),
                        ),
                      ),
                      child: Text(
                        listData.elementAt(index),
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
 */