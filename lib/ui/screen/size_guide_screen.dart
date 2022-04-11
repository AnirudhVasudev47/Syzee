import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/size_chart_model.dart';
import 'package:syzee/services/product.dart';
import 'package:syzee/ui/widgets/appbar.dart';
import 'package:syzee/ui/widgets/size_table.dart';

class SizeGuideScreen extends StatefulWidget {
  const SizeGuideScreen({
    Key? key,
    required this.productId,
    required this.mainCat,
    required this.prodImg,
  }) : super(key: key);

  final int productId;
  final MainCategory mainCat;
  final String prodImg;

  @override
  State<SizeGuideScreen> createState() => _SizeGuideScreenState();
}

class _SizeGuideScreenState extends State<SizeGuideScreen> {
  late Future<SizeChartModel> sizeChart;

  @override
  void initState() {
    super.initState();
    sizeChart = getProductSizeChart(widget.productId.toString(), widget.mainCat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: FutureBuilder(
        future: sizeChart,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            SizeChartModel data = snapshot.data as SizeChartModel;
            return DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    tabs: [
                      Tab(text: 'SIZE GUIDE'),
                      Tab(text: 'HOW TO MEASURE'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        SizeTable(
                          data: data,
                          prodImg: widget.prodImg,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Size Guide',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Image.network(
                              '${AssetConstants.mockImageLink}/women/${data.result.sizeImage}',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.6,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

/*


 */