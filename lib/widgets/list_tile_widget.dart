import 'package:flutter/material.dart';
import 'package:ping_helper/models/website.dart';

import 'global_snackbar.dart';

class ListTileWidget extends StatelessWidget {
  final Website website;

  ListTileWidget({@required this.website}) : assert(website != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: (website.available) ? Colors.lightGreen : Colors.orange,
      child: ListTile(
        title: Text(website.urlString),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
        subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text("HTTP Code: " + (website.status),
                      maxLines: 1, overflow: TextOverflow.ellipsis)),
              Flexible(
                  child: Text("Last checked: " + website.updatedAt,
                      maxLines: 2, overflow: TextOverflow.ellipsis),
                  flex: 2),
            ]),
        leading: website.favicon,
        onTap: () async {
          //await provider.getHeaders(index);
          GlobalSnackBar.show(context, website.headers.toString());
        },
      ),
    );
  }
}
