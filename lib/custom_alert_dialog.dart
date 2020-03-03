import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DialogDownloader extends StatefulWidget {
  final String title, description, buttonText;
  final String url;
  final String fileName;

  DialogDownloader(
      {@required this.title,
      @required this.description,
      @required this.buttonText,
      @required this.url,
      @required this.fileName});

  @override
  _DialogDownloaderState createState() => _DialogDownloaderState();
}

class _DialogDownloaderState extends State<DialogDownloader> {
  var valueIndicator = 0.0;

  var cont = '0.00', size = '?';

  @override
  void initState() {
    super.initState();
    _download(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              LinearProgressIndicator(
                value: valueIndicator,
              ),
              SizedBox(height: 24.0),
              Text(
                '$cont /$size MB',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // To close the dialog
                  },
                  child: Text(widget.buttonText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _download(String url) async {
    var dio = Dio();

    var response = await download(dio, url);

    Navigator.pop(context, response);
  }

  Future<String> download(Dio dio, String url) async {
    CancelToken cancelToken = CancelToken();
    Directory path = await getTemporaryDirectory();
    var pathFinal = path.path + '/${widget.fileName}';
    var res = await File(pathFinal).exists();
    if (!res) {
      try {
        await dio.download(url, pathFinal,
            onReceiveProgress: showDownloadProgress, cancelToken: cancelToken);

        var res = await File(pathFinal).exists();

        if (res) {
          return pathFinal;
        } else {
          return null;
        }
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      return pathFinal;
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      setState(() {
        cont = ((received) / 1048576).toStringAsFixed(2);
        size = ((total) / 1048576).toStringAsFixed(2);
        valueIndicator = received / total;
      });
    }
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
