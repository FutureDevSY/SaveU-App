import '../db_helper/repository.dart';

class SafeInfoService {
  late Repository _repository;
  SafeInfoService() {
    _repository = Repository();
  }

  readSafeInfoById(int id) async {
    return await _repository.readDataById('safeInfo', id);
  }

  readSafeInfosBySubCategoryId(int subCategoryId) async {
    return await _repository.readDataByColumn(
        'safeInfo', 'subCategoryId', subCategoryId);
  }

  readSafeInfosByScrap() async {
    return await _repository.readDataByColumn('safeInfo', 'scrap', 1);
  }

  updateSafeInfoScrap(int id, int scrap) async {
    return await _repository.updateColumn('safeInfo', id, 'scrap', scrap);
  }
}
