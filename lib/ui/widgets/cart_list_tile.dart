import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';

class CartListTile extends StatefulWidget {
  const CartListTile({
    Key? key,
    required this.image,
    required this.name,
    required this.tagLine,
    required this.size,
    required this.qty,
    required this.price,
    required this.deleteBtn,
    required this.id,
    required this.updateBtn,
    required this.mainId,
  }) : super(key: key);

  final int mainId;
  final String image;
  final String name;
  final String tagLine;
  final String size;
  final String qty;
  final String price;
  final String id;
  final void Function() deleteBtn;
  final void Function(int qty) updateBtn;

  @override
  State<CartListTile> createState() => _CartListTileState();
}

class _CartListTileState extends State<CartListTile> {
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool isOpen = false;
  String imageLink = '';

  @override
  void initState() {
    super.initState();

    setState(() {
      imageLink = widget.mainId == 1
          ? '${AssetConstants.mockImageLink}/women'
          : widget.mainId == 3
          ? '${AssetConstants.mockImageLink}/men'
          : '${AssetConstants.mockImageLink}/kids';
    });

  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox!.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0.0, 50.0),
          child: Material(
            elevation: 4.0,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: int.parse(widget.qty),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${index + 1}',
                  ),
                  onTap: () async {
                    _overlayEntry!.remove();
                    if (index + 1 != int.parse(widget.qty)) {
                      widget.updateBtn(index + 1);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 21,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              SizedBox(
                height: 125,
                width: 125,
                child: Image.network(
                  '$imageLink/${widget.image}',
                  height: 125,
                  width: 125,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      widget.tagLine,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                      ),
                    ),
                    // Text(
                    //   'Sold by : Syzee international',
                    //   style: TextStyle(
                    //     fontFamily: 'Montserrat',
                    //     fontSize: 12,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0x0f000000),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: Text(
                            'Size: ${widget.size}',
                            style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        CompositedTransformTarget(
                          link: _layerLink,
                          child: InkWell(
                            onTap: () {
                              _overlayEntry = _createOverlayEntry();
                              Overlay.of(context)!.insert(_overlayEntry!);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0x0f000000),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              child: Text(
                                'Qty: ${widget.qty}',
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     const Text(
                    //       'Color: Yellow ',
                    //       style: TextStyle(
                    //         fontFamily: 'Montserrat',
                    //         fontSize: 12,
                    //       ),
                    //     ),
                    //     Container(
                    //       height: 12,
                    //       width: 12,
                    //       decoration: const BoxDecoration(
                    //         color: Color(0xffB2732B),
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(10),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Text(
                      'QAR ${widget.price}',
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff009B93)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: widget.deleteBtn,
                child: Image.asset(
                  AssetConstants.bin,
                  height: 20,
                  width: 20,
                ),
              ),
              const VerticalDivider(
                thickness: 2,
                width: 2,
                color: Color(0xffB6874A),
              ),
              Image.asset(
                AssetConstants.heartActive,
                height: 20,
                width: 20,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Divider(
          thickness: 2,
          height: 2,
          color: Color(0xffB6874A),
        ),
      ],
    );
  }
}
