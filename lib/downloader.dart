import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Downloader{

  Future<String> download(url, fileName)async{

    var cache = (await getTemporaryDirectory()).path;

    Dio().download(url, cache).then((response){});


  }




}