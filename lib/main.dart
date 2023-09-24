//other imports from current project
import 'dart:ui';
import "every_import.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

FirebaseAnalytics? analytics;
bool analyticsEnabledGlobally = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? analyticsDisabled = await readData('disableAnalytics');
  if (analyticsDisabled != '1') {
    analyticsEnabledGlobally = true;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    analytics = FirebaseAnalytics.instance;
  }
  runApp(const MyApp()); // Create an instance of MyApp and pass it to runApp.
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _myAppKey = GlobalKey<NavigatorState>();
  Future<bool> _backPressed(GlobalKey<NavigatorState> yourKey) async {
    //Checks if current Navigator still has screens on the stack.
    if (yourKey.currentState!.canPop()) {
      // 'maybePop' method handles the decision of 'pop' to another WillPopScope if they exist.
      //If no other WillPopScope exists, it returns true
      yourKey.currentState!.maybePop();
      return Future<bool>.value(false);
    }
    //if nothing remains in the stack, it simply pops
    return Future<bool>.value(true);
  }

  void setHomeWidget(Widget widget) {
    setState(() {
      homeWidget = widget;
    });
  }

  late Widget homeWidget;
  @override
  void initState() {
    homeWidget = LoggingInWidget(setHomeWidget: setHomeWidget);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getLatestRelease();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: WillPopScope(
        onWillPop: () => _backPressed(_myAppKey),
        child: Navigator(
          key: _myAppKey,
          pages: [
            MaterialPage(child: homeWidget),
          ],
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        ),
      ),
    );
  }
}

class LoggingInWidget extends StatelessWidget {
  const LoggingInWidget({
    super.key,
    required this.setHomeWidget,
  });

  final Function setHomeWidget;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final prefs = snapshot.data as SharedPreferences;
          final isLoggedIn = prefs.getString('loggedIn') == '1';
          if (isLoggedIn) {
            return FutureBuilder(
              future: initCanteen(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  if (snapshot.error == 'no internet') {
                    Future.delayed(Duration.zero, () => failedLoginDialog(context, 'Nemáte připojení k internetu', setHomeWidget));
                  } else if (snapshot.error == 'login failed') {
                    Future.delayed(Duration.zero, () => failedLoginDialog(context, 'Přihlášení selhalo', setHomeWidget));
                  } else {
                    return LoginScreen(setHomeWidget: setHomeWidget);
                  }
                  return const LoadingLoginPage(textWidget: Text('Přihlašování...'));
                } else if (snapshot.connectionState == ConnectionState.done) {
                  Future.delayed(Duration.zero, () => newUpdateDialog(context));
                  return MainAppScreen(setHomeWidget: setHomeWidget);
                } else {
                  return const LoadingLoginPage(textWidget: Text('Přihlašování...'));
                }
              },
            );
          } else {
            return LoginScreen(
              setHomeWidget: setHomeWidget,
            );
          }
        } else {
          return const LoadingLoginPage(textWidget: null);
        }
      },
    );
  }
}

class LoadingLoginPage extends StatelessWidget {
  const LoadingLoginPage({
    super.key,
    required this.textWidget,
  });
  final Widget? textWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 148, 18, 148),
        title: const Center(child: Text('Autojídelna')),
      ),
      body: const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(),
        ]),
      ),
    );
  }
}
