part of 'notes_bloc.dart';

@immutable
class NotesState extends Equatable {

  final NoteColors typeColor;
  final String title;
  final List<NotesModel> listNotes;
  final bool isGridView;


  const NotesState({
    this.typeColor = const NoteColors(uid: 1, color: 0xFFFFFFFF),
    this.title = 'Add Note',
    this.listNotes = const [],
    this.isGridView = true,
  });


  NotesState copyWith({
    NoteColors? typeColor,
    String? title,
    List<NotesModel>? listNotes,
    bool? isGridView,
  }) => NotesState(
    typeColor: typeColor ?? this.typeColor,
    title: title ?? this.title,
    listNotes: listNotes ?? this.listNotes,
    isGridView: isGridView ?? this.isGridView,
  );
  

  @override
  List<Object> get props => [
    typeColor,
    title,
    listNotes,
    isGridView,
  ];

}
