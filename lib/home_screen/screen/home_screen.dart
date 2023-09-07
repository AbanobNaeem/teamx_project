import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/app_screen/enime_chapter_screen.dart';

import 'package:teamx_project/app_screen/show_all_screen.dart';
import 'package:teamx_project/component/component_of_screen.dart';
import 'package:teamx_project/home_screen/cubit/home_screen_cubit.dart';
import 'package:teamx_project/users_screens/user_profile/screen/profile_user_screen.dart';

DocumentSnapshot? snapshot;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _controller;
  String appBarTitle = ""; // Replace this with your initial title
  String? imageUrl;
  String? firstName;
  String? lastName;
  String? email;
  String nullImageUrl =
      "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png";
  List lastAdded = [];
  final searchController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    cubit.getUserDataFromFireStore();
    cubit.getProductsFromFireStore(list: lastAdded, collectionName: 'enimeItemData');
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset > 35.sp) {
      setState(() {
        appBarTitle = "TEAM X"; // Replace this with your desired scrolled title
      });
    } else {
      setState(() {
        appBarTitle = ""; // Replace this with your initial title
      });
    }
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final cubit = HomeScreenCubit();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit..getUserDataFromFireStore,
      child: BlocBuilder<HomeScreenCubit, HomeScreenStates>(
        builder: (context, state) {
          return BlocListener<HomeScreenCubit, HomeScreenStates>(
            listener: (context, state) {

            },
            child: Scaffold(
                backgroundColor: Colors.grey[900],
                drawer: Drawer(
                  backgroundColor: Colors.black,
                  width: 70.sp,
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10.sp, left: 10.sp, right: 10.sp),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                navigateToProfileUserScreen();
                              },
                              child: BlocBuilder<HomeScreenCubit, HomeScreenStates>(
                              builder: (context, state) {
                              return Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: cubit.data["imageUrl"] == null
                                        ? NetworkImage(nullImageUrl)
                                        : NetworkImage("${cubit.data["imageUrl"]}"),
                                    radius: 22.sp,
                                  ),
                                  SizedBox(
                                    width: 13.sp,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          "${cubit.data["firstName"]} ${cubit.data["lastName"]}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19.sp),
                                        ),
                                        Text(
                                          "${cubit.data["email"]}",
                                          style: TextStyle(
                                              color: Colors.red[400],
                                              fontSize: 15.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.navigate_next_outlined,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ],
                              );
  },
),
                            ),
                            SizedBox(height: 15.sp,),
                            drawerComponent(
                                tap: () {},
                                title: "Last Update",
                                icons: Icons.update),
                            SizedBox(height: 15.sp,),
                            drawerComponent(
                                tap: () {}, title: "Manga", icons: Icons.menu),
                            SizedBox(height: 15.sp,),
                            const Divider(color: Colors.red,),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Best Manga",
                                icons: Icons.bar_chart_outlined),
                            SizedBox(height: 15.sp,),
                            drawerComponent(
                                tap: () {},
                                title: "Best Continuous Manga",
                                icons: Icons.bar_chart_outlined),
                            SizedBox(height: 15.sp),
                            const Divider(
                              color: Colors.red,
                            ),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Downloaded Manga",
                                icons: Icons.cloud_download_outlined),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Downloaded List",
                                icons: Icons.cloud_outlined),
                            SizedBox(height: 15.sp),
                            const Divider(
                              color: Colors.red,
                            ),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Favourite ",
                                icons: Icons.favorite_border_outlined),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Watching Now ",
                                icons: Icons.pause_circle_outline),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Want To Watch ",
                                icons: Icons.pause_circle_outline),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Watched ",
                                icons: Icons.pause_circle_outline),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Last Viewed",
                                icons: Icons.pause_circle_outline),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Don't Want To Watch",
                                icons: Icons.not_interested_outlined),
                            SizedBox(height: 15.sp),
                            const Divider(
                              color: Colors.red,
                            ),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Recommendation",
                                icons: Icons.recommend_outlined),
                            SizedBox(height: 15.sp),
                            drawerComponent(
                                tap: () {},
                                title: "Settings",
                                icons: Icons.settings),
                            SizedBox(height: 15.sp),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  centerTitle: true,
                  title: Text(appBarTitle,
                    style: TextStyle(
                        fontSize: 20.sp
                    ),),
                  actions: [
                    IconButton(
                      onPressed: () {
                        _BottomSheetForSearch(context);
                      },
                      icon: Icon(Icons.search, size: 22.sp,),
                    ),

                  ],
                ),
                body: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollUpdateNotification) {
                      _scrollListener();
                    }
                    return true;
                  },
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 36.sp,
                          decoration: BoxDecoration(color: Colors.black),
                          child: Padding(
                            padding: EdgeInsets.only(left: 16.sp, top: 25.sp),
                            child: Text(
                              "TEAM X",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          height: 51.sp,
                          child: ImageSlideshow(
                            indicatorColor: Colors.red,
                            onPageChanged: (value) {
                              debugPrint('Page changed: $value');
                            },
                            autoPlayInterval: 3000,
                            isLoop: true,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset("assets/images/background.png",
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,),
                                  Image.asset("assets/images/2.png",
                                    fit: BoxFit.fitWidth,),

                                ],
                              ),

                              Image.asset("assets/images/1.png",
                                fit: BoxFit.fitWidth,),
                              Image.asset("assets/images/3.png",
                                fit: BoxFit.fitWidth,),
                              Image.asset("assets/images/4.webp",
                                fit: BoxFit.fitWidth,),
                              Image.asset("assets/images/5.png",
                                fit: BoxFit.fitWidth,),

                            ],
                          ),
                        ),
                        Container(
                          height: 30.sp,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10.sp,),
                              Expanded(
                                child: Text(
                                  "Last added",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.sp),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigatorToAllAnime();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Show all",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 17.sp),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.red,
                                      size: 22.sp,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 68.sp,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lastAdded.length,
                              itemBuilder: (context, index) {
                                return animeItem(context,
                                    name: lastAdded[index]['enimeTitle'],
                                    image: lastAdded[index]['image'],
                                    numberOfChapters: lastAdded[index]['numberOfChapter'],
                                    onTap: () {
                                      _showAnimeDetails(
                                        context,
                                        index,
                                        numberOfChapter: lastAdded[index]
                                        ["numberOfChapter"],
                                        image: lastAdded[index]['image'],
                                        enimeTitle: lastAdded[index]['enimeTitle'],
                                      );
                                    });
                              }),
                        ),
                        Container(
                          height: 30.sp,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10.sp,),
                              Expanded(
                                child: Text(
                                  "Recommended",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.sp),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigatorToAllAnime();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Show all",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 17.sp),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.red,
                                      size: 22.sp,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 60.sp,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lastAdded.length,
                              itemBuilder: (context, index) {
                                return suggestionsItem(
                                    context,
                                    name: lastAdded[index]['enimeTitle'],
                                    image: lastAdded[index]['image'],
                                    numberOfChapters: lastAdded[index]['numberOfChapter'],
                                    onTap: () {
                                      _showAnimeDetails(
                                        context,
                                        index,
                                        numberOfChapter: lastAdded[index]
                                        ["numberOfChapter"],
                                        image: lastAdded[index]['image'],
                                        enimeTitle: lastAdded[index]['enimeTitle'],
                                      );
                                    }
                                );
                              }),
                        ),
                        Container(
                          height: 30.sp,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10.sp,),
                              Expanded(
                                child: Text(
                                  "highest rating  ",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.sp),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  navigatorToAllAnime();
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Show all",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 17.sp),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.red,
                                      size: 22.sp,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 68.sp,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lastAdded.length,
                              itemBuilder: (context, index) {
                                return animeItem(context,
                                    name: lastAdded[index]['enimeTitle'],
                                    numberOfChapters: lastAdded[index]
                                    ['numberOfChapter'],
                                    image: lastAdded[index]['image'],
                                    onTap: () {
                                      _showAnimeDetails(
                                        context,
                                        index,
                                        numberOfChapter: lastAdded[index]
                                        ["numberOfChapter"],
                                        image: lastAdded[index]['image'],
                                        enimeTitle: lastAdded[index]['enimeTitle'],
                                      );
                                    });
                              }),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  void navigateToProfileUserScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ProfileScreen();
    }));
  }

  void _showAnimeDetails(BuildContext context, index,
      {required String enimeTitle,
        required String image,
        required String numberOfChapter}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          Container(
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
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20.sp, left: 5.sp, right: 10.sp),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Anime Details",
                              style: TextStyle(color: Colors.white,
                                  fontSize: 20.sp),
                            ),
                            SizedBox(height: 5.sp,),
                            const Divider(
                              color: Colors.red,
                            ),
                            SizedBox(height: 10.sp,),
                            Row(
                              children: [
                                Image.network(
                                  image,
                                  height: 57.sp,
                                  width: 50.sp,
                                  alignment: Alignment.center,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.0.sp),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          enimeTitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp),
                                        ),
                                        Text(
                                          "Name of writer",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17.sp),
                                        ),
                                        SizedBox(height: 40.sp,),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                numberOfChapter,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17.sp),
                                              ),
                                            ),
                                            Container(
                                              height: 25.sp,
                                              width: 35.sp,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: TextButton(
                                                  onPressed: () {
                                                    navigateToAnimeStory(index);
                                                  },
                                                  child: Text(
                                                    "Read",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17.sp),
                                                  )),
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
                            const Divider(
                              color: Colors.red,
                            ),
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
                                          )),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit_outlined,
                                            size: 20.sp,
                                            color: Colors.red,
                                          )),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.star_border_outlined,
                                            size: 20.sp,
                                            color: Colors.red,
                                          )),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.download_for_offline_outlined,
                                            size: 20.sp,
                                            color: Colors.red,
                                          )),
                                    ),
                                    Expanded(
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.more_horiz_outlined,
                                            size: 20.sp,
                                            color: Colors.red,
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.sp),
                            Text(
                              "Last update",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            SizedBox(height: 10.sp),
                            Text(
                              "15 Hours from  yu Nuni",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 17.sp),
                            ),
                            SizedBox(
                                height: 20.sp
                            ),
                            Text(
                              "Type",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            SizedBox(
                                height: 10.sp
                            ),
                            Text(
                              "Action",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 17.sp),
                            ),
                            SizedBox(
                                height: 20.sp
                            ),
                            Text(
                              "Story",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            SizedBox(
                                height: 10.sp
                            ),
                            Text(
                              "story description",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 17.sp),
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
          enimeChapter: lastAdded[index]["enimeChapter"],
          name: lastAdded[index]["enimeTitle"],
          image: lastAdded[index]["image"],
          noOfChapters: lastAdded[index]["numberOfChapter"]);
    }));
  }

  void _BottomSheetForSearch(BuildContext context) {
    List<dynamic> lastAdded = [];
    lastAdded.addAll(this.lastAdded);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState
                  /*You can rename this!*/) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.grey[800],
                        height: 35.sp,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Container(
                                  margin: EdgeInsets.all(8.sp),
                                  height: 27.sp,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[700]),
                                  child: Center(
                                    child: TextFormField(
                                      controller: searchController,
                                      keyboardType: TextInputType.text,
                                      onChanged: (value) {
                                        lastAdded.clear();
                                        lastAdded.addAll(this.lastAdded);

                                        lastAdded = lastAdded
                                            .where((e) =>
                                            e['enimeTitle']
                                                .toString()
                                                .contains(value))
                                            .toList();

                                        setState(() {});
                                      },
                                      style: const TextStyle(
                                          color: Colors.white),
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
                                            color: Colors.white,
                                            fontSize: 18.sp),
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
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 18.sp),
                                ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: lastAdded.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.4.sp / 0.6.sp,
                          ),
                          itemBuilder: (context, index) =>
                              Container(
                                padding: EdgeInsets.only(
                                    top: 10.sp,
                                    bottom: 10.sp,
                                    right: 2.sp,
                                    left: 2.sp),
                                child: InkWell(
                                  onTap: () {
                                    _showAnimeDetails(
                                      context,
                                      index,
                                      numberOfChapter: lastAdded[index]["numberOfChapter"],
                                      image: lastAdded[index]['image'],
                                      enimeTitle: lastAdded[index]['enimeTitle'],
                                    );
                                  },
                                  child: Card(
                                    shadowColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            10)),
                                    color: Colors.black,
                                    elevation: 10,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),
                                          child: Image.network(
                                            lastAdded[index]['image'],
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                            height: 57.sp,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10.sp, top: 6.sp),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                lastAdded[index]["enimeTitle"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.sp),
                                              ),
                                              Text(
                                                lastAdded[index]["numberOfChapter"],
                                                style: TextStyle(
                                                    color: Colors.grey[300],
                                                    fontSize: 17.sp),
                                              ),
                                              SizedBox(height: 10.sp,),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .star_border_outlined,
                                                      size: 20.sp,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(width: 5.sp),
                                                    Text(
                                                      "3.9",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15.sp),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        ),
                      )
                    ],
                  ),
                );
              }
          ),

    );
  }

  void navigatorToAllAnime() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ShowAllScreen(
        lastAdded: lastAdded,
      );
    }));
  }

}