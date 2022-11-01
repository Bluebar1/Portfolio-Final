# Portfolio
My portfolio website made in with Flutter.

## Packages used
* [Provider](https://pub.dev/packages/provider) for state management
* [Go Router](https://pub.dev/packages/go_router) for page routing.
* [Shared Preferences](https://pub.dev/packages/shared_preferences) for storing project data locally.


## Page Animations
Each page uses a static "builder" function to be accessed by the GoRouter. Here is MySplashPage's builder function:
```dart
static Page<void> builder(BuildContext context, GoRouterState state) =>
      CustomTransitionPage<void>(
          transitionDuration: Duration(milliseconds: 500),
          maintainState: true,
          key: state.pageKey,
          child: LayoutBuilder(builder: (context, constraints) {
            context.read<Responsive>().screenSize = constraints;
            return const MySplashPage();
          }),
          transitionsBuilder: (context, animation, _, child) {
            return ListenableProvider.value(
                builder: (context, _) => child, value: animation);
          });
```

Each page than can now access the animation by using:
```dart
final animation = context.read<Animation<double>>();
```
All animation objects are created in the page's state class. Many of them use custom compound animations to combine
up to three animation types (Opacity, Position, Scale). Here is an example of creating a compound animation:
```dart
picAnimation = Utils.compoundAnimation(
        begin: const FadePositionScale(FadePosition(0, Offset(30, 30)), .9),
        end: const FadePositionScale(FadePosition(1, Offset(0, 0)), 1.0),
        curve: Interval(.5, .7));
```

## State management
I still use Provider for state management because that is what was popular when I started in Flutter, but I am
willing to learn other tools. 
Each page that needs state is wrapped in Provider within its static "builder" method so that it can be accessed in
the overridden "build" method of StatelessWidget.
The intro page has an infinite repeating animation so it is required to use a StatefulWidget to access a 
SingleTickerProviderStateMixin. After the ticker is made it is passed into IntroState and controlled from there.
The IntroState is created with the global providers to ensure the images are animations are initialized in time.

There are two global state classes.
* AppState - loads/stores project data, the router object, and notifies the router when it is time to leave the splash screen.
* Responsive - provides information for making responsive screen layouts.

## Routing
For page routing I used go_router. The GoRouter object is created and storeed in the AppState class before
the runApp() function is called. AppState uses ChangeNotifierProvider so the router can be accessed from anywhere
in the app. Every time the app is loaded, a splash page is shown to either load project data via http or local cache.
Once the data is loaded the user will be redirected to the URL they entered. This is called deep-linking. Without 
deep linking the app always load the intro page on refresh.

Each Route object is neatly organized:
```dart
GoRoute(
  name: homeRouteName,
  path: '/home',
  pageBuilder: IntroPage.builder,
),
```

## Cache loading
The github README files for each project are loaded via http when the user loads the app for the first time.
After the data is fetched it is stored locally using the Shared Preferences package. The next time the user 
loads the app, the project data will be accessed via cache for much faster loading times.

Each pages file structure is organized in 3 distinct layers: Presentation (widgets/state), Domain (data manipulation),
and Data (data fetching). Because of this, my code for loading projects data looks like:
```dart
static Future<ProjectsDataModel> init() async {
  // Load & transform Projects from json asset file
  final _jsonString = await ProjectsData.loadProjectsJson();
  final _projects = ProjectsDomain.createProjects(_jsonString);
  final _quantityMap = ProjectsDomain.createQuantityMap(_projects);
  final _allTechUsed = ProjectsDomain.loadTechUsedLabels(_quantityMap);
  // load project descriptions
  await ProjectsData.loadReadmeTexts(_projects);
  // add descriptions to Project objects

  return ProjectsDataModel(_projects, _quantityMap, _allTechUsed);
}
```


