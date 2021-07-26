import 'package:flutter/material.dart';
import 'package:logss/common/constants/color.dart';

class DrawerWidget extends StatelessWidget {
  final String? name;
  const DrawerWidget({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blueGrey,
            const Color(ColorConstants.kBackgroundColor),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor:
                        const Color(ColorConstants.kBackgroundColor),
                    child: Center(
                      child: Text(
                        name![0],
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 27,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Hello, $name !",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Expanded(
            flex: 7,
            child: Container(
                child: ListView(
              children: [
                const DrawerTiles(icon: Icons.home, text: "Home"),
                const DrawerTiles(icon: Icons.favorite, text: "Favorite"),
                const DrawerTiles(icon: Icons.person, text: "Profile"),
                const DrawerTiles(icon: Icons.feedback, text: "Feedback"),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class DrawerTiles extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onTap;
  const DrawerTiles({required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        selected: true,
        selectedTileColor: Colors.red,
        onTap: onTap,
        leading: Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
