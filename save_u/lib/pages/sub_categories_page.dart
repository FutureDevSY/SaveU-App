import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:save_u/models/sub_category.dart';
import '../sevices/sub_category_service.dart';
import 'safe_infos_page.dart';

class SubCategoriesPage extends StatefulWidget {
  final int categoryId;
  const SubCategoriesPage({Key? key, required this.categoryId})
      : super(key: key);

  @override
  State<SubCategoriesPage> createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  late List<SubCategory> _subCategoryList = <SubCategory>[];
  final _subCategoryService = SubCategoryService();

  getAllSubCategories() async {
    var subCategories = await _subCategoryService
        .readSubCategoriesByCategoryId(widget.categoryId);
    _subCategoryList = <SubCategory>[];
    subCategories.forEach((subCategory) {
      setState(() {
        var subCategoryModel = SubCategory();
        subCategoryModel.id = subCategory['id'];
        subCategoryModel.name = subCategory['name'];
        subCategoryModel.categoryId = subCategory['categoryId'];
        _subCategoryList.add(subCategoryModel);
      });
    });
  }

  @override
  void initState() {
    getAllSubCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("세부 카테고리 정보"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: _subCategoryList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SafeInfosPage(
                                subCategory: _subCategoryList[index],
                              )));
                },
                leading: const Icon(CupertinoIcons.doc_text_search),
                title: Text(_subCategoryList[index].name ?? ''),
                //trailing: const Icon(CupertinoIcons.doc_text_search),
              ),
            );
          }),
    );
  }
}
