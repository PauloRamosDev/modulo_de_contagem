import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:archive/archive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FirebaseHelper {
  var ref = Firestore.instance;

  Future<File> teste() async {
//    ref.collection('teste').document('123').setData({'teste': 'teste'});

    File output = await _downloadFile(
//        'https://firebasestorage.googleapis.com/v0/b/app-projeto-4cc0a.appspot.com/o/input%2Fteste%2FInput.zip?alt=media&token=a59d81bb-e5fc-423c-836e-bea953a7b64f',
       'https://firebasestorage.googleapis.com/v0/b/app-projeto-4cc0a.appspot.com/o/input%2Fteste%2Fapp.zip?alt=media&token=ff7eeb57-4e86-4c5a-a5cb-e7206de91b9e',
        'output.zip');

    var csv = await unZipFile(output);

    return csv;
//    csv.readAsLines(encoding: latin1).then((ln){
//
//
//      for(var i=0 ; i <2000;i++){
//        print(ln[i]);
//        ref.collection('OUL').document().setData({'item': ln[i]});
//      }
////
////      ln.forEach((linha){
////
////        ref.collection('OUL').document().setData({'item': linha});
////
////      });
//    });
  }

  Future<File> unZipFile(File file) async {
    try {
      Directory path = await getExternalStorageDirectory();
      // Le o arquivo Zip no disco
      List<int> bytes = file.readAsBytesSync();

      // Decodifica o arquivo Zip
      Archive archive = new ZipDecoder().decodeBytes(bytes);

      // Descompacta o arquivo Zip para o disco
      for (ArchiveFile file in archive) {
        String filename = "${path.path}/${file.name}";
        if (file.isFile) {
          List<int> data = file.content;

          File(filename)
            ..createSync(recursive: true)..writeAsBytesSync(data);
          print('filename: $filename');

          return File(filename);
        } else {
          var dir = await new Directory(filename).create(recursive: true);

          return File(dir.path);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<File> _downloadFile(String url, String filename) async {

    var cont = 0;

    HttpClient().getUrl(Uri.parse(url)).then((resquest)=>resquest.close()).then((response){
      response.listen((data){
        cont += data.length;
        print('data ' + cont.toString());
      });
    });

    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url));

    var bytes = req.bodyBytes;
    String dir = (await getExternalStorageDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
  Future<String> uploadFile(File file)async{

    final StorageReference storageReference = FirebaseStorage().ref().child('modulo_de_contagem/layout.json');

    final StorageUploadTask uploadTask = storageReference.putFile(file);

    final StreamSubscription<StorageTaskEvent> streamSubscription = uploadTask.events.listen((event) {
      // You can use this to notify yourself or your user in any kind of way.
      // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      // to show your user what the current status is. In that case, you would not need to cancel any
      // subscription as StreamBuilder handles this automatically.

      // Here, every StorageTaskEvent concerning the upload is printed to the logs.


      print(event.snapshot.bytesTransferred);
      print('EVENT ${event.type}');
    });

// Cancel your subscription when done.
    var storage = await uploadTask.onComplete;
    streamSubscription.cancel();
    return await storage.ref.getDownloadURL();




  }

}
