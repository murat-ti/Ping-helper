import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ping_helper/bloc/home/bloc.dart';
import 'package:ping_helper/models/url.dart';
import 'package:ping_helper/models/website.dart';
import 'package:ping_helper/widgets/global_snackbar.dart';
import 'package:ping_helper/widgets/input_dialog.dart';
import 'package:ping_helper/widgets/text_center_widget.dart';

import 'list_item_bloc.dart';

class HomeBlocScreen extends StatefulWidget {
  HomeBlocScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeBlocScreenState createState() => _HomeBlocScreenState();
}

class _HomeBlocScreenState extends State<HomeBlocScreen> {
  List<Website> _websites = [];
  HomeBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<HomeBloc>(context);
    _bloc.add(HomeLoadEvent());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                _bloc.urlRepo.isNewItemAdded = false;
                _websites = [];
                _bloc.add(HomeLoadEvent());
                GlobalSnackBar.show(context, "Reload websites list");
              },
              child: Icon(
                Icons.refresh,
                size: 26.0,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeLoadedState) {
              _websites.clear();
              _websites.addAll(state.websites);
            }
          },
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return CircularProgressIndicator();
              } else if (state is HomeLoadedState) {
                return RefreshIndicator(
                  onRefresh: () async {
                    _websites = [];
                    _bloc.add(HomeLoadEvent());
                  },
                  child: (_bloc.urlRepo.urls.length > 0) ? ListView.separated(
                    itemCount: _websites.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(height: 3),
                    itemBuilder: (context, index) {
                      return ListItemBloc(
                        index,
                        (DismissDirection direction) async {
                          _bloc.urlRepo.removeUrl(_bloc.urlRepo.urls[index].id);
                          GlobalSnackBar.show(context, "Website deleted");
                        },
                        _bloc,
                        _websites[index],
                      );
                    },
                  ) : TextCenter(text: "No data found in database"),
                );
              } else {
                return Container(
                  child: Center(
                    child: Text('You have an error'),
                  ),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.text = '';
          return await showDialog(
            context: context,
            builder: (_) => InputDialog(
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    Url url = new Url(path: controller.text);

                    await _bloc.urlRepo.addUrl(url);
                    _bloc.add(HomeLoadEvent());

                    Navigator.of(context).pop();
                    GlobalSnackBar.show(context, "Added new website");
                  }
                },
                controller: controller,
                formKey: formKey),
          );
        },
        tooltip: 'Add new website',
        child: Icon(Icons.add),
      ),
    );
  }
}
