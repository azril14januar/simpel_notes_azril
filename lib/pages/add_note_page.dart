import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pertemuan_9/db/database_service.dart';
import 'package:pertemuan_9/models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _titleControler;
  late TextEditingController _descControler;

  final DatabaseService dbService = DatabaseService();

  @override
  void initState() {
    _titleControler = TextEditingController();
    _descControler = TextEditingController();

    if (widget.note != null) {
      _titleControler.text = widget.note!.title;
      _descControler.text = widget.note!.description;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleControler.dispose();
    _descControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.note != null ? "Edit Note" : "Add Note",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return "Judul Tidak Boleh Kosong";
                  } else {
                    return null;
                  }
                },
                controller: _titleControler,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukkan Judul',
                  hintStyle: TextStyle(fontSize: 24),
                ),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                maxLines: null,
              ),
              TextFormField(
                validator: (value) {
                  if (value == '') {
                    return "Deskripsi Tidak Boleh Kosong";
                  } else {
                    return null;
                  }
                },
                controller: _descControler,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Masukkan Deskripsi',
                  hintStyle: TextStyle(fontSize: 14),
                ),
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: null,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Note tempNote = Note(
              title: _titleControler.text,
              description: _descControler.text,
              createdAt: DateTime.now(),
            );

            if (widget.note != null) {
              dbService.editNote(widget.note!.key, tempNote).then((_) {
                GoRouter.of(context).pop();
              });
            } else {
              dbService.addNote(tempNote).then((_) {
                GoRouter.of(context).pop();
              });
            }
            // GoRouter.of(context).pop();
          }
        },
        label: const Text('Simpan'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}
