import 'package:deliveryapp_project/common/model/cursor_pagination_model.dart';
import 'package:deliveryapp_project/common/model/model_with_id.dart';
import 'package:deliveryapp_project/common/model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> pageinate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
