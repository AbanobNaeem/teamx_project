import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:teamx_project/app_screen/enime_chapter_screen.dart';
import 'package:teamx_project/app_screen/profile_user_screen.dart';
import 'package:teamx_project/component/component_of_screen.dart';

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
  List recommended = [];
  List highestRating = [];

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    getUserDataFromFireStore();
    getProductsFromFireStore(list: lastAdded, collectionName: 'enimeItemData');
    getProductsFromFireStore(list: recommended, collectionName: 'recommended');
    getProductsFromFireStore(
        list: highestRating, collectionName: 'highestRating');
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset > 35) {
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
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      navigateToProfileUserScreen();
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: imageUrl == null
                              ? NetworkImage(nullImageUrl)
                              : NetworkImage(imageUrl!),
                          radius: 30,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${firstName} ${lastName}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                "${email}",
                                style: TextStyle(
                                    color: Colors.red[400], fontSize: 13),
                              )
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.navigate_next_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  drawerComponent(
                      tap: () {}, title: "Last Update", icons: Icons.update),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {}, title: "Manga", icons: Icons.menu),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Best Manga",
                      icons: Icons.bar_chart_outlined),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Best Continuous Manga",
                      icons: Icons.bar_chart_outlined),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Downloaded Manga",
                      icons: Icons.cloud_download_outlined),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Downloaded List",
                      icons: Icons.cloud_outlined),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Favourite ",
                      icons: Icons.favorite_border_outlined),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Watching Now ",
                      icons: Icons.pause_circle_outline),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Want To Watch ",
                      icons: Icons.pause_circle_outline),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Watched ",
                      icons: Icons.pause_circle_outline),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Last Viewed",
                      icons: Icons.pause_circle_outline),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Don't Want To Watch",
                      icons: Icons.not_interested_outlined),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {},
                      title: "Recommendation",
                      icons: Icons.recommend_outlined),
                  const SizedBox(
                    height: 15,
                  ),
                  drawerComponent(
                      tap: () {}, title: "Settings", icons: Icons.settings),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          title: Text(appBarTitle),
          actions: [
            IconButton(
              onPressed: () {
                _BottomSheetForSearch(context);

              },
              icon: const Icon(Icons.search),
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
                  height: 60,
                  decoration: BoxDecoration(color: Colors.grey[900]),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16, top: 15),
                    child: Text(
                      "TEAM X",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 170,
                  child: ImageSlideshow(
                    indicatorColor: Colors.red,
                    onPageChanged: (value) {
                      debugPrint('Page changed: $value');
                    },
                    autoPlayInterval: 3000,
                    isLoop: true,
                    children: [
                      Image.asset(
                        'images/paner.jpg',
                        width: 400,
                        height: 200,
                      ),
                      Image.asset(
                        'images/paner3.jpg',
                        width: 400,
                        height: 200,
                      ),
                      Image.asset(
                        'images/paner2.jpg',
                        width: 400,
                        height: 200,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          "Last added",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('show all');
                        },
                        child: Row(
                          children: const [
                            Text(
                              "Show all",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.red,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lastAdded.length,
                      itemBuilder: (context, index) {
                        return animeItem(context,
                            name: lastAdded[index]['enimeTitle'],
                            image: lastAdded[index]['image'],
                            numberOfChapters: lastAdded[index]
                                ['numberOfChapter'], onTap: () {
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
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          "Recommended",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('show all');
                        },
                        child: Row(
                          children: const [
                            Text(
                              "Show all",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.red,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return suggestionsItem();
                      }),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Expanded(
                        child: Text(
                          "highest rating",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('show all');
                        },
                        child: Row(
                          children: const [
                            Text(
                              "Show all",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Icon(
                              Icons.navigate_next,
                              color: Colors.red,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 260,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lastAdded.length,
                      itemBuilder: (context, index) {
                        return animeItem(context,
                            name: lastAdded[index]['enimeTitle'],
                            numberOfChapters: lastAdded[index]
                                ['numberOfChapter'],
                            image: lastAdded[index]['image'],
                            onTap: () {});
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  void navigateToProfileUserScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const ProfileScreen();
    }));
  }

  void getUserDataFromFireStore() async {
    String userId = firebaseAuth.currentUser!.uid;
    await firestore
        .collection("userData")
        .doc(userId)
        .snapshots()
        .listen((value) {
      updateUi(value.data());
    });
  }

  getProductsFromFireStore(
      {required String collectionName, required List list}) async {
    await firestore.collection(collectionName).snapshots().listen((event) {
      for (var doc in event.docs) {
        final product = doc.data();
        list.add(product);
      }
    });
  }

  void updateUi(Map<String, dynamic>? data) {
    setState(() {
      if (data!.containsKey("imageUrl")) {
        imageUrl = data["imageUrl"];
      }
      if (data.containsKey("firstName")) {
        firstName = data["firstName"];
      }
      if (data.containsKey("lastName")) {
        lastName = data["lastName"];
      }
      if (data.containsKey("email")) {
        email = data["email"];
      }
    });
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
          enimeChapter: lastAdded[index]["enimeChapter"],
          name: lastAdded[index]["enimeTitle"],
          image: lastAdded[index]["image"],
          noOfChapters: lastAdded[index]["numberOfChapter"]);
    }));
  }

  void _BottomSheetForSearch(BuildContext context,) {
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
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[800]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[700]
                    ),
                    child: Row(
                      children:  [
                        Expanded(
                          child: TextFormField(

                          ),
                        )
                        
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
          ),
    );
  }
}
