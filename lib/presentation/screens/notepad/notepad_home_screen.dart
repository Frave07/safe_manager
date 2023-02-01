import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/notepad/add_notepad_screen.dart';
import 'package:safe_manager/presentation/screens/notepad/components/gridview_notes.dart';
import 'package:safe_manager/presentation/screens/notepad/components/listview_notes.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class NotepadHomeScreen extends StatefulWidget {

  const NotepadHomeScreen({Key? key}) : super(key: key);

  @override
  State<NotepadHomeScreen> createState() => _NotepadHomeScreenState();
}

class _NotepadHomeScreenState extends State<NotepadHomeScreen> {

  late final NotesBloc notesBloc;

  @override
  void initState() {
    notesBloc = BlocProvider.of<NotesBloc>(context);
    notesBloc.add(GetListNotesEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const TextCustom(
          text: 'My Notes',
          isTitle: true,
          fontWeight: FontWeight.w600, 
          fontSize: 17,
        ),
        centerTitle: true,
        leading: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.close, color: Colors.grey)
        ),
        actions: [
          BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              return IconButton(
                splashRadius: 20,
                onPressed: (){
                  notesBloc.add(ChangeGridListEvent(!state.isGridView));
                }, 
                icon: Icon(state.isGridView ? Icons.grid_view_rounded : Icons.sort, size: 19, color: ColorsFrave.primary)
              );
            },
          ),
          IconButton(
            splashRadius: 20,
            onPressed: () async {
              await Navigator.push(context, routeFade(page: const AddNotepadScreen()));
              notesBloc.add(GetListNotesEvent());
            }, 
            icon: const Icon(FontAwesomeIcons.plus, size: 19, color: Colors.blue)
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<NotesBloc, NotesState>(
          builder: (context, state) {

            if(state.listNotes.isEmpty){
              return const Center(
                child: TextCustom(
                  text: 'Without Notes',
                  color: Colors.grey,
                  isTitle: true,
                  fontWeight: FontWeight.bold,
                ),
              );
            }

            return state.isGridView
            ? GridviewNotes(notes: state.listNotes)
            : ListviewNotes(notes: state.listNotes);
          },
        ),
      ),
    );
  }
}