import 'package:flutter/material.dart';
import 'package:ping_helper/bloc/url_future_provider.dart';
import 'package:ping_helper/models/url.dart';
import 'package:ping_helper/models/website.dart';
import 'package:ping_helper/widgets/favicon.dart';
import 'package:ping_helper/widgets/global_snackbar.dart';
import 'package:ping_helper/widgets/list_tile_widget.dart';
import 'package:ping_helper/widgets/text_center_widget.dart';

class ListItemProvider extends StatelessWidget {
  final int index;
  final Function onDismissed;
  final UrlFutureProvider provider;

  ListItemProvider(this.index, this.onDismissed, this.provider);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.delete, color: Colors.white),
              Icon(Icons.delete, color: Colors.white),
            ],
          ),
          //  alignment: Alignment.centerRight,
        ),
        onDismissed: onDismissed,
        child: FutureBuilder<Website>(
          initialData: provider.websites[index],
          future: (provider.addedIndex == -1 || index == provider.addedIndex)
              ? provider.ping(index)
              : null,
          builder: (BuildContext context, AsyncSnapshot<Website> response) {
            if (response.hasData) {
              Website website = response.data;
              website = website.copyWith(
                icon: FavIcon(
                    urlDomain: website.urlDomain, status: website.httpStatus),
                isSync: (response.connectionState == ConnectionState.done ||
                    website.httpStatus is int)
                    ? false
                    : true,
              );

              //update with new data
              provider.websites[index] = website;

              return ListTileWidget(website: website);
            }
            else if (response.hasError) {
              return TextCenter(text: "The error occurs while loading data");
            }
            else {
              return ListTileWidget(website: provider.websites[index]);
            }
          },
        ));
  }
}
