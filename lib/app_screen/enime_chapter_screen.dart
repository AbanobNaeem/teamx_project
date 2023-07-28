import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EnimeChapterScreen extends StatefulWidget {
  const EnimeChapterScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.noOfChapters,
      required this.enimeChapter});

  final String name;
  final String image;
  final String noOfChapters;
  final List enimeChapter;

  @override
  State<EnimeChapterScreen> createState() => _EnimeChapterScreenState();
}

class _EnimeChapterScreenState extends State<EnimeChapterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        title: Column(
          children: [
            Text(widget.name),
            Text(
              widget.noOfChapters,
              style: TextStyle(color: Colors.grey[700], fontSize: 15),
            )
          ],
        ),
        leading: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Close",
              style: TextStyle(color: Colors.white, fontSize: 15),
            )),
      ),
      body: Container(
          margin: EdgeInsets.all(20),
          child: ListView.builder(itemBuilder: (context, index) {
            return Image.network(
              widget.enimeChapter[index],

            );

          },
          itemCount: widget.enimeChapter.length,
          )),
    );
  }
}
