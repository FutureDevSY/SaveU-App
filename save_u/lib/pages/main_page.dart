import 'package:flutter/material.dart';
import 'package:save_u/pages/sub_categories_page.dart';

class MainPage extends StatelessWidget {
  // const MainPage({required this.userEmail, super.key});
  // final String userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(children: [
              //CategoryPage(),
              Container(
                  margin: EdgeInsets.only(right: 250),
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text('오늘의 안전상식')),
              Container(
                  //오늘의 안전상식 본문
                  padding: EdgeInsets.all(10),
                  color: Color.fromRGBO(196, 223, 246, 300),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('Q. 차량 급발진, 어떻게 대처해야 할 지 막막하신가요?'),
                      ),
                      Container(
                        padding: EdgeInsets.zero,
                        child: Text(
                            '누구에게나 일어날 수 있는 차량 급발진 상황,어떻게 현명하게 대처할 수 있을까요?'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          print('당장 알아보기 버튼 클릭함');
                        },
                        child: Text('당장 알아보러 가기'),
                      ),
                    ],
                  )),
              Container(
                  //검색창
                  margin: EdgeInsets.only(top: 10),
                  child: OutlinedButton.icon(
                    //child를 무조건 가져야 하나 봄
                    onPressed: () {
                      print('홈화면 검색버튼 클릭함');
                    },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    //child: Text('궁금한 정보가 있나요? 키워드 검색으로 쉽게 찾아보세요'),
                    label: Text(
                      '궁금한 정보가 있나요? 키워드 검색으로 쉽게 찾아보세요',
                      style: TextStyle(
                          fontSize: 13,
                          color: Color.fromARGB(255, 132, 132, 132)),
                    ),
                    icon: Icon(Icons.search,
                        size: 20, color: Colors.black87), // 아이콘 색
                  )),
              Container(
                margin: EdgeInsets.only(right: 230),
                padding: EdgeInsets.only(top: 15),
                child: Text('카테고리별 안전상식'),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                // color: Color.fromRGBO(196, 223, 246, 300),
                height: 130,
                // width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // width: 120,

                      child: IconButton(
                        icon: Image.asset('assets/icons/CircleIcon1.png'),
                        iconSize: 100,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubCategoriesPage(categoryId: 1),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      // width: 120,
                      child: IconButton(
                        icon: Image.asset('assets/icons/CircleIcon2.png'),
                        iconSize: 100,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubCategoriesPage(categoryId: 2),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      // width: 120,
                      child: IconButton(
                        icon: Image.asset('assets/icons/CircleIcon3.png'),
                        iconSize: 100,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubCategoriesPage(categoryId: 3),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('자연재해'),
                    Text('범죄상황'),
                    Text('신체이상'),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                // padding: EdgeInsets.all(10),
                // color: Color.fromRGBO(196, 223, 246, 300),
                height: 130,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: IconButton(
                        icon: Image.asset('assets/icons/CircleIcon4.png'),
                        iconSize: 100,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubCategoriesPage(categoryId: 4),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Image.asset('assets/icons/CircleIcon5.png'),
                        iconSize: 100,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubCategoriesPage(categoryId: 5),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Image.asset('assets/icons/CircleIcon6.png'),
                        iconSize: 100,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubCategoriesPage(categoryId: 6),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(35, 0, 35, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('교통안전'),
                    Text('사회재난'),
                    Text('기타돌발상황'),
                  ],
                ),
              ),
            ])));
  }
}
