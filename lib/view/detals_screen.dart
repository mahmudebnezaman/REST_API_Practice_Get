import 'package:flutter/material.dart';

class PhotoDetails extends StatelessWidget {
  final String title;
  final dynamic photoDetail;

  const PhotoDetails(
      {super.key, required this.title, required this.photoDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              photoDetail.url ??
                  'https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132_640.png',
            ),
            Text(
              "Title: ${photoDetail.title ?? 'Image List'}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              "ID: ${photoDetail.id ?? 'Unknown'}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
