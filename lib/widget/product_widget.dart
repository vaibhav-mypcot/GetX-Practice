import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_practice/routes/app_routes.dart';
import 'package:getx_practice/screens/cart/cart_controller.dart';
import 'package:getx_practice/utils/constant.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    super.key,
    required this.productList,
  });

  final cartController = Get.find<CartController>();
  final List productList;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            mainAxisExtent: 250,
          ),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.productDetailScreen, parameters: {
                  'title': productList[index].title.toString(),
                  'image': productList[index].image.toString(),
                  'price': productList[index].price.toString(),
                  'description': productList[index].description.toString(),
                  'category': productList[index].category.toString(),
                });
              },
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 2, color: Colors.grey, offset: Offset(0, 3))
                  ],
                ),
                margin: const EdgeInsets.all(8),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 12),
                          child: Image.network(
                              productList[index].image.toString(),
                              height: 120),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            productList[index].title.toString(),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text('₹ ${productList[index].price.toString()}'),
                      ],
                    ),
                    // Add to cart button
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      // color: Colors.amberAccent,
                      alignment: Alignment.bottomCenter,
                      padding:
                          const EdgeInsets.only(bottom: 6, left: 14, right: 14),
                      child: InkWell(
                        onTap: () {
                          print('index that click: ${productList[index].id}');

                          //SnackBar
                          Get.showSnackbar(
                            GetSnackBar(
                              title: productList[index].title,
                              message: 'Added to cart',
                              duration: const Duration(seconds: 2),
                            ),
                          );

                          // Add data in cart list
                          cartController.getClickedProductDataController(
                            productList[index].id!.toInt(),
                            productList[index].image.toString(),
                            productList[index].title.toString(),
                            productList[index].price!.toDouble(),
                          );
                        },
                        child: Obx(
                          () => cartController.isIdInCartList(
                                  productList[index].id!.toInt())
                              ? const SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    "Item Added to cart",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                )
                              : Container(
                                  height: 34,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.orange),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        addToCart,
                                        fit: BoxFit.cover,
                                        height: 18,
                                        width: 18,
                                      ),
                                      SizedBox(width: 12),
                                      const Text(
                                        "Add to cart",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    // Wishlist hear button
                    Container(
                      height: 44,
                      width: double.infinity,
                      // color: Colors.amberAccent,
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(right: 14, top: 14),
                      child: GestureDetector(
                        onTap: () {
                          print(
                              'wishlist that click: ${productList[index].id}');

                          // Add data in cart list
                          cartController.getClickedWishlistDataController(
                            productList[index].id!.toInt(),
                            productList[index].image.toString(),
                            productList[index].title.toString(),
                            productList[index].price!.toDouble(),
                          );
                        },
                        child: Obx(
                          () => cartController
                                  .isIdInWishList(productList[index].id)
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
