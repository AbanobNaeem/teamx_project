
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/app_screen/enime_chapter_screen.dart';
import 'package:teamx_project/component/home_screen_component_design/anime_component_design/show_anime_details.dart';

class ShowAllScreen extends StatefulWidget {
  final List lastAdded;

  ShowAllScreen({
    Key? key,
    required this.lastAdded,
  }) : super(key: key);

  @override
  State<ShowAllScreen> createState() => _ShowAllScreenState();
}

class _ShowAllScreenState extends State<ShowAllScreen> {
  late ScrollController _controller;
  String appBarTitle = "";

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_rounded)),
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          appBarTitle,
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 36.sp,
              decoration: BoxDecoration(color: Colors.black),
              child: Padding(
                padding: EdgeInsets.only(left: 16.sp, top: 23.sp),
                child: Text(
                  "Last Added",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.lastAdded.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    _showAnimeDetails(
                      context, index,
                      numberOfChapter: widget.lastAdded[index]["numberOfChapter"],
                      image: widget.lastAdded[index]['image'],
                      enimeTitle: widget.lastAdded[index]['enimeTitle'],
                      animeChapter:widget.lastAdded[index]["enimeChapter"],
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.sp),
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black38,
                    ),
                    width: double.infinity,
                    height: 50.sp,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          widget.lastAdded[index]["image"],
                          width: 40.sp,
                          height: 50.sp,
                        ),
                        SizedBox(width: 15.sp,),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.lastAdded[index]["enimeTitle"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white
                                ),),
                              Text("Anime Writer",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.grey
                                ),),
                              Text(widget.lastAdded[index]["numberOfChapter"],
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.white
                                ),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),




        ],
        ),
      ),
    );
  }


  void _showAnimeDetails(BuildContext context, int index,
      {required String enimeTitle,
        required String image,
        required String numberOfChapter,
        required List animeChapter
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AnimeDetailsBottomSheet(
        enimeTitle: enimeTitle,
        image: image,
        numberOfChapter: numberOfChapter,
        animeChapter: animeChapter,
      ),
    );
  }

  void _scrollListener() {
    if (_controller.offset > 35.sp) {
      setState(() {
        appBarTitle = "Last Added"; // Replace this with your desired scrolled title
      });
    } else {
      setState(() {
        appBarTitle = ""; // Replace this with your initial title
      });
    }
  }

  void navigateToAnimeStory(int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EnimeChapterScreen(
          enimeChapter: widget.lastAdded[index]["enimeChapter"],
          name: widget.lastAdded[index]["enimeTitle"],
          image: widget.lastAdded[index]["image"],
          noOfChapters: widget.lastAdded[index]["numberOfChapter"]);
    }));
  }
}