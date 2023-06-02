import 'package:deliveryapp_project/common/component/pagination_list_view.dart';
import 'package:deliveryapp_project/product/component/product_card.dart';
import 'package:deliveryapp_project/product/model/product_model.dart';
import 'package:deliveryapp_project/product/provider/product_provider.dart';
import 'package:deliveryapp_project/restaurant/view/rastaurant_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RestaurantDetailScreen(
                  id: model.restaurant.id,
                ),
              ),
            );
          },
          child: ProductCard.fromProductModel(
            model: model,
          ),
        );
      },
    );
  }
}
