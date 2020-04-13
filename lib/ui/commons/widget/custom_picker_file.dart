import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomPickerFile extends StatefulWidget {
  final String title;
  final Function(String) onSelectedPathFile;
  final FileType fileType;

  CustomPickerFile(
      {this.title = 'Arquivo',
      @required this.onSelectedPathFile,
      this.fileType = FileType.any});

  @override
  _CustomPickerFileState createState() => _CustomPickerFileState();
}

class _CustomPickerFileState extends State<CustomPickerFile> {
  var _fileName;

  @override
  Widget build(BuildContext context) {
    return FormField<String>(validator: (value) {
      if (_fileName == null) {
        return 'Error';
      } else {
        return null;
      }
    }, builder: (FormFieldState<String> field) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color:
                    field.hasError ? Colors.redAccent.shade700 : Colors.grey),
          ),
          child: ListTile(
            title: Text('Seleione um(a) ${widget.title}'),
            leading: Icon(
              Icons.insert_drive_file,
              size: 30,
            ),
            subtitle: Text(
              _fileName ?? '',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            trailing: _fileName != null
                ? IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.onSelectedPathFile(null);
                        _fileName = null;
                      });
                    })
                : Icon(
                    Icons.search,
                    size: 30,
                  ),
            onTap: () async {
              var path = await FilePicker.getFilePath(type: widget.fileType);
              if (path != null) {
                widget.onSelectedPathFile(path);
                setState(() {
                  _fileName = path;
                });
              }
            },
          ),
        ),
      );
    });
  }
}
