import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBlog extends StatelessWidget {
  final String title;
  final String content;
  final String imagePath;
  const HomeBlog({
    required this.title,
    required this.content,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 0.9,
          color: Colors.yellow,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: Stack(
              children: [
                imagePath.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0)),
                        child: Image(
                          image: CachedNetworkImageProvider(imagePath),
                          filterQuality: FilterQuality.high,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          color: Colors.black45,
                          colorBlendMode: BlendMode.darken,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0)),
                        child: Image(
                          image: AssetImage("images/icon.png"),
                          filterQuality: FilterQuality.high,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          color: Colors.black45,
                          colorBlendMode: BlendMode.darken,
                        ),
                      ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Colors.transparent,
                          Color(0xff101010),
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 8,
                  child: IconButton(
                    onPressed: () {
                      // PopupMenuButton<String>(itemBuilder: ,);
                    },
                    icon: Icon(
                      Icons.more_vert,
                      size: 28,
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    color: Colors.yellow,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  content,
                  style: GoogleFonts.openSans(
                    color: Colors.yellow[100],
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border,
                            color: Colors.yellow[200], size: 25.0),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.comment,
                            color: Colors.yellow[200], size: 25.0),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(FontAwesomeIcons.paperPlane,
                            color: Colors.yellow[200], size: 25.0),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5.0)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
