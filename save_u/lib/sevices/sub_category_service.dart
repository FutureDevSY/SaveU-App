import 'package:save_u/db_helper/repository.dart';

class SubCategoryService {
  late Repository _repository;
  SubCategoryService() {
    _repository = Repository();
  }

  //모든 SubCategory 가져오기
  readAllSubCategories() async {
    return await _repository.readData('subCategory');
  }

  //카테고리 아이디로 SubCategory 가져오기
  readSubCategoriesByCategoryId(int categoryId) async {
    return await _repository.readDataByColumn(
        'subCategory', 'categoryId', categoryId);
  }
}
