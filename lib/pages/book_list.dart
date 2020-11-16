import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../common/size_config.dart';
import '../providers/booklist_provider.dart';

class BookList extends StatefulWidget {
  const BookList({Key key}) : super(key: key);
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  BooklistProvider _booklistProvider;
  ScrollController _scrollController = new ScrollController();

  @override
  void didChangeDependencies() {
    _booklistProvider = Provider.of<BooklistProvider>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _booklistProvider.getMoreBooks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final snackbar = SnackBar(
      elevation: 10,
      backgroundColor: Color(0xFFF0F0F6),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(
          color: themeData.errorColor,
          style: BorderStyle.solid,
          width: 5,
        ),
      ),
      content: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: themeData.errorColor,
            size: 24 * SizeConfig.safeAreaTextScalingFactor,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'No viewable version available!',
            style: themeData.textTheme.subtitle2.copyWith(
              color: themeData.errorColor,
              fontSize: 18 * SizeConfig.safeAreaTextScalingFactor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.fixed,
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: SizeConfig.isStandardScreen ? 10 : 5,
      ),
    );
    return Column(
      children: [
        if (_booklistProvider.getBooksList.length == 0)
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      Icons.error_outline,
                      size: SizeConfig.isStandardScreen ? 75 : 65,
                      color: themeData.errorColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      "No Books Found!",
                      style: themeData.textTheme.headline5.copyWith(
                        color: themeData.errorColor,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (_booklistProvider.getBooksList.length > 0)
          Expanded(
            child: GridView.custom(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: SizeConfig.isStandardScreen ? 3 : 3,
                childAspectRatio: SizeConfig.isStandardScreen ? 0.5 : 0.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
              ),
              childrenDelegate: SliverChildListDelegate(
                _booklistProvider.getBooksList.map(
                  (
                    book,
                  ) {
                    return InkWell(
                      onTap: () async {
                        var canOpen =
                            await _booklistProvider.getBookDetails(book.id);
                        if (!canOpen) {
                          Scaffold.of(context).showSnackBar(snackbar);
                        }
                      },
                      child: Container(
                        // margin: EdgeInsets.symmetric(horizontal: 3),
                        color: themeData.accentColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            book.formats["image/jpeg"] != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              211, 209, 238, 0.5),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      book.formats["image/jpeg"],
                                      scale: 1,
                                      height: SizeConfig.isStandardScreen
                                          ? 160
                                          : 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    height:
                                        SizeConfig.isStandardScreen ? 160 : 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              211, 209, 238, 0.5),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Color(0xFFA0A0A0),
                                        width: 1,
                                      ),
                                      color: Color(0xFFF0F0F6),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        _booklistProvider.getAssetByGenre(),
                                        height: 50,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0, bottom: 4.0),
                                child: Text(
                                  book.title.toUpperCase(),
                                  style: themeData.textTheme.caption.copyWith(
                                    // color: Color(0xFF333333),
                                    color: Colors.black,
                                    fontFamily: "Montserrat_SemiBold",
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                  ),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4.0, bottom: 4.0),
                                child: Text(
                                  book.authors.length > 0
                                      ? book.authors.first != null
                                          ? book.authors.first.name
                                          : ''
                                      : '',
                                  style: themeData.textTheme.caption.copyWith(
                                    color: Color(0xFFA0A0A0),
                                    fontFamily: "Montserrat_SemiBold",
                                    fontWeight: FontWeight.w700,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        if (_booklistProvider.pageLoader)
          Container(
            padding: EdgeInsets.only(bottom: 10),
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 15,
              ),
            ),
          ),
      ],
    );
  }
}
