import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/applied_job.dart';
import 'package:kerjakanapp/provider/applied_user.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/provider/recommend_job.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:kerjakanapp/provider/vacancies.dart';
import 'package:kerjakanapp/screens/add_user_certificate_screen.dart';
import 'package:kerjakanapp/screens/add_user_education_screen.dart';
import 'package:kerjakanapp/screens/change_user_mode.dart';
import 'package:kerjakanapp/screens/drawer_screen.dart';
import 'package:kerjakanapp/screens/edit_profil_job_seeker_screen.dart';
import 'package:kerjakanapp/screens/edit_skills_screen.dart';
import 'package:kerjakanapp/screens/finish_add_job_screen.dart';
import 'package:kerjakanapp/screens/finish_apply_job_screen.dart';
import 'package:kerjakanapp/screens/give_rating_screen.dart';
import 'package:kerjakanapp/screens/home_screen_job_seeker.dart';
import 'package:kerjakanapp/screens/job_detail_screen.dart';
import 'package:kerjakanapp/screens/job_seeker_detail_screen.dart';
import 'package:kerjakanapp/screens/nearby_job_screen.dart';
import 'package:kerjakanapp/screens/nearby_job_seeker_screen.dart';
import 'package:kerjakanapp/screens/open_job_screen.dart';
import 'package:kerjakanapp/screens/recommend_job_screen.dart';
import 'package:kerjakanapp/screens/sign_in_screen.dart';
import 'package:kerjakanapp/screens/sign_up_screen_1.dart';
import 'package:kerjakanapp/screens/sign_up_screen_2.dart';
import 'package:kerjakanapp/screens/sign_up_screen_3.dart';
import 'package:kerjakanapp/screens/sign_up_screen_finish.dart';
import 'package:kerjakanapp/screens/skill2_screen.dart';
import 'package:kerjakanapp/screens/skill_delivery_automotive_screen.dart';
import 'package:kerjakanapp/screens/skill_home_service_screen.dart';
import 'package:kerjakanapp/screens/skill_leisure_services_screen.dart';
import 'package:kerjakanapp/screens/skill_miscellaneous_screen.dart';
import 'package:kerjakanapp/screens/skill_personal_care_screen.dart';
import 'package:kerjakanapp/screens/skill_screen.dart';
import 'package:kerjakanapp/screens/splash_screen.dart';
import 'package:kerjakanapp/screens/vecancy_detail_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return UserData();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return UserSkills();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return NearbyJobs();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return NearbyJobSeeker();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return RecommendJobs();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return AppliedJob();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return AppliedUser();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return Vacancies();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return Auth();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'kerjakan',
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF2152DB, const {
            50: primaryColor,
            100: primaryColor,
            200: primaryColor,
            300: primaryColor,
            400: primaryColor,
            500: primaryColor,
            600: primaryColor,
            700: primaryColor,
            800: primaryColor,
            900: primaryColor
          }),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          MainScreen.routeName: (context) => MainScreen(),
          DrawerScreen.routeName: (context) => DrawerScreen(),
          HomeScreenJobSeeker.routeName: (context) => HomeScreenJobSeeker(),
          NearbyJobScreen.routeName: (context) => NearbyJobScreen(),
          NearbyJobSeekerScreen.routeName: (context) => NearbyJobSeekerScreen(),
          RecommendJobScreen.routeName: (context) => RecommendJobScreen(),
          EditSkillScreen.routeName: (context) => EditSkillScreen(),
          ChangeUserModeScreen.routeName: (context) => ChangeUserModeScreen(),
          FinishApplyJobScreen.routeName: (context) => FinishApplyJobScreen(),
          FinishAddJobScreen.routeName: (context) => FinishAddJobScreen(),
          VacancyDetailScreen.routeName: (context) => VacancyDetailScreen(),
          EditProfileJobSeekerScreen.routeName: (context) =>
              EditProfileJobSeekerScreen(),
          AddUserCertificateScreen.routeName: (context) =>
              AddUserCertificateScreen(),
          AddUserEducationScreen.routeName: (context) =>
              AddUserEducationScreen(),
          GiveRatingScreen.routeName: (context) => GiveRatingScreen(),
          SignUpScreen1.routeName: (context) => SignUpScreen1(),
          SignUpScreen2.routeName: (context) => SignUpScreen2(),
          SignUpScreen3.routeName: (context) => SignUpScreen3(),
          SignUpScreenFinish.routeName: (context) => SignUpScreenFinish(),
          SkillScreen.routeName: (context) => SkillScreen(),
          Skill2Screen.routeName: (context) => Skill2Screen(),
          SkillHomeServiceScreen.routeName: (context) =>
              SkillHomeServiceScreen(),
          SkillDeliveryAutomotiveScreen.routeName: (context) =>
              SkillDeliveryAutomotiveScreen(),
          SkillPersonalCareScreen.routeName: (context) =>
              SkillPersonalCareScreen(),
          SkillLeisureServicesScreen.routeName: (context) =>
              SkillLeisureServicesScreen(),
          SkillMiscellaneousScreen.routeName: (context) =>
              SkillMiscellaneousScreen(),
          JobDetailScreen.routeName: (context) => JobDetailScreen(),
          JobSeekerDetailScreen.routeName: (context) => JobSeekerDetailScreen(),
          OpenJobScreen.routeName: (context) => OpenJobScreen(),
        },
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  static const routeName = '/main-screen';
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final userData = Provider.of<UserData>(context, listen: false);

    print(auth.isAuth);

    return auth.isAuth
        ? FutureBuilder(
            future: userData.fetchUserData(auth.id, context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return DrawerScreen();
              } else {
                return SplashScreen();
              }
            },
          )
        : FutureBuilder(
            future: auth.tryAutoLogIn(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SignInScreen();
              } else {
                print('sign in');
                return SignInScreen();
              }
            },
          );
  }
}
