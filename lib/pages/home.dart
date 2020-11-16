import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/assets.dart';
import '../common/route_page.dart';
import '../common/sabt.dart';
import '../common/size_config.dart';
import '../models/genre_list_dto.dart';

class Home extends StatelessWidget {
  final List<GenreList> bookGenreList = [
    new GenreList(
      genreIcon: Assets.FICTION,
      genreTitle: 'Fiction',
    ),
    new GenreList(
      genreIcon: Assets.DRAMA,
      genreTitle: 'Drama',
    ),
    new GenreList(
      genreIcon: Assets.HUMOUR,
      genreTitle: 'Humor',
    ),
    new GenreList(
      genreIcon: Assets.POLITICS,
      genreTitle: 'Politics',
    ),
    new GenreList(
      genreIcon: Assets.PHILOSOPHY,
      genreTitle: 'Philosophy',
    ),
    new GenreList(
      genreIcon: Assets.HISTORY,
      genreTitle: 'History',
    ),
    new GenreList(
      genreIcon: Assets.ADVENTURE,
      genreTitle: 'Adventure',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.accentColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: kToolbarHeight * 2,
            elevation: 0,
            expandedHeight: SizeConfig.isStandardScreen
                ? SizeConfig.screenHeight / 3
                : SizeConfig.screenHeight / 2.6,
            floating: false,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: [
                StretchMode.zoomBackground,
              ],
              background: SvgPicture.asset(
                Assets.PATTERN,
                fit: BoxFit.cover,
                height: SizeConfig.isStandardScreen
                    ? SizeConfig.screenHeight / 3
                    : SizeConfig.screenHeight / 2.6,
                alignment: Alignment.center,
              ),
              collapseMode: CollapseMode.parallax,
              title: SABT(
                child: Text(
                  'A social cataloging website that allows you to freely search its database of books, annotations, and reviews.',
                  style: themeData.textTheme.bodyText2.copyWith(
                    color: Color(0xFF333333),
                    fontWeight: FontWeight.w700,
                    // fontSize: SizeConfig.isStandardScreen
                    //     ? 14 * SizeConfig.safeAreaTextScalingFactor
                    //     : 14 * SizeConfig.safeAreaTextScalingFactor,
                  ),
                ),
              ),
              titlePadding: EdgeInsets.only(
                left: SizeConfig.isStandardScreen ? 15 : 15,
                right: SizeConfig.isStandardScreen ? 15 : 15,
                top: 0,
                bottom: SizeConfig.isStandardScreen ? 15 : 5,
              ),
            ),
            title: Wrap(
              children: [
                Text(
                  'Gutenberg',
                  style: themeData.textTheme.headline3.copyWith(
                    color: themeData.primaryColor,
                    fontFamily: "Montserrat_SemiBold",
                  ),
                ),
                Text(
                  'Project',
                  style: themeData.textTheme.headline3.copyWith(
                    color: themeData.primaryColor,
                    fontFamily: "Montserrat_SemiBold",
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                var genre = bookGenreList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      RoutePage.BUILD_BOOK_LIST,
                      arguments: genre,
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeConfig.isStandardScreen ? 10 : 7,
                        horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              genre.genreIcon,
                              height: 30 * SizeConfig.safeAreaTextScalingFactor,
                              fit: BoxFit.contain,
                              width: 30 * SizeConfig.safeAreaTextScalingFactor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            genre.genreTitle.toUpperCase(),
                            style: themeData.textTheme.headline6.copyWith(
                              color: Color(0xFF333333),
                              fontWeight: FontWeight.w900,
                              fontSize:
                                  20 * SizeConfig.safeAreaTextScalingFactor,
                              letterSpacing: 1.1,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              Assets.NEXT,
                              height: 18 * SizeConfig.safeAreaTextScalingFactor,
                              fit: BoxFit.contain,
                              width: 18 * SizeConfig.safeAreaTextScalingFactor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: bookGenreList.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: kToolbarHeight * 2.2,
            ),
          ),
        ],
      ),
    );
  }
}
