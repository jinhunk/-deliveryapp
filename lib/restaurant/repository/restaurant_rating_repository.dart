import 'package:deliveryapp_project/common/const/data.dart';
import 'package:deliveryapp_project/common/dio/dio.dart';
import 'package:deliveryapp_project/common/model/cursor_pagination_model.dart';
import 'package:deliveryapp_project/common/model/pagination_params.dart';
import 'package:deliveryapp_project/common/repository/base_pagination.repository.dart';
import 'package:deliveryapp_project/rating/model/rating_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart'; // RestApi

part 'restaurant_rating_repository.g.dart';

final restaurantRatingRepositoryProvider =
    Provider.family<RestaurantRatingRepository, String>((ref, id) {
  final dio = ref.watch(dioProvider);

  return RestaurantRatingRepository(dio,
      baseUrl: 'http://$ip/restaurant/$id/rating');
});

//http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository
    implements IBasePaginationRepository<RatingModel> {
  factory RestaurantRatingRepository(Dio dio, {String baseUrl}) =
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RatingModel>> pageinate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
