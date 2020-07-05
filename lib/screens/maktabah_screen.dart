import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class MaktabahScreen extends StatefulWidget {
  static const routName = '/maktabah_screen';
  const MaktabahScreen({Key key}) : super(key: key);

  @override
  _MaktabahScreenState createState() => _MaktabahScreenState();
}

class _MaktabahScreenState extends State<MaktabahScreen> {
  String filePath = '';

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();

      File file = File("${dir.path}/Fiqhul-Fitan.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }

  @override
  void initState() {
    super.initState();

    getFileFromAsset('assets/files/Fiqhul-Fitan.pdf').then((f) {
      setState(() {
        filePath = f.path;
      });
      print(filePath);
    });
  }

  // int _totalPages = 0;
  // int _currentPage = 0;
  bool pdfReady = false;
  // PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fiqhul Fitan"),
      ),
      body: Stack(
        children: <Widget>[
          filePath.isEmpty
              ? CircularProgressIndicator()
              : PDFView(
                  filePath: filePath,
                  autoSpacing: true,
                  enableSwipe: true,
                  pageSnap: false,
                  swipeHorizontal: false,
                  nightMode: false,
                  onError: (e) {
                    print(e);
                  },
                  // onRender: (_pages) {
                  //   setState(() {
                  //     _totalPages = _pages;
                  //     pdfReady = true;
                  //   });
                  // },
                  // onViewCreated: (PDFViewController vc) {
                  //   setState(() {
                  //     _pdfViewController = vc;
                  //   });
                  // },
                  // onPageChanged: (int page, int total) {
                  //   print('page change: $page/$total');
                  //   setState(() {
                  //     _currentPage = page;
                  //   });
                  // },
                  onPageError: (page, e) {
                    print(e);
                  },
                ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     _currentPage > 0
      //         ? FloatingActionButton.extended(
      //             backgroundColor: Colors.red,
      //             label: Text("Go to ${_currentPage - 1}"),
      //             onPressed: () {
      //               _currentPage -= 1;
      //               _pdfViewController.setPage(_currentPage);
      //             },
      //           )
      //         : Offstage(),
      //     _currentPage + 1 < _totalPages
      //         ? FloatingActionButton.extended(
      //             backgroundColor: Colors.green,
      //             label: Text("Go to ${_currentPage + 1}"),
      //             onPressed: () {
      //               _currentPage += 1;
      //               _pdfViewController.setPage(_currentPage);
      //             },
      //           )
      //         : Offstage(),
      //   ],
      // ),
    );
  }
}
