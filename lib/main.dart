import 'package:flutter/material.dart';
import './pages/book_list.dart';
import './pages/build_book_list.dart';
import './common/route_page.dart';
import './common/size_config.dart';
import './pages/home.dart';

void main() => runApp(GutenbergApp());

class GutenbergApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return MaterialApp(
      title: 'Gutenberg Project',
      debugShowCheckedModeBanner: false,
      builder: (ctx, navigator) {
        SizeConfig.init(ctx);
        return Theme(
          data: ThemeData(
            appBarTheme: AppBarTheme(
              brightness: Brightness.dark,
              iconTheme: IconThemeData(
                color: Color(0xFF5E56E7),
                opacity: 1,
              ),
              color: Color(0xFFF8F7FF),
              elevation: 0,
            ),
            primaryColor: Color(0xFF5E56E7),
            backgroundColor: Color(0xFFF8F7FF),
            accentColor: Color(0xFFF8F7FF),
            errorColor: Colors.red[700],
            cursorColor: Color(0xFF5E56E7),
            textTheme: TextTheme(
              headline1: TextStyle(
                fontFamily: 'Montserrat_Light',
                fontSize: themeData.textTheme.headline1.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              headline2: TextStyle(
                fontFamily: 'Montserrat_Light',
                fontSize: themeData.textTheme.headline2.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              headline3: TextStyle(
                fontFamily: 'Montserrat_SemiBold',
                fontSize: themeData.textTheme.headline3.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              headline4: TextStyle(
                fontFamily: 'Montserrat_SemiBold',
                fontSize: themeData.textTheme.headline4.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              headline5: TextStyle(
                fontFamily: 'Montserrat_Regular',
                fontSize: themeData.textTheme.headline5.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              headline6: TextStyle(
                fontFamily: 'Montserrat_Medium',
                fontSize: themeData.textTheme.headline6.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              subtitle1: TextStyle(
                fontFamily: 'Montserrat_Regular',
                fontSize: themeData.textTheme.subtitle1.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              subtitle2: TextStyle(
                fontFamily: 'Montserrat_Medium',
                fontSize: themeData.textTheme.subtitle2.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              bodyText1: TextStyle(
                fontFamily: 'Montserrat_Regular',
                fontSize: themeData.textTheme.bodyText1.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              bodyText2: TextStyle(
                fontFamily: 'Montserrat_Regular',
                fontSize: themeData.textTheme.bodyText2.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              button: TextStyle(
                fontFamily: 'Montserrat_Medium',
                fontSize: themeData.textTheme.button.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              caption: TextStyle(
                fontFamily: 'Montserrat_Regular',
                fontSize: themeData.textTheme.caption.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
              overline: TextStyle(
                fontFamily: 'Montserrat_Regular',
                fontSize: themeData.textTheme.overline.fontSize *
                    SizeConfig.safeAreaTextScalingFactor,
              ),
            ),
            cardTheme: CardTheme(
              // elevation: 2,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              shadowColor: Color.fromRGBO(211, 209, 238, 0.5),
              elevation: 3,
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Color(0xFFF0F0F6),
              focusColor: Color(0xFF5E56E7),
              labelStyle: TextStyle(
                color: Color(0xFFA0A0A0),
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat_Medium',
              ),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                gapPadding: 10.0,
                borderSide: BorderSide(
                  color: Color(0xFF5E56E7),
                  style: BorderStyle.solid,
                  width: SizeConfig.isStandardScreen ? 2 : 1.4,
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: SizeConfig.isStandardScreen
                    ? SizeConfig.safeAreaTextScalingFactor * 0.0
                    : SizeConfig.safeAreaTextScalingFactor * 0.0,
              ),
              helperStyle: TextStyle(
                color: Color(0xFF5E56E7),
              ),
              alignLabelWithHint: false,
              prefixStyle: TextStyle(
                color: Color(0xFFA0A0A0),
              ),
              hintStyle: TextStyle(
                color: Color(0xFFA0A0A0),
                fontWeight: FontWeight.w700,
                fontFamily: 'Montserrat_Medium',
              ),
              suffixStyle: TextStyle(
                color: Color(0xFFA0A0A0),
              ),
            ),
          ),
          child: navigator,
        );
      },
      routes: {
        '/': (ctx) => Home(),
        RoutePage.HOME: (ctx) => Home(),
        RoutePage.BOOK_LIST: (ctx) => BookList(),
        RoutePage.BUILD_BOOK_LIST: (ctx) => BuildBookList(),
      },
    );
  }
}
