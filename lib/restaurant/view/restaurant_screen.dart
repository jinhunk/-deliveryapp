import 'package:deliveryapp_project/common/component/pagination_list_view.dart';
import 'package:deliveryapp_project/restaurant/component/restaurant_card.dart';
import 'package:deliveryapp_project/restaurant/provider/restaurant_provider.dart';
import 'package:deliveryapp_project/restaurant/view/rastaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        itemBuilder: <RestaurantModel>(_, index, model) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(id: model.id),
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: model,
            ),
          );
        },
        provider: restaurantProvider);
  }
}
