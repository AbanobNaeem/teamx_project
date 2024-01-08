import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/app_screen/enime_chapter_screen.dart';




class AnimeDetailsBottomSheet extends StatefulWidget {
  final String enimeTitle;
  final String image;
  final String numberOfChapter;
  final List animeChapter ;

  const AnimeDetailsBottomSheet({
    super.key,
    required this.enimeTitle,
    required this.image,
    required this.numberOfChapter,
    required this.animeChapter
  });

  @override
  State<AnimeDetailsBottomSheet> createState() => _AnimeDetailsBottomSheetState();
}

class _AnimeDetailsBottomSheetState extends State<AnimeDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.5.h,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 10.sp, left: 10.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 30.sp,
              height: 4.sp,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.sp, left: 5.sp, right: 10.sp),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Anime Details",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                    SizedBox(height: 5.sp,),
                    const Divider(color: Colors.red,),
                    SizedBox(height: 10.sp,),
                    Row(
                      children: [
                        Image.network(
                          widget.image,
                          height: 57.sp,
                          width: 50.sp,
                          alignment: Alignment.center,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.enimeTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                Text(
                                  "Name of writer",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                SizedBox(height: 40.sp,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        widget.numberOfChapter,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.sp,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 25.sp,
                                      width: 35.sp,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          navigateToAnimeChapter() ;
                                          // Implement the Read button logic
                                        },
                                        child: Text(
                                          "Read",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.sp,)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 5.sp),
                    const Divider(color: Colors.red),
                    SizedBox(height: 5.sp),
                    Container(
                      height: 30.sp,
                      child: Card(
                        elevation: 10,
                        color: Colors.grey[900],
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.chat_outlined,
                                  size: 20.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit_outlined,
                                  size: 20.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.star_border_outlined,
                                  size: 20.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.download_for_offline_outlined,
                                  size: 20.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_horiz_outlined,
                                  size: 20.sp,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    Text(
                      "Last update",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      "15 Hours from  yu Nuni",
                      style: TextStyle(color: Colors.grey, fontSize: 17.sp),
                    ),
                    SizedBox(height: 20.sp),
                    Text(
                      "Type",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      "Action",
                      style: TextStyle(color: Colors.grey, fontSize: 17.sp),
                    ),
                    SizedBox(height: 20.sp),
                    Text(
                      "Story",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      "story description",
                      style: TextStyle(color: Colors.grey, fontSize: 17.sp),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateToAnimeChapter() {
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return EnimeChapterScreen(
          name: widget.enimeTitle,
          image: widget.image,
          noOfChapters: widget.numberOfChapter,
          enimeChapter: widget.animeChapter);
    }));
  }
}

