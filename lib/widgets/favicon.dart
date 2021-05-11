import 'package:flutter/material.dart';

class FavIcon extends StatelessWidget {
  final String urlDomain;
  final int status;
  FavIcon({@required this.urlDomain, @required this.status});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/placeholder.jpg',
        image: (urlDomain != '' && status == 200)
            ? urlDomain + '/favicon.ico'
            : 'assets/placeholder.jpg',
        width: 25,
        height: 25,
        fit: BoxFit.fill,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/placeholder.jpg');
        },
      ),
      backgroundColor: Colors.white,
      radius: 25,
    );
  }
}
