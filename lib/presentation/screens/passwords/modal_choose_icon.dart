import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/data/icons/icons.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

void modalChooseIconLogo(BuildContext context) {

  final TextEditingController searchController = TextEditingController();
  final generalBloc = BlocProvider.of<GeneralBloc>(context);
  final passwordBloc = BlocProvider.of<PasswordBloc>(context);

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black54,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => FractionallySizedBox(
      heightFactor: .97,
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextCustom(
                    text: 'Select a logo',
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                  IconButton(
                    icon: const Icon(FontAwesomeIcons.xmark, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: TextFormField(
                  controller: searchController,
                  style: GoogleFonts.poppins(fontSize: 15.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                  cursorColor: ColorsFrave.primary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 17.0, color: Colors.grey),
                    hintStyle: GoogleFonts.poppins(color: Colors.grey)
                  ),
                  onChanged: (value) {
                    generalBloc.add(ClearSearchListLogoEvent());
                    if(value.isNotEmpty){
                      generalBloc.add(SearchLogoEvent(value));
                    }
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: BlocBuilder<GeneralBloc, GeneralState>(
                  builder: (context, state) {

                    if(searchController.text.trim().isEmpty && state.listSearchIcons.isEmpty){

                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          mainAxisExtent: 60
                        ), 
                        itemCount: IconsLogo.listIconsLogo.length,
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () { 
                              passwordBloc.add(SelectIconLogoPasswordEvent(IconsLogo.listIconsLogo[i]));
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: LimitedBox(
                                maxHeight: 60,
                                maxWidth: 60,
                                child: SvgPicture.asset(IconsLogo.listIconsLogo[i].path, height: 60, width: 60,)
                              ),
                            ),
                          );
                        },
                      );

                    }

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 70
                      ), 
                      itemCount: state.listSearchIcons.length,
                      itemBuilder: (_, i) {
                        return GestureDetector(
                          onTap: () {
                            passwordBloc.add(SelectIconLogoPasswordEvent(state.listSearchIcons[i]));
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: SvgPicture.asset(state.listSearchIcons[i].path),
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
    ),
  ).then((_){
    searchController.clear();
    generalBloc.add(ClearSearchListLogoEvent());
  });


}