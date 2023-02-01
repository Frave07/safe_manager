part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class ChangeBackgroundColorEvent extends NotesEvent {
  final NoteColors color;
  const ChangeBackgroundColorEvent(this.color);
}

class ChangeTitleNoteEvent extends NotesEvent {
  final String title;
  const ChangeTitleNoteEvent(this.title);
}

class SaveNoteEvent extends NotesEvent {
  final String title;
  final String description;
  const SaveNoteEvent({required this.title, required this.description});
}

class GetListNotesEvent extends NotesEvent {}

class ChangeGridListEvent extends NotesEvent {
  final bool isGridview;
  const ChangeGridListEvent(this.isGridview);
}

class EditNoteEvent extends NotesEvent {
  final int index;
  final String title;
  final String description;
  const EditNoteEvent({required this.index, required this.title, required this.description});
}

class DeleteNoteEvent extends NotesEvent {
  final int index;
  const DeleteNoteEvent(this.index);
}


