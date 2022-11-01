import 'package:go_router/go_router.dart';
import 'package:portfolio/pages/intro/intro.dart';
import 'package:portfolio/pages/splash/splash_page.dart';
import 'package:portfolio/utils.dart';

import 'app_state.dart';
import 'pages/about_me/about_me.dart';
import 'pages/contact/contact.dart';
import 'pages/error/error_page.dart';
import 'pages/navigation/navigation.dart';
import 'pages/project_description.dart/proj_desc.dart';
import 'pages/projects/projects.dart';

const rootRouteName = 'root';
const homeRouteName = 'home';
const projectsRouteName = 'projects';
const projectDetailsRouteName = 'project-details';

const contactRouteName = 'contact';
const navRouteName = 'nav';
const sandboxRouteName = 'sandbox';
const splashRouteName = 'splash';

const aboutMeRouteName = 'about-me';
const educationSectionName = 'Education';
const workHistorySectionName = 'Work_History';
const recentPublicationsSectionsName = 'Recent_Publications';

class MyRouter {
  final AppState dataState;

  MyRouter(this.dataState);

  late final router = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    refreshListenable: dataState,
    routes: [
      GoRoute(
        name: rootRouteName,
        path: '/',
        redirect: (state) => state.namedLocation(homeRouteName),
      ),
      GoRoute(
        name: splashRouteName,
        path: '/loading',
        pageBuilder: MySplashPage.builder,
      ),
      GoRoute(
        name: homeRouteName,
        path: '/home',
        pageBuilder: IntroPage.builder,
      ),
      GoRoute(
        name: projectsRouteName,
        path: '/projects',
        pageBuilder: Projects.builder,
      ),
      GoRoute(
        name: projectDetailsRouteName,
        path: '/details/:project',
        pageBuilder: ProjDesc.builder,
      ),
      GoRoute(
        name: aboutMeRouteName,
        path: '/about-me/:section',
        pageBuilder: AboutMe.builder,
      ),
      GoRoute(
        name: contactRouteName,
        path: '/contact',
        pageBuilder: Contact.builder,
      ),
      GoRoute(
        name: navRouteName,
        path: '/nav',
        pageBuilder: Navigation.builder,
      ),
    ],
    redirect: (state) {
      final hasData = dataState.hasData;
      final loadingLoc = '/loading';
      final loadingData = state.subloc == loadingLoc;

      /// On first load always redirect user to loading screen
      if (!hasData && !loadingData) return loadingLoc;

      /// Then send them to the route they provided.
      if (hasData && loadingData) return dataState.initialRoute;

      // Ensure IntroPage only shows SplashFadeAway once.
      if (state.subloc != '/home' &&
          state.subloc != '/loading' &&
          state.subloc != '/' &&
          !state.subloc.contains('details')) {
        dataState.isFirstLoad = false;
      }

      if (dataState.initialRoute.contains('details')) return '/projects';
      return null;
    },
    errorPageBuilder: (context, state) {
      _startRedirectTimer();
      return ErrorPage.builder(context, state);
    },
  );

  _startRedirectTimer() async {
    await Utils.sleepMS(2000);
    router.goNamed(homeRouteName);
  }
}
