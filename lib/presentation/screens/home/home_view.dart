import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logss/presentation/blocs/Crud/crud_bloc.dart';
import 'package:logss/presentation/blocs/PostBloc/post_bloc.dart';
import 'package:logss/presentation/blocs/cubit/session_cubit.dart';
import 'package:logss/common/constants/color.dart';
import 'package:logss/common/constants/style.dart';
import 'package:logss/presentation/screens/home/drawer.dart';
import 'package:logss/presentation/screens/home/new_articles.dart';
import 'package:logss/presentation/screens/home/widget/home_widget.dart';

class HomePage extends StatefulWidget {
  final User? user;
  const HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CrudBloc()),
        BlocProvider(create: (context) => PostBloc()),
      ],
      child: Scaffold(
        backgroundColor: const Color(ColorConstants.kBackgroundColor),
        drawer: Drawer(
          elevation: 1,
          child: DrawerWidget(name: widget.user!.displayName),
        ),
        appBar: AppBar(
          elevation: 0.8,
          backgroundColor: const Color(ColorConstants.kBackgroundColor),
          title: Text(
            "BLOGGERS",
            style: GoogleFonts.openSans(
              letterSpacing: 3,
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<SessionCubit>(context).logOut();
              },
              icon: const Icon(Icons.logout, size: 20),
            )
          ],
        ),
        body: HomeBody(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(ColorConstants.kButtonColor),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNotes(
                          isUpdate: false,
                        )));
          },
          child: const Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 27,
            ),
          ),
        ),
      ),
    );
  }

  Widget logOutDialog() {
    return AlertDialog();
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  late CrudBloc _crudBloc;
  @override
  void initState() {
    super.initState();
    _crudBloc = BlocProvider.of<CrudBloc>(context);
    _crudBloc.add(ReadArticles());
  }

  @override
  void dispose() {
    _crudBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrudBloc, CrudState>(
      builder: (context, state) {
        if (state is CrudLoading) {
          return StyleConstants.kLoadingIcon;
        } else if (state is CrudLoaded) {
          var data = state.authCredentials;
          return data.length == 0
              ? Center(
                  child: Text(
                    "No articles found",
                    style: GoogleFonts.openSans(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white30,
                      ),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        _crudBloc.add(
                          DeleteArticles(
                            authCredential: data[index],
                          ),
                        );
                      },
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNotes(
                              title: data[index].title,
                              content: data[index].content,
                              isUpdate: true,
                              id: data[index].id,
                              imagePath: data[index].image,
                            ),
                          ),
                        );
                      },
                      child: HomeBlog(
                        title: data[index].title,
                        content: data[index].content,
                        imagePath: data[index].image,
                      ),
                    );
                  },
                );
        } else if (state is CrudError) {
          return const Center(
            child: Text(
              "error",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        }
        return StyleConstants.kLoadingIcon;
      },
    );
  }
}
