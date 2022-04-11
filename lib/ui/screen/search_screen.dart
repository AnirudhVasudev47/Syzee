import 'package:flutter/material.dart';
import 'package:syzee/global/constants.dart';
import 'package:syzee/models/search_model.dart';
import 'package:syzee/services/products_services.dart';
import 'package:syzee/ui/screen/single_product_screen.dart';
import 'package:syzee/ui/widgets/appbar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchText = TextEditingController();
  late Future<SearchModel> search;
  String searchValue = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        showSearch: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 12,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 12,
              ),
              decoration: const BoxDecoration(
                  color: Color(0x08000000),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  )),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchText,
                      onChanged: (text) {
                        search = searchProduct(text);
                        setState(() {
                          searchValue = text;
                        });
                      },
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      searchText.text = '';
                      setState(() {
                        searchValue = '';
                      });
                    },
                    child: Image.asset(
                      searchValue == '' ? AssetConstants.searchIcon : AssetConstants.cancelIcon,
                      height: 20,
                      width: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            searchText.text != ''
                ? FutureBuilder(
              future: search,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  SearchModel searchData = snapshot.data as SearchModel;
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: const Text(
                          'Women',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemCount: searchData.data.womenSearch.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SingleProductScreen(
                                          mainCat: searchData.data.womenSearch[index].mainCatId == 1
                                              ? MainCategory.women
                                              : MainCategory.kids,
                                          id: searchData.data.womenSearch[index].productId,
                                        ),
                                      ),
                                    );
                                  },
                                  selected: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 35),
                                  title: Text(
                                    searchData.data.womenSearch[index].name,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                                  trailing: Image.asset(
                                    AssetConstants.arrowUpRight,
                              width: 12,
                              height: 12,
                            ),
                          );
                        },
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 35.0),
                        child: const Text(
                          'Kids',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ListView.builder(
                        itemCount: searchData.data.kidsSearch.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleProductScreen(
                                    mainCat: searchData.data.womenSearch[index].mainCatId == 1
                                        ? MainCategory.women
                                        : MainCategory.kids,
                                    id: searchData.data.womenSearch[index].productId,
                                  ),
                                ),
                              );
                            },
                            selected: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 35),
                            title: Text(
                              searchData.data.kidsSearch[index].name,
                                    style: const TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                    ),
                                  ),
                            trailing: Image.asset(
                              AssetConstants.arrowUpRight,
                              width: 12,
                              height: 12,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )
            : Container(),
          ],
        ),
      ),
    );
  }
}
