import 'package:deliveryapp_project/restaurant/model/rastaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

//인스턴스를 못하게 한다(abstract)
abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true, //<T>를 생성하기 위한
)
//<T> List타입의 변수
class CursorPagination<T> extends CursorPaginationBase {
  late final CursorPaginationMeta meta;
  late final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  CursorPagination copyWith({
    final CursorPaginationMeta? meta,
    final List<T>? data,
  }) {
    return CursorPagination<T>(
        meta: meta ?? this.meta, data: data ?? this.data);
  }

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool hasMore;

  CursorPaginationMeta({
    required this.count,
    required this.hasMore,
  });

  CursorPaginationMeta copyWith({
    final int? count,
    final bool? hasMore,
  }) {
    return CursorPaginationMeta(
      count: count ?? this.count,
      hasMore: this.hasMore,
    );
  }

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

// 새로고침 할때

class CursorPaginationRefetching<T> extends CursorPagination<T> {
  CursorPaginationRefetching({
    required super.meta,
    required super.data,
  });
}

// 리스트의 맨 아래로 내려서
// 추가 데이터를 요청하는중
class CursorPaginationFetchingMore<T> extends CursorPagination<T> {
  CursorPaginationFetchingMore({
    required super.meta,
    required super.data,
  });
}
