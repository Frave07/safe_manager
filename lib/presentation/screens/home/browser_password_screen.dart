import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/home/components/card_password.dart';
import 'package:safe_manager/presentation/screens/passwords/modal_add_password_home.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class BrowserPasswordScreen extends StatefulWidget {

  const BrowserPasswordScreen({Key? key}) : super(key: key);

  @override
  State<BrowserPasswordScreen> createState() => _BrowserPasswordScreenState();
}

class _BrowserPasswordScreenState extends State<BrowserPasswordScreen> {

  late TextEditingController _searchController;
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Browser',
          isTitle: true,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            homeBloc.add(ClearSearchBrowserPasswordEvent());
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19.0)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: TextFormField(
                  controller: _searchController,
                  style: GoogleFonts.poppins(fontSize: 15.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                  cursorColor: ColorsFrave.primary,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search password',
                    prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 17.0, color: Colors.grey),
                    hintStyle: GoogleFonts.poppins(color: Colors.grey)
                  ),
                  onChanged: (value) {
                    homeBloc.add(ClearSearchBrowserPasswordEvent());
                    if(value.isNotEmpty){
                      homeBloc.add(SearchBrowserPasswordEvent(value));
                    }
                  },
                ),
              ),
              const SizedBox(height: 24.0),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {

                    if(state.passwordBrowser.isEmpty){
                      return const Center(
                        child: TextCustom(
                          text: 'Without password',
                          isTitle: true,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }

                    return _searchController.text.trim().isEmpty && state.searchPasswordBrowers.isEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.passwordBrowser.length,
                        itemBuilder: (context, i) {
                          return CardPassword(password: state.passwordBrowser[i], index: i);
                        },
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.searchPasswordBrowers.length,
                        itemBuilder: (context, i) {
                          return CardPassword(password: state.searchPasswordBrowers[i], index: i);
                        },
                      );
                  },
                )
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add-password',
        backgroundColor: ColorsFrave.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0)
        ),
        child: const Icon(FontAwesomeIcons.plus),
        onPressed: (){
          modalAddPasswordHome(context);
        }
      ),
    );
  }
}