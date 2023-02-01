import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/notepad/components/modal_option_note.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class AddNotepadScreen extends StatefulWidget {

  const AddNotepadScreen({Key? key}) : super(key: key);

  @override
  State<AddNotepadScreen> createState() => _AddNotepadScreenState();
}

class _AddNotepadScreenState extends State<AddNotepadScreen> {

  late final NotesBloc notesBloc;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    notesBloc = BlocProvider.of(context);
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
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
      builder: (_, state) => Scaffold(
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
                notesBloc.add(SaveNoteEvent(
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
                modalOptionNote(context, 0);
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