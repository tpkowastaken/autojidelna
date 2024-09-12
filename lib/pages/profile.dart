// Profile page including just some basic statistics and user info

import 'package:autojidelna/lang/l10n_global.dart';
import 'package:autojidelna/local_imports.dart';
import 'package:autojidelna/shared_prefs.dart';

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.setHomeWidget});
  final Function(Widget widget) setHomeWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lang.account),
        actions: [
          _appBarLogoutButton(context),
        ],
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Icon, username, credit
                  _userMainInfo(context),
                  //Jméno a příjmení
                  _userPersonalinfo(context),
                  // Platební údaje
                  _userBillingInfo(context),
                  //Autojídelna
                  _autojidelna(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding _appBarLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        onPressed: () async {
          try {
            /*if (!((await showDialog(context: context, barrierDismissible: true, builder: (BuildContext context) => logoutDialog(context)) == true))) {
              return;
            }*/
          } catch (e) {
            return;
          }
          if (context.mounted && Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          await loggedInCanteen.logout();
          await Future.delayed(const Duration(milliseconds: 300));
          setHomeWidget(const LoggingInWidget(/*setHomeWidget: setHomeWidget*/));
        },
        icon: const Icon(Icons.logout),
      ),
    );
  }

  Container _userMainInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.account_circle, size: 80),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loggedInCanteen.uzivatel!.uzivatelskeJmeno!,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        lang.credit(loggedInCanteen.uzivatel!.kredit),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _userPersonalinfo(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(lang.personalInfo),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.jmeno != null || loggedInCanteen.uzivatel!.prijmeni != null) {
                      return Text(
                        lang.name /*(loggedInCanteen.uzivatel!.jmeno ?? '', loggedInCanteen.uzivatel!.prijmeni ?? '')*/,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.kategorie != null) {
                      return Text(
                        lang.category /*(loggedInCanteen.uzivatel!.kategorie ?? '')*/,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _userBillingInfo(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(lang.paymentInfo),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.ucetProPlatby != null && loggedInCanteen.uzivatel!.ucetProPlatby != '') {
                      return Text(
                        lang.paymentAccountNumber /*(loggedInCanteen.uzivatel!.ucetProPlatby ?? '')*/,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.specSymbol != null && loggedInCanteen.uzivatel!.specSymbol != '') {
                      return Text(
                        lang.specificSymbol /*(loggedInCanteen.uzivatel!.specSymbol ?? '')*/,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      //return nothing
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
                Builder(
                  builder: (context) {
                    if (loggedInCanteen.uzivatel!.varSymbol != null && loggedInCanteen.uzivatel!.varSymbol != '') {
                      return Text(
                        lang.variableSymbol /*(loggedInCanteen.uzivatel!.varSymbol ?? '')*/,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                      );
                    } else {
                      return const SizedBox(width: 0, height: 0);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _autojidelna(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(lang.appName),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FutureBuilder(
              future: readStringFromSharedPreferences(Prefs.statistikaObjednavka),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Text(
                    lang.ordersWithAutojidelna(int.parse(snapshot.data!)),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                  );
                } else {
                  return Text(
                    lang.ordersWithAutojidelna(0),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
