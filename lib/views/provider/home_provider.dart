import 'package:flutter/material.dart';
import 'package:ping_helper/bloc/url_future_provider.dart';
import 'package:ping_helper/models/url.dart';
import 'package:ping_helper/widgets/global_snackbar.dart';
import 'package:ping_helper/widgets/input_dialog.dart';
import 'package:provider/provider.dart';

import 'body_builder_provider.dart';

class HomeProvider extends StatefulWidget {
  HomeProvider({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeProviderState createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  UrlFutureProvider _provider;
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<UrlFutureProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  _provider.refreshList();
                  GlobalSnackBar.show(context, "Reload websites list");
                },
                child: Icon(
                  Icons.refresh,
                  size: 26.0,
                ),
              )),
        ],
      ),
      body: BodyBuilderProvider(provider: _provider),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          controller.text = '';
          return await showDialog(
            context: context,
            builder: (_) => InputDialog(
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    Url url = new Url(path: controller.text);
                    await _provider.addUrl(url);
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
