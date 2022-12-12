import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/safe_info.dart';
import '../sevices/safe_info_service.dart';

class SafeInfoDetailPage extends StatefulWidget {
  final SafeInfo safeInfo;
  const SafeInfoDetailPage({Key? key, required this.safeInfo})
      : super(key: key);

  @override
  State<SafeInfoDetailPage> createState() => _SafeInfoDetailPageState();
}

class _SafeInfoDetailPageState extends State<SafeInfoDetailPage> {
  final _safeInfoService = SafeInfoService();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("안전 정보 상세 보기"),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    widget.safeInfo.title ?? '',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: IconButton(
                    icon: widget.safeInfo.scrap == 0
                        ? Icon(CupertinoIcons.bookmark)
                        : Icon(
                            CupertinoIcons.bookmark_fill,
                            color: Colors.yellow,
                          ),
                    onPressed: () async {
                      if (widget.safeInfo.scrap == 0) {
                        //스크랩 X인 경우
                        setState(() {
                          widget.safeInfo.scrap = 1;
                        });
                      } else if (widget.safeInfo.scrap == 1) {
                        //스크랩 한 경우
                        setState(() {
                          widget.safeInfo.scrap = 0;
                        });
                      }
                      await _safeInfoService.updateSafeInfoScrap(
                          widget.safeInfo.id ?? 0, widget.safeInfo.scrap ?? 0);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                                child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 100,
                              strutStyle: StrutStyle(fontSize: 16.0),
                              text: TextSpan(
                                  text: widget.safeInfo.content ??
                                      '안전 정보를 불러오는 데 실패했습니다.',
                                  style: TextStyle(
                                      color: Colors.black,
                                      height: 1.4,
                                      fontSize: 16.0,
                                      fontFamily: 'NanumSquareRegular')),
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(child: Text("출처 : ${widget.safeInfo.link!}")),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
