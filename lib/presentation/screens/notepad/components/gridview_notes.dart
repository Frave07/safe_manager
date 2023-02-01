import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/domain/models/notes_model/notes_model.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/notepad/edit_notepad_screen.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class GridviewNotes extends StatelessWidget {

  final List<NotesModel> notes;

  const GridviewNotes({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final notesBloc = BlocProvider.of<NotesBloc>(context);

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      itemCount: notes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 140,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () async {
            await Navigator.push(context, routeFade(page: EditNotepadScreen(note: notes[i], index: i)));
            notesBloc.add(GetListNotesEvent());
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(notes[i].color),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextCustom(
                      text: notes[i].title,
                      isTitle: true,
                      color: ColorsFrave.primary,
                      fontWeight: FontWeight.w500,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5.0),
                    TextCustom(
                      text: notes[i].description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                TextCustom(
                  text: DateFormat.yMMMMd('en_US').format(notes[i].date),
                  fontSize: 13,
                  textAlign: TextAlign.end,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}