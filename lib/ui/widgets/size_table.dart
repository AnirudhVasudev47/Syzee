import 'package:flutter/material.dart';

import '../../models/size_chart_model.dart';

class SizeTable extends StatefulWidget {
  const SizeTable({Key? key, required this.data, required this.prodImg}) : super(key: key);

  final SizeChartModel data;
  final String prodImg;

  @override
  State<SizeTable> createState() => _SizeTableState();
}

class _SizeTableState extends State<SizeTable> {
  @override
  Widget build(BuildContext context) {
    SizeChartModel chart = widget.data;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Body Measurement(inches)',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                color: Color(0xff009C95),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 15.0,
              ).copyWith(top: 20),
              child: const Divider(
                color: Colors.black,
                thickness: 1,
                height: 0,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                top: 15,
              ),
              child: Table(
                border: TableBorder.all(
                  color: Colors.black,
                  style: BorderStyle.solid,
                  width: 1,
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: chart.result.tableHeader
                        .map(
                          (e) => Text(
                            e,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 14,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ...chart.result.tableRows
                      .map(
                        (e) => TableRow(
                          children: e
                              .map(
                                (e) => Text(
                                  e,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 15.0,
              ).copyWith(top: 20),
              child: const Divider(
                color: Colors.black,
                thickness: 1,
                height: 0,
              ),
            ),
            const Text(
              'Model Measurements',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                color: Color(0xff009C95),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15.0),
              child: Image.network(
                widget.prodImg,
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Size: ' + chart.result.modelSize,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
            Text(
              'Height: ' + chart.result.modelHeight,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
            Text(
              'Chest: ' + chart.result.modelChest,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
