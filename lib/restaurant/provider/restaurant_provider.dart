import 'package:deliveryapp_project/common/model/cursor_pagination_model.dart';
import 'package:deliveryapp_project/common/model/pagination_params.dart';
import 'package:deliveryapp_project/common/provider/pagination_provider.dart';
import 'package:deliveryapp_project/restaurant/model/rastaurant_model.dart';

import 'package:deliveryapp_project/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';

final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }
  //만약 데이터가 존재하지 않는다면 null을 던져줌
  return state.data.firstWhereOrNull((element) => element.id == id);
});

//riverpod 프로바이더
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);
  final notirier = RestaurantStateNotifier(repository: repository);

  return notirier;
});

class RestaurantStateNotifier
    extends PaginationProvider<RestaurantModel, RestaurantRepository> {
  RestaurantStateNotifier({
    required super.repository,
  });

  void getDetail({
    required String id,
  }) async {
    // 만약에 아직 데이터가 하나도 없는 상태라면 (CursoPagination이 아니라면)
    // 데이터를 가져오는 시도를 한다.
    if (state is! CursorPagination) {
      await paginate();
    }

    // state가 CursorPagination이 아닐때 그냥 리턴
    if (state is! CursorPagination) {
      return;
    }

    final pState = state as CursorPagination;

    final resp = await repository.getRestaurantDetail(id: id);

    //데이터가 없을때는 그냥 캐시의 끝에다가 데이터를 추가해버린다.
    if (pState.data.where((e) => e.id == id).isEmpty) {
      state = pState.copyWith(
        data: <RestaurantModel>[
          ...pState.data,
          resp,
        ],
      );
    } else {
      //[RestaurantMode(1),RestaurantMode(2),RestaurantMode(3)]
      // id : 2인 친구를
      state = pState.copyWith(
        data: pState.data
            .map<RestaurantModel>((e) => e.id == id ? resp : e)
            .toList(),
      );
    }
  }
}
