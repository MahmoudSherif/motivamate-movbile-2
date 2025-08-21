import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/notes_provider.dart';
import '../../models/note.dart';
import '../../theme/app_theme.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Toggle search bar visibility
              // For simplicity, we'll always show it
            },
          ),
        ],
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final notes = _searchQuery.isEmpty
              ? notesProvider.notes
              : notesProvider.searchNotes(_searchQuery);

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.glassBorder),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search notes...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.white70),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                // Notes Grid
                Expanded(
                  child: notes.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.note_alt_outlined,
                                size: 64,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _searchQuery.isEmpty
                                    ? 'No notes yet.\nTap + to create your first note!'
                                    : 'No notes found for "$_searchQuery"',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: notes.length,
                          itemBuilder: (context, index) {
                            final note = notes[index];
                            return _buildNoteCard(note);
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNoteEditor(),
        backgroundColor: AppTheme.primaryTeal,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return GestureDetector(
      onTap: () => _navigateToNoteEditor(note: note),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.glassBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              note.title.isEmpty ? 'Untitled' : note.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Content Preview
            Expanded(
              child: Text(
                note.content.isEmpty ? 'No content' : note.content,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // Footer
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (note.category.isNotEmpty) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryTeal.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      note.category,
                      style: const TextStyle(
                        color: AppTheme.primaryTeal,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Text(
                  _formatDate(note.updatedAt),
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                if (note.wordCount > 0) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${note.wordCount} words',
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNoteEditor({Note? note}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

class NoteEditorScreen extends StatefulWidget {
  final Note? note;

  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _categoryController;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');
    _categoryController = TextEditingController(text: widget.note?.category ?? '');

    _titleController.addListener(_onTextChanged);
    _contentController.addListener(_onTextChanged);
    _categoryController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        actions: [
          if (widget.note != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteNote,
            ),
          TextButton(
            onPressed: _hasChanges ? _saveNote : null,
            child: const Text('Save'),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.glassBorder),
        ),
        child: Column(
          children: [
            // Title Field
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Note title...',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white60,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            // Category Field
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                hintText: 'Category (optional)...',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.white60,
                  fontSize: 14,
                ),
              ),
              style: const TextStyle(
                color: AppTheme.primaryTeal,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Divider(color: Colors.white24),

            // Content Field
            Expanded(
              child: TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Start writing your note...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white60),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.5,
                ),
                maxLines: null,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();
    final category = _categoryController.text.trim();

    if (title.isEmpty && content.isEmpty) {
      // Don't save empty notes
      Navigator.of(context).pop();
      return;
    }

    final notesProvider = context.read<NotesProvider>();

    if (widget.note == null) {
      // Create new note
      final newNote = Note(
        title: title,
        content: content,
        category: category,
      );
      notesProvider.addNote(newNote);
    } else {
      // Update existing note
      final updatedNote = widget.note!.copyWith(
        title: title,
        content: content,
        category: category,
      );
      notesProvider.updateNote(updatedNote);
    }

    Navigator.of(context).pop();
  }

  void _deleteNote() {
    if (widget.note == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppTheme.cardBackground,
          title: const Text('Delete Note', style: TextStyle(color: Colors.white)),
          content: const Text(
            'Are you sure you want to delete this note? This action cannot be undone.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<NotesProvider>().deleteNote(widget.note!.id);
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Close editor
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}