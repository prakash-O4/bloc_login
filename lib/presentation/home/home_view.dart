import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logss/blocs/Crud/crud_bloc.dart';
import 'package:logss/blocs/cubit/session_cubit.dart';
import 'package:logss/constants/color.dart';
import 'package:logss/presentation/home/drawer.dart';
import 'package:logss/presentation/home/new_articles.dart';
import 'package:logss/presentation/home/widget/home_widget.dart';

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
    return BlocProvider(
      create: (context) => CrudBloc(),
      child: Scaffold(
        backgroundColor: Color(ColorConstants.kHomeColorCode),
        drawer: Drawer(
          elevation: 0,
          child: DrawerWidget(name: widget.user!.displayName),
        ),
        appBar: AppBar(
          elevation: 0.8,
          backgroundColor: Color(ColorConstants.kBackgroundColor),
          title: Text("Mero kam"),
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<SessionCubit>(context).logOut();
              },
              icon: Icon(Icons.logout, size: 20),
            )
          ],
        ),
        body: HomeBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNotes(
                          isUpdate: false,
                        )));
          },
          child: Center(
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
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CrudBloc>(context).add(ReadArticles());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrudBloc, CrudState>(
      builder: (context, state) {
        if (state is CrudLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CrudLoaded) {
          var data = state.authCredentials;
          return data.length == 0
              ? Center(
                  child: Text(
                    "No articles found",
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
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
                        BlocProvider.of<CrudBloc>(context).add(
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
                            ),
                          ),
                        );
                      },
                      child: HomeBlog(
                        title: data[index].title,
                        content: data[index].content,
                      ),
                    );
                  },
                );
        } else if (state is CrudError) {
          return Center(
            child: Text(
              "error",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        }
        return Center(
          child: Text(
            "Fuck off",
            style: GoogleFonts.openSans(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.white30,
              ),
            ),
          ),
        );
      },
    );
  }
}
