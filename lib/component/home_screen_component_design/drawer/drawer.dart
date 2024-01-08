import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:teamx_project/component/home_screen_component_design/drawer/drawer_buttons.dart';
String nullImageUrl = "https://e7.pngegg.com/pngimages/178/595/png-clipart-user-profile-computer-icons-login-user-avatars-monochrome-black-thumbnail.png";

Widget buildDrawer({
  required Map<String, dynamic> userData,
  required Function() onTap,
  required Function() lastUpdate,
  required Function() manga,
  required Function() bestManga,
  required Function() bestContinuousManga,
  required Function() downloadedManga,
  required Function() downloadedList,
  required Function() favourite,
  required Function() watchingNow ,
  required Function() wantToWatch ,
  required Function() watched ,
  required Function() lastViewed ,
  required Function() doNotWantToWatch ,
  required Function() recommendation ,
  required Function() settings ,



}) {
  return Drawer(
    backgroundColor: Colors.black,
    width: 70.sp,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 10.sp, left: 10.sp, right: 10.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:userData["imageUrl"] == null
                          ? NetworkImage(nullImageUrl)
                          : NetworkImage("${userData["imageUrl"]}"),
                      radius: 21.sp,
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
                            "${userData["firstName"]}${userData["lastName"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 19.sp),
                          ),
                          Text(
                            "${userData["email"]}",
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
                ),
              ),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: lastUpdate,
                  title: "Last Update",
                  icon: Icons.update),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: manga,
                  title: "Manga",
                  icon: Icons.menu),
              // ... Add more drawer components with callbacks
              SizedBox(height: 15.sp),
              const  Divider(color: Colors.red),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: bestManga,
                  title: "Best Manga",
                  icon: Icons.bar_chart),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: bestContinuousManga,
                  title: "Best Continuous Manga",
                  icon: Icons.bar_chart),
              SizedBox(height: 15.sp),
              const Divider(color: Colors.red),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap:downloadedManga,
                  title: "Downloaded Manga",
                  icon: Icons.save_alt),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: downloadedList,
                  title: "Downloaded List",
                  icon: Icons.save_alt),
              SizedBox(height: 15.sp),
              const Divider(color: Colors.red),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: favourite,
                  title: "Favourite",
                  icon: Icons.favorite),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: watchingNow,
                  title: "Watching Now",
                  icon:  Icons.pause_circle_outline),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: wantToWatch,
                  title: "Want To Watch",
                  icon: Icons.pause_circle_outline),
              SizedBox(height: 15.sp),
              const  Divider(color: Colors.red),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: watched,
                  title: "Watched",
                  icon:Icons.done ),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: lastViewed,
                  title: "Last Viewed",
                  icon: Icons.last_page),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: doNotWantToWatch,
                  title: "Don't Want To Watch",
                  icon: Icons.visibility_off),
              SizedBox(height: 15.sp),
              const Divider(color: Colors.red),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap: recommendation,
                  title: "Recommendation",
                  icon: Icons.recommend_outlined),
              SizedBox(height: 15.sp),
              DrawerButtons(
                  onTap:settings  ,
                  title: "Settings",
                  icon: Icons.settings),
              // ... Remaining drawer content
            ],
          ),
        ),
      ),
    ),
  );
}










