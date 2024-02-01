import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/home_provider.dart';
import '../text_style/fontstyle.dart';


class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

int _myCounter = 1;

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  AppBar get _buildAppBar {
    return AppBar(
      leading: InkWell(
        onTap: (){
          Get.back();
        },
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.black,
        ),
      ),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      title:
          SizedBox(width: 200, child: Image.asset("assets/images/favCart.png")),
      centerTitle: true,
    );
  }

  Widget get _buildBody {
    return Container(
      child: _buildGridView,
    );
  }

  Widget get _buildGridView {
    if (context.watch<HomeProvider>().favoriteList.isEmpty) {
      return Center(
        child: SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset("assets/lotties/noItem1.json")),
      );
    } else {
      return GridView.builder(
        itemCount: context.watch<HomeProvider>().favoriteList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            mainAxisExtent: 150),
        itemBuilder: (context, index) {
          return _buildItem(context.watch<HomeProvider>().favoriteList[index] as ProductModel);
        },
      );
    }
  }

  Widget _buildItem(ProductModel item) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(.1),
            offset: const Offset(.1, .1),
            blurRadius: 5,
            spreadRadius: .1,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onDoubleTap: (){
                context.read<HomeProvider>().addToFavoriteList(item);

              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft:  Radius.circular(15),
                      topRight: Radius.circular(15),
                    )),
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.maxFinite,
                child: Image.asset(item.image),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.15),
                borderRadius: const BorderRadius.only(
                  bottomLeft:  Radius.circular(15),
                  bottomRight:  Radius.circular(15),
                )),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.maxFinite,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: itemStyle,
                    ),
                    Text(
                      "${item.price}\$",
                      style: priceStyle,
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          context.read<HomeProvider>().addToFavoriteList(item);
                        });
                      },
                      child: context
                              .watch<HomeProvider>()
                              .favoriteList
                              .contains(item)
                          ? Icon(
                              Icons.favorite_rounded,
                              color: const Color(0xFFff0000).withOpacity(.8),
                              size: 28,
                            )
                          : const Icon(
                              Icons.favorite_border_outlined,
                              color:  Color(0xFF3C4142),
                              size: 28,
                            ),
                    ),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        _buildBottomSheet(item, context);
                      },
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Color(0xFF3C4142),
                        size: 28,
                      ),
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

  _buildBottomSheet(ProductModel item, BuildContext context) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius:  BorderRadius.only(
          topLeft:  Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return SizedBox(
              height: 430,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.name,
                          style: btnSheetHeaderStyle,
                        ),
                        InkWell(
                            onTap: () {
                              Get.back();
                              _myCounter = 1;
                            },
                            child: const Icon(
                              Icons.cancel,
                              size: 30,
                              color: Colors.black26,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 200,
                    child: Image.asset(item.image),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "COLOUR",
                              style: btnSheetHeaderStyle,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Color(item.color),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 70,
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "PRICE",
                              style: btnSheetHeaderStyle,
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "\$ ${item.price * _myCounter}",
                              style: itemStyle,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(children: [
                        Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xFF3C4142).withOpacity(.2),
                              )),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                setState(() {
                                  if (_myCounter > 0) {
                                    _myCounter--;
                                    item.qty = _myCounter;
                                  }
                                });
                              });
                            },
                            child: const Icon(
                              Icons.remove_rounded,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _myCounter.toString(),
                          style: btnSheetHeaderStyle,
                        ),
                        const SizedBox(width: 8),
                        Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xFF3C4142).withOpacity(.2),
                                )),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _myCounter++;
                                  item.qty = _myCounter;
                                });
                              },
                              child: const Icon(
                                Icons.add_rounded,
                                size: 25,
                              ),
                            )),
                      ]),
                      InkWell(
                        onTap: () {
                          setState(() {
                            
                            context.read<HomeProvider>().addToCartList(item);
                            _myCounter = 1;
                            Get.back();
                          });
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF383fa5),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const[
                              BoxShadow(
                                color: Colors.black38,
                                offset:  Offset(.1, .1),
                                blurRadius: 5,
                                spreadRadius: .1,
                              ),
                            ],
                          ),
                          child: const Text(
                            "ADD TO CART",
                            style:  TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Roboto',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      context: context,
    );
  }
}
