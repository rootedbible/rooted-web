import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialTile extends StatelessWidget {
  final String site;
  final String? username;
  final String type;

  const SocialTile({
    required this.site,
    this.username,
    this.type = 'social',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = getColors(site, context);
    final Color primary = colors[0];
    final Color secondary = colors[1];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          if (type == 'social') {
            await launchUrlString('https://$site.com/$username');
          } else if (type == 'website') {
            await launchUrlString(site);
          } else if (type == 'location') {
            await MapsLauncher.launchQuery(site);
          }
        },
        child: Container(
          width: 350,
          height: 75,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(45),
            gradient: LinearGradient(
              colors: [primary, secondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Align(
                  alignment: const Alignment(-0.75, 0),
                  child: ClipRect(
                    child: type != 'social'
                        ? Icon(
                            type == 'website' ? Icons.link : Icons.location_pin,
                            color: Colors.white,
                            size: 128,
                          )
                        : Image.asset(
                            'assets/images/socials/${site.toLowerCase()}.png',
                            height: 128,
                            width: 128,
                          ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: Colors.grey.withAlpha(125),
                ),
              ),
              Center(
                child: Text(
                  type == 'website'
                      ? 'Website'
                      : type == 'location'
                          ? 'Location'
                          : site,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Color> getColors(String site, BuildContext context) {
    switch (site) {
      case 'Facebook':
        return [const Color(0xFF3B5998), const Color(0xFF8b9DC3)];
      case 'X':
        return [Colors.black, Colors.white];
      case 'TikTok':
        return [const Color(0xFF00f2ea), const Color(0xFFff0050)];
      case 'Instagram':
        return [const Color(0xFF405DE6), const Color(0xFFF56040)];
      default:
        return [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ];
    }
  }
}
