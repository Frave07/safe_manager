import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_manager/data/icons/icons.dart';

part 'general_event.dart';
part 'general_state.dart';

class GeneralBloc extends Bloc<GeneralEvent, GeneralState> {

  GeneralBloc() : super(const GeneralState()) {

    on<SearchLogoEvent>(_searchLogo);
    on<ClearSearchListLogoEvent>(_clearSearchListLogo);
    on<IsShowPasswordVaultEvent>(_isShowPasswordVault);

  }

  
  Future<void> _searchLogo(SearchLogoEvent event, Emitter<GeneralState> emit) async {

    List<IconsLogo> listnew = [];

    listnew = IconsLogo.listIconsLogo.where((e) => e.name.toLowerCase().contains(event.text.toLowerCase())).toList();
  
    return emit(state.copyWith(listSearchIcons: listnew));
  }


  Future<void> _clearSearchListLogo(ClearSearchListLogoEvent event, Emitter<GeneralState> emit) async {
  
    return emit(state.copyWith(listSearchIcons: const []));
  
  }


  Future<void> _isShowPasswordVault(IsShowPasswordVaultEvent event, Emitter<GeneralState> emit) async {
  
    return emit(state.copyWith(isShowPasswordVault: event.isShow));
  
  }




}
