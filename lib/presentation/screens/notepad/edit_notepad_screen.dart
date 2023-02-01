import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/data/note_colors/note_colors.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/domain/models/notes_model/notes_model.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/notepad/components/modal_option_note.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class EditNotepadScreen extends StatefulWidget {

  final NotesModel note;
  final int index;

  const EditNotepadScreen({Key? key, required this.note, required this.index}) : super(key: key);

  @override
  State<EditNotepadScreen> createState() => _EditNotepadScreenState();
}

class _EditNotepadScreenState extends State<EditNotepadScreen> {

  late final NotesBloc notesBloc;
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    notesBloc = BlocProvider.of<NotesBloc>(context);
    notesBloc.add(ChangeBackgroundColorEvent(NoteColors(uid: widget.note.uidColor, color: widget.note.color)));
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController = TextEditingController(text: widget.note.description);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) => Scaffold(
        backgroundColor: Color(state.typeColor.color),
        appBar: AppBar(
          backgroundColor: Color(state.typeColor.color),
          title: TextCustom(
            text: state.title,
            isTitle: true,
            fontWeight: FontWeight.w500, 
            fontSize: 17,
          ),
          centerTitle: true,
          leading: IconButton(
            splashRadius: 20,
            onPressed: (){
              if(_titleController.text.trim().isNotEmpty || _descriptionController.text.trim().isNotEmpty){
                notesBloc.add(EditNoteEvent(
                  index: widget.index,
                  title: _titleController.text.trim(), 
                  description: _descriptionController.text.trim()
                ));
                Navigator.pop(context);
              }else{
                Navigator.pop(context);
              }
            }, 
            icon: const Icon(Icons.arrow_back_ios_new_rounded)
          ),
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: (){
                modalOptionNote(context, widget.index);
              }, 
              icon: const Icon(Icons.more_vert_rounded)
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            children: [
              TextFormField(
                controller: _titleController,
                maxLines: null,
                cursorHeight: 28,
                cursorWidth: 1.5,
                cursorColor: ColorsFrave.primary,
                style: GoogleFonts.poppins(fontSize: 16, color: ColorsFrave.primary, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: GoogleFonts.inter(color: Colors.grey)
                ),
                onChanged: (value) {
                  notesBloc.add(ChangeTitleNoteEvent(value));
                },
              ),
              TextFormField(
                controller: _descriptionController,
                maxLines: null,
                cursorHeight: 28,
                cursorWidth: 1.5,
                cursorColor: ColorsFrave.primary,
                style: GoogleFonts.inter(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                   hintText: 'Type something...'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}