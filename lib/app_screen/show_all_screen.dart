import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/app_screen/enime_chapter_screen.dart';

class ShowAllScreen extends StatefulWidget {
   ShowAllScreen({super.key,
    required this.lastAdded});
    List lastAdded;

  @override
  State<ShowAllScreen> createState() => _ShowAllScreenState();
}

class _ShowAllScreenState extends State<ShowAllScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 48.sp,
            padding: EdgeInsets.only(top:24.sp,left: 12.sp),
            color: Colors.black38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: ()=> Navigator.pop(context),
                  child: Container(
                    width: 40.sp,
                    child: Row(
                      children:  [
                        Icon(Icons.arrow_back_ios_outlined,
                          size: 20.sp,
                          color: Colors.white,),
                        Text("Back",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp
                            ),)
                      ],
                    ),
                  ),
                ),

                  SizedBox(height: 15.sp,),
                  Text("All Anime",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp
                  ),),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              child: ListView.builder(
                  itemCount: widget.lastAdded.length,
                  itemBuilder:(context ,index){
                    return InkWell(
                      onTap: (){
                        _showAnimeDetails(
                          context,
                          index,
                          numberOfChapter: widget.lastAdded[index]
                          ["numberOfChapter"],
                          image: widget.lastAdded[index]['image'],
                          enimeTitle: widget.lastAdded[index]['enimeTitle'],
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.sp),
                        padding: EdgeInsets.all(10.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black38,
                        ),
                        width: double.infinity,
                        height: 60.sp,
                        child:Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                            widget.lastAdded[index]["image"],
                            width: 50.sp,
                            height: 80.sp,),
                            SizedBox(width: 10.sp,),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:  [
                                  Text(widget.lastAdded[index]["enimeTitle"],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                    fontSize: 22.sp,
                                    color: Colors.white
                                  ),),
                                   Text("Anime Writer",
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.grey
                                    ),),
                                  Text(widget.lastAdded[index]["numberOfChapter"],
                                    style:  TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white
                                    ),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          )


        ],
      ),
    );
  }
  void _showAnimeDetails(BuildContext context, index,
      {required String enimeTitle,
        required String image,
        required String numberOfChapter}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.95,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 3,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 5, right: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Anime Details",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          color: Colors.red,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.network(
                              image,
                              height: 200,
                              width: 150,
                              alignment: Alignment.center,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      enimeTitle,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      "Name of writer",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 135,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            numberOfChapter,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: TextButton(
                                              onPressed: () {
                                                navigateToAnimeStory(index);
                                              },
                                              child: const Text(
                                                "Read",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          color: Colors.red,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Card(
                          elevation: 10,
                          color: Colors.grey[900],
                          child: Row(
                            children: [
                              Expanded(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.chat_outlined,
                                      color: Colors.red,
                                    )),
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Colors.red,
                                    )),
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.star_border_outlined,
                                      color: Colors.red,
                                    )),
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.download_for_offline_outlined,
                                      color: Colors.red,
                                    )),
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.more_horiz_outlined,
                                      color: Colors.red,
                                    )),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Last update",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "15 Hours from  yu Nuni",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Type",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Action",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Story",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "story description",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
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
