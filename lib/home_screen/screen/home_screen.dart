import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/app_screen/enime_chapter_screen.dart';
import 'package:teamx_project/component/home_screen_component_design/category_of_anime_Button/category_component_in_home_screen.dart';
import 'package:teamx_project/show_all_screen/show_all_screen.dart';
import 'package:teamx_project/component/home_screen_component_design/drawer/drawer.dart';
import 'package:teamx_project/component/home_screen_component_design/anime_component_design/anime_list_component.dart';
import 'package:teamx_project/component/home_screen_component_design/search_bottom_sheet_design/search_bottom_sheet.dart';
import 'package:teamx_project/component/home_screen_component_design/anime_component_design/show_anime_details.dart';
import 'package:teamx_project/home_screen/cubit/home_screen_cubit.dart';
import 'package:teamx_project/users_screens/user_profile/screen/user_profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _controller;
  DocumentSnapshot? snapshot;
  String appBarTitle = ""; // Replace this with your initial title
  String? imageUrl;
  String? firstName;
  String? lastName;
  String? email;
  List lastAdded  = [];
  bool connectivity = true;
  final searchController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final cubit = HomeScreenCubit();


  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    cubit.getUserDataFromFireStore();
    cubit.getProductsFromFireStore(list: lastAdded, collectionName: 'enimeItemData');
    _checkConnectivity();
    Connectivity().onConnectivityChanged.listen((result) {
      _handleConnectivity(result);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: cubit..getUserDataFromFireStore(),
        child: connectivity == true ? Scaffold(
                backgroundColor: Colors.grey[900],
                drawer: buildDrawer(
                    userData: cubit.data,
                    onTap: (){navigateToUserProfile();},
                    lastUpdate: () {},
                    manga: () {},
                    bestManga: () {},
                    bestContinuousManga: () {},
                    downloadedManga: () {},
                    downloadedList: () {},
                    favourite: () {},
                    watchingNow: () {},
                    wantToWatch: () {},
                    watched: () {},
                    lastViewed: () {},
                    doNotWantToWatch: () {},
                    recommendation: () {},
                    settings: () {}),
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  centerTitle: true,
                  title: Text(
                    appBarTitle,
                    style: TextStyle(fontSize: 20.sp),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        _BottomSheetForSearch(context);
                      },
                      icon: Icon(
                        Icons.search,
                        size: 22.sp,
                      ),
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
                                  Image.asset(
                                    "assets/images/background.png",
                                    width: double.infinity,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  Image.asset(
                                    "assets/images/2.png",
                                    fit: BoxFit.fitWidth,
                                  ),
                                ],
                              ),
                              Image.asset(
                                "assets/images/1.png",
                                fit: BoxFit.fitWidth,
                              ),
                              Image.asset(
                                "assets/images/3.png",
                                fit: BoxFit.fitWidth,
                              ),
                              Image.asset(
                                "assets/images/4.webp",
                                fit: BoxFit.fitWidth,
                              ),
                              Image.asset(
                                "assets/images/5.png",
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ),
                        CategoryOfAnime(
                            title: "Last Added",
                            onTap: () {
                              navigatorToAllAnime();
                            }),
                        AnimeList(
                          animeList: lastAdded , // Provide an empty list if lastAdded is null
                          onItemTap: (index) {

                              _showAnimeDetails(
                                context,
                                index,
                                numberOfChapter: lastAdded[index]['numberOfChapter'],
                                image: lastAdded[index]['image'],
                                enimeTitle: lastAdded[index]['enimeTitle'],
                                animeChapter: lastAdded[index]["enimeChapter"],
                              );

                          },
                        ),

                        CategoryOfAnime(
                            title: "Recommended",
                            onTap: () {
                              navigatorToAllAnime();
                            }),
                      AnimeSuggestionsList(
                          suggestionsList: lastAdded,
                          onItemTap: (index){
                            _showAnimeDetails(
                              context,
                              index,
                              numberOfChapter: lastAdded[index]['numberOfChapter'],
                              image: lastAdded[index]['image'],
                              enimeTitle: lastAdded[index]['enimeTitle'],
                              animeChapter: lastAdded[index]["enimeChapter"],
                            );
                          }),
                        CategoryOfAnime(
                            title: "highest rating",
                            onTap: () {
                              navigatorToAllAnime();
                            }),
                        AnimeList(
                            animeList: lastAdded,
                            onItemTap: (index){
                              _showAnimeDetails(
                                context,
                                index,
                                numberOfChapter: lastAdded[index]['numberOfChapter'],
                                image: lastAdded[index]['image'],
                                enimeTitle: lastAdded[index]['enimeTitle'],
                                animeChapter: lastAdded[index]["enimeChapter"],
                              );
                            }),
                      ],
                    ),
                  ),
                )
        )
            : Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    size: 50,
                    color: Colors.red.shade800,
                  ),
                )));
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

  void navigateToAnimeStory(int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EnimeChapterScreen(
          enimeChapter: lastAdded[index]["enimeChapter"],
          name: lastAdded[index]["enimeTitle"],
          image: lastAdded[index]["image"],
          noOfChapters: lastAdded[index]["numberOfChapter"]);
    }));
  }

  void navigatorToAllAnime() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ShowAllScreen(
        lastAdded: lastAdded,
      );
    }));
  }

  void _BottomSheetForSearch(BuildContext context) {
    List lastAdded = [];
    lastAdded.addAll(this.lastAdded);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchBottomSheet(lastAdded: lastAdded),
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

  Future<void> _checkConnectivity() async {
    ConnectivityResult connectivityResult =
    await Connectivity().checkConnectivity();
    // Handle connectivity status
    _handleConnectivity(connectivityResult);
  }
  void _handleConnectivity(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      setState(() {
        connectivity = false;
      });
    } else {
      setState(() {
        connectivity = true;
      });
    }
  }

  void navigateToUserProfile() {
    Navigator.push(context,MaterialPageRoute(builder: (context){
      return  const UserProfileScreenNew() ;
    }));
  }
}

