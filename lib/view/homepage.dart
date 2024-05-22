import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rest_api_get_implimentation_practice/model/gallery_model.dart';
import 'package:rest_api_get_implimentation_practice/view/detals_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _getImageListInProgress = false;
  List<GalleryModel> imageList = [];

  @override
  void initState() {
    super.initState();
    _getImageGalleryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: _getImageGalleryList,
        child: Visibility(
          visible: _getImageListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: imageList.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoDetails(
                    title: 'Photo Details',
                    photoDetail: imageList[index],
                  ),
                ),
              ),
              leading: Image.network(imageList[index].thumbnailUrl ??
                  'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_640.png'),
              title: Text(
                imageList[index].title ?? 'Image List',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 5.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getImageGalleryList() async {
    _getImageListInProgress = true;
    setState(() {});
    imageList.clear();
    const String imageListUrl = 'https://jsonplaceholder.typicode.com/photos';
    Uri uri = Uri.parse(imageListUrl);
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      final jsonProductList = decodedData;
      for (Map<String, dynamic> json in jsonProductList) {
        GalleryModel productModel = GalleryModel.fromJson(json);
        imageList.add(productModel);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Get Image list failed! Try again.')),
      );
    }

    _getImageListInProgress = false;
    setState(() {});
  }
}
