import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../services/auth_service.dart';
import '../services/notes_service.dart';
import '../utils/snack.dart';
import '../widgets/note_card.dart';
import 'note_detail_page.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _controller = TextEditingController();
  final _search = TextEditingController();
  final _notesService = NotesService();

  @override
  void dispose() {
    _controller.dispose();
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = 720.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Notes'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            onPressed: () => context.read<AuthService>().signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              controller: _search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search notes…',
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Note>>(
                  stream: _notesService.streamNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final notes = snapshot.data ?? <Note>[];
                    final query = _search.text.trim().toLowerCase();
                    final filtered = query.isEmpty
                        ? notes
                        : notes
                            .where((n) =>
                                n.title.toLowerCase().contains(query) ||
                                n.content.toLowerCase().contains(query))
                            .toList();

                    if (filtered.isEmpty) {
                      return const Center(child: Text('No notes yet. Start typing below!'));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final note = filtered[index];
                        return NoteCard(
                          note: note,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => NoteDetailPage(note: note),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemCount: filtered.length,
                    );
                  },
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        maxLines: 4,
                        minLines: 1,
                        decoration: const InputDecoration(
                          hintText: 'TextBox for Note',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.icon(
                      onPressed: () async {
                        final content = _controller.text.trim();
                        if (content.isEmpty) return;
                        await _notesService.addNote(content);
                        if (mounted) {
                          _controller.clear();
                          showSnack(context, 'Saved');
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatTime(DateTime dt) => DateFormat('dd MMM yyyy • HH:mm').format(dt);
