import 'package:adsifiedhub/screens/add_ad_screen.dart';
import 'package:adsifiedhub/screens/advertiser_screen.dart';
import 'package:adsifiedhub/screens/adverts_screen.dart';
import 'package:adsifiedhub/screens/all_advertisers_screen.dart';
import 'package:adsifiedhub/screens/favorites_screen.dart';
import 'package:adsifiedhub/screens/home_screen.dart';
import 'package:adsifiedhub/screens/login_screen.dart';
import 'package:adsifiedhub/screens/manage_adverts_screen.dart';
import 'package:adsifiedhub/screens/profile_screen.dart';
import 'package:adsifiedhub/screens/register_screen.dart';
import 'package:adsifiedhub/screens/settings_screen.dart';
import 'package:adsifiedhub/screens/terms_screen.dart';
import 'package:adsifiedhub/screens/user_adverts_screen.dart';
import 'package:adsifiedhub/services/auth_service.dart';
import 'package:adsifiedhub/services/database_service.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'models/Advertiser.dart';
import 'models/CurrentUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<CurrentUser?>.value(
            value: AuthService().user, initialData: CurrentUser()),
        StreamProvider<List<Advertiser>>.value(
          value: DatabaseService().advertisers,
          initialData: [],
        )
      ],
      child: MaterialApp(
        routes: {
          '/': (context) => AnimatedSplashScreen(
                nextScreen: HomeScreen(),
                splashIconSize: double.infinity,
                splash: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/logo.png'),
                        fit: BoxFit.scaleDown),
                  ),
                ),
              ),
          '/add_ad': (context) => AddAdScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/user_adverts': (context) => UserAdvertsScreen(),
          '/adverts': (context) => AdvertsScreen(),
          '/favorites': (context) => FavoritesScreen(),
          '/manage_adverts': (context) => ManageAdvertsScreen(),
          '/terms': (context) => TermsScreen(),
          '/profile': (context) => ProfileScreen(),
          '/all_advertisers': (context) => AllAdvertisersScreen(),
          '/settings': (context) => SettingsScreen(),
          '/advertiser': (context) => AdvertiserScreen(),
        },
        title: 'AdsifiedHub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.red,
            textTheme:
                GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)),
      ),
    );
  }
}
