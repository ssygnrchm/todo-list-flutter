import 'package:my_first_app/model/list_model.dart';

class CategoryService {
  static final Map<String, List<ListModel>> _categoryData = {};

  static List<ListModel> getOrCreateListData(String categoryName) {
    if (!_categoryData.containsKey(categoryName)) {
      _categoryData[categoryName] = [];
    }
    return _categoryData[categoryName]!;
  }
}
