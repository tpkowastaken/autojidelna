import 'package:autojidelna/lang/l10n_global.dart';
import 'package:autojidelna/shared_widgets/scroll_view_column.dart';
import 'package:autojidelna/shared_widgets/settings/custom_divider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lang.about)),
      body: ScrollViewColumn(
        children: [
          // logo
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 85.0),
            child: SvgPicture.asset(
              "assets/images/logo.svg",
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
              height: MediaQuery.sizeOf(context).height * .10,
            ),
          ),
          const CustomDivider(isTransparent: false),
          // version list tile
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, data) {
              if (data.hasData && data.data != null) {
                return ListTile(
                  title: Text(lang.version),
                  subtitle: Text(lang.aboutVersionSubtitle(kDebugMode.toString(), data.data!.version)),
                  /*onTap: () async {
                    await Clipboard.setData(
                      ClipboardData(text: "App version: ${data.data!.version}"),
                    ); // TODO: mby add some other data
                  },*/
                );
              }
              return const SizedBox();
            },
          ),
          // licenses list tile
          ListTile(
            title: Text(lang.licenses),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LicensePage())),
          ),
          // collected data list tile
          // TODO: replace strings with variables
          ListTile(
            title: Text(lang.settingsDataCollectionDescription_4("0")),
            onTap: () {
              launchUrl(Uri.parse("https://github.com/Autojidelna/autojidelna/blob/main/listSbiranychDat.md"));
            },
          ),
          const CustomDivider(isTransparent: false),
          // links
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => launchUrl(Uri.parse("https://autojidelna.cz")),
                icon: const Icon(Icons.public_outlined),
              ),
              IconButton(
                onPressed: () => launchUrl(Uri.parse("https://github.com/Autojidelna/autojidelna")),
                icon: const Icon(Octicons.mark_github),
              ),
              IconButton(
                onPressed: () => launchUrl(Uri(scheme: "mailto", path: "autojidelna@tomprotiva.com")),
                icon: const Icon(Icons.email_outlined),
              ),
            ],
          )
        ],
      ),
    );
  }
}
