import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/data/note_colors/note_colors.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/screens/home/components/item_option_type.dart';

void modalOptionNote(BuildContext context, int index) {

  final notesBloc = BlocProvider.of<NotesBloc>(context);

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black54,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => Container(
      height: index > 0 ? 180 : 120,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white70
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                children: [
                  if(index > 0) ...[
                    ItemOptionType(
                      onTap: () {
                        Navigator.pop(context);
                        notesBloc.add(DeleteNoteEvent(index));
                      },
                      icon: const Icon(FontAwesomeIcons.trash, size: 16, color: Colors.red),
                      title: 'Delete',
                    ),
                    const SizedBox(height: 10.0),
                  ],            
                  SizedBox(
                    // color: Colors.red,
                    width: double.infinity,
                    height: 50,
                    child: BlocBuilder<NotesBloc, NotesState>(
                      builder: (context, state) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: NoteColors.listColorsNote.length,
                          itemBuilder: (_, i) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  notesBloc.add(ChangeBackgroundColorEvent(NoteColors.listColorsNote[i]));
                                  Navigator.pop(context);
                                },
                                child: CircleAvatar(
                                  backgroundColor: Color(NoteColors.listColorsNote[i].color),
                                  child: state.typeColor.uid == NoteColors.listColorsNote[i].uid
                                  ? const Icon(FontAwesomeIcons.check)
                                  : const SizedBox()
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );


}