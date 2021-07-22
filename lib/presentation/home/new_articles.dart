import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logss/blocs/Crud/crud_bloc.dart';
import 'package:logss/constants/color.dart';
import 'package:logss/constants/style.dart';
import 'package:logss/model/user_details.dart';

class AddNotes extends StatelessWidget {
  final String? title;
  final String? content;
  final String? id;
  final bool isUpdate;
  const AddNotes({this.title, this.content, this.id, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CrudBloc(),
      child: AddArticless(
        title: title,
        content: content,
        isUpdate: isUpdate,
        id: id,
      ),
    );
  }
}

class AddArticless extends StatefulWidget {
  final String? title;
  final String? content;
  final String? id;
  final bool isUpdate;
  const AddArticless(
      {this.content, this.title, this.id, required this.isUpdate});

  @override
  _AddArticlessState createState() => _AddArticlessState();
}

class _AddArticlessState extends State<AddArticless> {
  late final _titleController;
  late final _contentController;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _contentController = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(ColorConstants.kBackgroundColor),
      appBar: AppBar(
        backgroundColor: const Color(ColorConstants.kBackgroundColor),
        elevation: 0,
        title: widget.isUpdate ? Text("Update Articles") : Text("Add Articles"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bloggers",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _titleController,
                    cursorColor: Colors.pink,
                    style: StyleConstants.kTextStyle,
                    decoration: StyleConstants.input("Articles Titles"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 300),
              child: TextField(
                controller: _contentController,
                maxLines: null,
                style: StyleConstants.kTextStyle,
                cursorColor: Colors.pink,
                decoration: StyleConstants.input("Articles Body"),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: StyleConstants.kButtonStyle,
                onPressed: () {
                  var _bloc = BlocProvider.of<CrudBloc>(context);
                  widget.isUpdate
                      ? BlocProvider.of<CrudBloc>(context).add(
                          UpdateArticles(
                            authCredentials: AuthCredentials(
                              title: _titleController.text,
                              time: DateTime.now().toString(),
                              content: _contentController.text,
                              id: widget.id!,
                            ),
                          ),
                        )
                      : _bloc.add(
                          AddArticles(
                            authCredentials: AuthCredentials(
                              title: _titleController.text,
                              time: DateTime.now().toString(),
                              content: _contentController.text,
                            ),
                          ),
                        );
                  Navigator.pop(context);
                },
                child: StyleConstants.kButtonText(
                  widget.isUpdate ? "Update Articles" : "Add Articles",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
