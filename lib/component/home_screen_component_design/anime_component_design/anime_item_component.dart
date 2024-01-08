
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class AnimeItem extends StatelessWidget {
  final String name;
  final String image;
  final String numberOfChapters;
  final VoidCallback onTap;

  AnimeItem({
    required this.name,
    required this.image,
    required this.numberOfChapters,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          top: 10.sp,
          bottom: 10.sp,
          right: 5.sp,
          left: 5.sp,
        ),
        child: Card(
          shadowColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          elevation: 10,
          child: Container(
            width: 50.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    image,
                    width: 50.sp,
                    height: 55.sp,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 6.sp, top: 5.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        numberOfChapters,
                        style: TextStyle(
                          color: Colors.grey[300],
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(height: 10.sp),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.star_border_outlined,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                            SizedBox(width: 5.sp),
                            Text(
                              "3.9",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
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

// class YourAnimeListWidget extends StatelessWidget {
//   final List<Map<String, dynamic>>? lastAdded;
//
//   YourAnimeListWidget({this.lastAdded});
//
//   Future<bool> checkInternetConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 68.sp,
//       child: FutureBuilder(
//         future: checkInternetConnection(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError || !(snapshot.data as bool)) {
//             return Center(child: Text('No internet connection'));
//           } else {
//             return ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: lastAdded?.length ?? 0,
//               itemBuilder: (context, index) {
//                 return EnimeItem(
//                   name: lastAdded![index]['enimeTitle'],
//                   image: lastAdded![index]['image'],
//                   numberOfChapters: lastAdded![index]['numberOfChapter'],
//                   onTap: () {
//                     _showAnimeDetails(
//                       context,
//                       index,
//                       numberOfChapter: lastAdded![index]["numberOfChapter"],
//                       image: lastAdded![index]['image'],
//                       enimeTitle: lastAdded![index]['enimeTitle'],
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   void _showAnimeDetails(
//       BuildContext context,
//       int index,
//       {required String numberOfChapter,
//         required String image,
//         required String enimeTitle}) {
//     // Implement your _showAnimeDetails logic here
//   }
// }
