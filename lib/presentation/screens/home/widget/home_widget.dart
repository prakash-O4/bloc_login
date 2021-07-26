import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logss/presentation/blocs/PostBloc/post_bloc.dart';

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
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 0.9,
          color: Colors.yellow,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              if (imagePath.isNotEmpty)
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        child: Image(
                          image: CachedNetworkImageProvider(imagePath),
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
                    const SizedBox(height: 10.0),
                    Text(
                      content,
                      style: GoogleFonts.openSans(
                        color: Colors.yellow[100],
                        fontSize: 16.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 3,
                        right: 3,
                      ),
                      child: Divider(
                        height: 0.5,
                        color: Colors.yellow[100],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<PostBloc, PostState>(
                            builder: (context, state) {
                              if (state is CrudLiked) {
                                var likeStatus = state.likes;
                                print(likeStatus);
                                likeStatus
                                    ? IconButton(
                                        icon: Icon(
                                          Icons.favorite_border,
                                          color: Colors.yellow[200],
                                          size: 25.0,
                                        ),
                                        onPressed: () {
                                          // BlocProvider.of<PostBloc>(context)
                                          //     .add(PostLiked(
                                          //         likes: !likeStatus));
                                        },
                                      )
                                    : IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.yellow[200],
                                          size: 25.0,
                                        ),
                                        onPressed: () {
                                          // BlocProvider.of<PostBloc>(context)
                                          //     .add(PostLiked(
                                          //         likes: !likeStatus));
                                        },
                                      );
                              }
                              return IconButton(
                                icon: Icon(Icons.favorite_border,
                                    color: Colors.yellow[200], size: 25.0),
                                onPressed: () {
                                  // BlocProvider.of<PostBloc>(context).add(
                                  //   PostLiked(likes: false),
                                  // );
                                },
                              );
                            },
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
                    const SizedBox(height: 5.0)
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 2,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 4.0,
                bottom: 4,
              ),
              child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Tap to update post\nLong press to delete post",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.more_vert,
                  size: 28,
                  color: Colors.yellow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// : ClipRRect(
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(5.0),
//                             topRight: Radius.circular(5.0)),
//                         child: Image(
//                           image: AssetImage("images/icon.png"),
//                           filterQuality: FilterQuality.high,
//                           width: MediaQuery.of(context).size.width,
//                           fit: BoxFit.cover,
//                           color: Colors.black45,
//                           colorBlendMode: BlendMode.darken,
//                         ),
//                       ),