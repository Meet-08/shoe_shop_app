import 'package:flutter/material.dart';
import 'package:shop_app/global_variable.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final FocusNode _searchFocusNode = FocusNode();
  final List<String> filters = const ["All", "Adidas", "Nike", "Puma"];
  late List<Map<String, Object>> filteredProducts = products;
  late String selectedFilter;
  int currentPage = 0;

  void selectFilter(String filter) {
    setState(() {
      selectedFilter = filter;
      filteredProducts = products.where((product) {
        if (selectedFilter == "All") return true;
        return product["company"] == selectedFilter;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    filteredProducts = products;
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  "Shoes\ncollection",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: TextField(
                  focusNode: _searchFocusNode,
                  autofocus: false,
                  onChanged: (value) {
                    setState(() {
                      if (value.isEmpty) {
                        filteredProducts = products;
                        return;
                      }
                      filteredProducts = products
                          .where(
                            (product) => product["title"]
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase()),
                          )
                          .toList();
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () => selectFilter(filter),
                    child: Chip(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 15,
                      ),
                      label: Text(filter),
                      labelStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      backgroundColor: filter == selectedFilter
                          ? Theme.of(context).colorScheme.primary
                          : const Color.fromRGBO(245, 247, 249, 1),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    _searchFocusNode.unfocus();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDetailsPage(product: product);
                        },
                      ),
                    );
                  },
                  child: ProductCard(
                    title: product["title"] as String,
                    price: product["price"] as double,
                    imageUrl: product["imageUrl"] as String,
                    index: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
