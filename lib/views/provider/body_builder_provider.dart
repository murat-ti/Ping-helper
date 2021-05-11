import 'package:flutter/material.dart';
import 'package:ping_helper/bloc/url_future_provider.dart';
import 'package:ping_helper/models/url.dart';
import 'package:ping_helper/widgets/circular_progress_widget.dart';
import 'package:ping_helper/widgets/text_center_widget.dart';
import '../../widgets/global_snackbar.dart';
import 'list_item_provider.dart';

class BodyBuilderProvider extends StatefulWidget {
  final UrlFutureProvider provider;

  BodyBuilderProvider({@required this.provider});

  @override
  _BodyBuilderProviderState createState() => _BodyBuilderProviderState();
}

class _BodyBuilderProviderState extends State<BodyBuilderProvider> {
  Future<bool> _result;

  @override
  void initState() {
    _result = widget.provider.getUrls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _result,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          if (widget.provider.urls.length > 0) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  Url url = widget.provider.urls[index];

                  return ListItemProvider(index,
                      (DismissDirection direction) async {
                    await widget.provider.removeUrl(url.id);
                    GlobalSnackBar.show(context, "Website deleted");
                  }, widget.provider);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(height: 3),
                itemCount: widget.provider.urls.length);
          } else
            return TextCenter(text: "No data in database");
        } else if (snapshot.hasError) {
          return TextCenter(text: "The error occurs while loading data");
        }
        return CircularProgressWidget();
      },
    );
  }
}
