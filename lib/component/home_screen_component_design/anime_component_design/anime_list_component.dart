import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:teamx_project/component/home_screen_component_design/anime_component_design/anime_item_component.dart';
import 'package:teamx_project/component/home_screen_component_design/anime_component_design/anime_suggestion_item.dart';

class AnimeList extends StatelessWidget {
  final List animeList;
  final  Function(int) onItemTap;
  final scrollDirection ;


  const AnimeList({
    required this.animeList,
    required this.onItemTap,
    this.scrollDirection = Axis.horizontal,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.sp,
      child: ListView.builder(
        scrollDirection: scrollDirection,
        itemCount: animeList.length,
        itemBuilder: (context, index) {
          return AnimeItem(
            name: animeList[index]['enimeTitle'],
            image: animeList[index]['image'],
            numberOfChapters: animeList[index]['numberOfChapter'],
            onTap: () {
              onItemTap(index);
            },
          );
        },
      ),
    );
  }
}


class AnimeSuggestionsList extends StatelessWidget {
  final List suggestionsList;
  final void Function(int) onItemTap;

  const AnimeSuggestionsList({
    required this.suggestionsList,
    required this.onItemTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.sp,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: suggestionsList.length,
        itemBuilder: (context, index) {
          return AnimeSuggestionItem(
            name: suggestionsList[index]['enimeTitle'],
            image: suggestionsList[index]['image'],
            numberOfChapters: suggestionsList[index]['numberOfChapter'],
            onTap: () {
              onItemTap(index);
            },
          );
        },
      ),
    );
  }
}

