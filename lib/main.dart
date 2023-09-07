//other imports from current project
import "every_import.dart";

void main() async {
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
        ));
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
                if (snapshot.connectionState == ConnectionState.done) {
                  late final Canteen canteen;
                  try {
                    canteen = snapshot.data as Canteen;
                    if (canteen.prihlasen) {
                      return MainAppScreen(setHomeWidget: setHomeWidget);
                    }
                    return LoginScreen(
                      setHomeWidget: setHomeWidget,
                    );
                  } catch (e) {
                    return LoginScreen(
                      setHomeWidget: setHomeWidget,
                    );
                  }
                } else if (snapshot.hasError) {
                  return LoginScreen(
                    setHomeWidget: setHomeWidget,
                  );
                } else {
                  return const LoadingLoginPage(
                      textWidget: Text('Přihlašování...'));
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
        title: const Text('Autojídelna'),
      ),
      body: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const CircularProgressIndicator(),
          Padding(
              padding: const EdgeInsets.all(10),
              child: textWidget ?? const Text('')),
        ]),
      ),
    );
  }
}