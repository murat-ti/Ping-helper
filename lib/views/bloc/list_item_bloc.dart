import 'package:flutter/material.dart';
import 'package:ping_helper/bloc/home/bloc.dart';
import 'package:ping_helper/models/website.dart';
import 'package:ping_helper/widgets/favicon.dart';
import 'package:ping_helper/widgets/list_tile_widget.dart';
import 'package:ping_helper/widgets/text_center_widget.dart';

class ListItemBloc extends StatelessWidget {
  final int _index;
  final Function _onDismissed;
  final HomeBloc _bloc;
  final Website _website;

  ListItemBloc(this._index, this._onDismissed, this._bloc, this._website);

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
      ),
      onDismissed: _onDismissed,
      child: FutureBuilder<Website>(
        initialData: _website,
        future: (_website.status == 'XXX')
            ? _bloc.apiRepo.ping(_website)
            : null,
        //future: _bloc.apiRepo.ping(_website),
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
            _bloc.urlRepo.websites[_index] = website;

            return ListTileWidget(website: website);
          }
          else if (response.hasError) {
            return TextCenter(text: "The error occurs while loading data");
          }
          else {
            return ListTileWidget(website: _website);
          }
        },
      ),
    );
  }
}
