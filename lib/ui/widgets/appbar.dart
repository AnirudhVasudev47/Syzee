import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/global/theme.dart';
import 'package:syzee/ui/screen/cart_screen.dart';
import 'package:syzee/ui/screen/search_screen.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.showBag, this.showSearch}) : super(key: key);

  final bool? showBag;
  final bool? showSearch;

  static final _appBar = AppBar();

  @override
  Size get preferredSize => _appBar.preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: currentTheme.currentTheme == ThemeMode.dark
          ? Colors.black
          : Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Image.asset(
        AssetConstants.blackLogo,
        fit: BoxFit.contain,
        height: 35,
        width: 104,
      ),
      leading: widget.showSearch ?? true ?
      IconButton(
        icon: const Icon(
          Icons.search,
          size: 30,
          color: Color(0xff000000),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                // return const CartEmptyScreen();
                return const SearchScreen();
              },
            ),
          );
        },
      )
      : Container(),
      actions: [
        widget.showBag ?? true
            ? Container(
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // return const CartEmptyScreen();
                          return const CartScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SvgPicture.asset(
                      'assets/images/home/appbar/bag.svg',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
