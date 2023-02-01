import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:safe_manager/data/note_colors/note_colors.dart';
import 'package:safe_manager/domain/models/notes_model/notes_model.dart';
import 'package:uuid/uuid.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {

  NotesBloc() : super(const NotesState()) {

    on<ChangeBackgroundColorEvent>(_changeBackgroundColor);
    on<ChangeTitleNoteEvent>(_changeTitleNote);
    on<SaveNoteEvent>(_saveNote);
    on<GetListNotesEvent>(_getListNotes);
    on<ChangeGridListEvent>(_changeGridList);
    on<EditNoteEvent>(_editNote);
    on<DeleteNoteEvent>(_deleteNote);

  }


  Future<void> _changeBackgroundColor(ChangeBackgroundColorEvent event, Emitter<NotesState> emit) async {
  
    return emit(state.copyWith(typeColor: event.color));
  }


  Future<void> _changeTitleNote(ChangeTitleNoteEvent event, Emitter<NotesState> emit) async {
  
    if(event.title.isEmpty){
      return emit(state.copyWith(title: 'Add Note'));
    }

    return emit(state.copyWith(title: event.title));
  }


  Future<void> _saveNote(SaveNoteEvent event, Emitter<NotesState> emit) async {
  
    if(event.title.isNotEmpty){

      final box = Hive.box<NotesModel>('encrypt-notes-fraved');

      const uuid = Uuid();

      final note = NotesModel(
        uid: uuid.v4(),
        title: event.title,
        description: event.description,
        uidColor: state.typeColor.uid,
        color: state.typeColor.color,
        date: DateTime.now(),
        dateEdit: DateTime.now()
      );

      box.add(note);
    }
  
  }


  Future<void> _getListNotes(GetListNotesEvent event, Emitter<NotesState> emit) async {
  
    emit(state.copyWith(listNotes: const []));
  
    final box = Hive.box<NotesModel>('encrypt-notes-fraved');

    final notes = box.values.toList();

    print(notes.length);

    return emit(state.copyWith(
      listNotes: notes,
      title: 'Add notes',
      typeColor: const NoteColors(uid: 1, color: 0xFFFFFFFF)
    ));
  }


  Future<void> _changeGridList(ChangeGridListEvent event, Emitter<NotesState> emit) async {
    
    return emit(state.copyWith(isGridView: event.isGridview));
  }


  Future<void> _editNote(EditNoteEvent event, Emitter<NotesState> emit) async {
    
     if(event.title.isNotEmpty){

      final box = Hive.box<NotesModel>('encrypt-notes-fraved');

      const uuid = Uuid();

      final note = NotesModel(
        uid: uuid.v4(),
        title: event.title,
        description: event.description,
        uidColor: state.typeColor.uid,
        color: state.typeColor.color,
        date: DateTime.now(),
        dateEdit: DateTime.now()
      );

      box.putAt(event.index, note);
    }
  
  }


  Future<void> _deleteNote(DeleteNoteEvent event, Emitter<NotesState> emit) async {
  
    final box = Hive.box<NotesModel>('encrypt-notes-fraved');
    box.deleteAt(event.index);
  }




}
