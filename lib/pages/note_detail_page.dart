import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/note.dart';
import '../services/notes_service.dart';
import '../utils/snack.dart';

class NoteDetailPage extends StatefulWidget {
  final Note note;
  const NoteDetailPage({super.key, required this.note});

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  final _notesService = NotesService();
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = 720.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title.isEmpty ? 'Note' : widget.note.title),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Created: ${DateFormat('dd MMM yyyy • HH:mm').format(widget.note.createdAt)}'
                    '\nUpdated: ${DateFormat('dd MMM yyyy • HH:mm').format(widget.note.updatedAt)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Enter content of this note',
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        onPressed: () async {
                          await _notesService.updateNote(widget.note, _controller.text);
                          if (mounted) {
                            showSnack(context, 'Saved changes');
                            Navigator.of(context).pop(); // Close and refresh list
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text('Save'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        onPressed: () async {
                          final ok = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete note?'),
                              content: const Text('This action cannot be undone.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                FilledButton.tonal(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          );
                          if (ok != true) return;
                          await _notesService.deleteNote(widget.note);
                          if (mounted) {
                            Navigator.of(context).pop(); // Close this screen
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text('Delete'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
