import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/home_screen_component_design/anime_component_design/anime_item_component.dart';
import '../anime_component_design/show_anime_details.dart';

class SearchBottomSheet extends StatefulWidget {
  final List<dynamic> lastAdded;
  SearchBottomSheet({required this.lastAdded});

  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  TextEditingController searchController = TextEditingController();

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
      child: Column(
        children: [
          Container(
            color: Colors.grey[850],
            height: 34.sp,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Container(
                      margin: EdgeInsets.all(8.sp),
                      height: 27.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[800]),
                      child: Center(
                        child: TextFormField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          onChanged: (value) {
                            List<dynamic> filteredList = widget.lastAdded
                                .where((anime) =>
                                anime['enimeTitle'].toString().contains(value)).toList();
                            setState(() {
                              if(value.isEmpty){
                                widget.lastAdded.length;
                              }
                              widget.lastAdded.clear();
                              widget.lastAdded.addAll(filteredList);
                            });
                          },
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.red,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              size: 20.sp,
                              color: Colors.white,
                            ),
                            hintText: "Search",
                            hintStyle: TextStyle(
                                color: Colors.white, fontSize: 18.sp),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "close",
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ))
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: widget.lastAdded.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.4.sp / 0.6.sp,
              ),
               itemBuilder: (context, index) =>
              AnimeItem(
                  name: widget.lastAdded[index]["enimeTitle"],
                  image: widget.lastAdded[index]['image'],
                  numberOfChapters:widget.lastAdded[index]['numberOfChapter'] ,
                  onTap: (){
                    Navigator.pop(context);
                    _showAnimeDetails(context, index,
                              enimeTitle: widget.lastAdded[index]["enimeTitle"],
                              image: widget.lastAdded[index]['image'],
                              numberOfChapter: widget.lastAdded[index]['numberOfChapter'],
                              animeChapter: widget.lastAdded[index]["enimeChapter"]
                          );
                  })
            ),
          )
        ],
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
}