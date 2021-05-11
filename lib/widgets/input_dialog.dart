import 'package:flutter/material.dart';
import 'package:ping_helper/core/constants.dart';

class InputDialog extends StatefulWidget {
  final Function onPressed;
  final TextEditingController controller;
  final GlobalKey formKey;

  InputDialog(
      {@required this.onPressed,
      @required this.controller,
      @required this.formKey});

  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 10,
        child: Container(
          height: 300,
          padding: EdgeInsets.all(10),
          child: Form(
            key: widget.formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text('Add new website'),
                  TextFormField(
                    controller: widget.controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some url';
                      } else if (!RegExp(Validators.URL_VALIDATOR)
                          .hasMatch(value)) {
                        return 'Please enter valid url';
                      }
                      return null;
                    },
                  ),
                  MaterialButton(
                    onPressed: widget.onPressed,
                    //minWidth: MediaQuery.of(context).size.width * 0.25,
                    minWidth: double.infinity,
                    height: 40,
                    color: Colors.blueAccent,
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ]),
          ),
        ));
  }
}

/*class InputDialog extends StatelessWidget {
  final Function onPressed;
  final TextEditingController controller;

  InputDialog({@required this.onPressed, @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 10,
        child: Container(
          //width: MediaQuery.of(context).size.width * 0.9,
          height: 300,
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Add new website'),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.url,
                    maxLines: 1,
                    expands: false,
                    autofocus: true,
                    controller: controller,
                    /*decoration: InputDecoration(
                      prefix: Text('https://'),
                    ),*/
                  ),
                ),
                MaterialButton(
                  onPressed: onPressed,
                  //minWidth: MediaQuery.of(context).size.width * 0.25,
                  minWidth: double.infinity,
                  height: 40,
                  color: Colors.blueAccent,
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]
          ),
        )
    );
  }
}*/
