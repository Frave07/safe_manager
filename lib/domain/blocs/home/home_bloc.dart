import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:safe_manager/domain/models/card_model/card_model.dart';
import 'package:safe_manager/domain/models/password_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {


  HomeBloc() : super(const HomeState()) {

    on<GetPasswordAndStadisticHomeEvent>(_getPasswordAndStadisticHome);
    on<SearchBrowserPasswordEvent>(_searchBrowserPassword);
    on<SearchAppPasswordEvent>(_searchAppPassword);
    on<ClearSearchBrowserPasswordEvent>(_clearSearchBrowserPassword);
    on<ClearSearchAppPasswordEvent>(_clearSearchAppPassword);
    on<GetCardsHomeEvent>(_getCardsHome);

  }


  Future<void> _getPasswordAndStadisticHome(GetPasswordAndStadisticHomeEvent event, Emitter<HomeState> emit) async {

    emit(state.copyWith(passwordRecently: const []));
  
    final box = Hive.box<PasswordModel>('encrypt-password-fraved');

    final cardsBox = Hive.box<CardModel>('encrypt-card-wallet-fraved');

    final passwords = box.values.toList();

    final cards = cardsBox.values.toList();

    final browser = passwords.where((e) => e.type == 1).toList();
    final app = passwords.where((e) => e.type == 2).toList();
  
    return emit(state.copyWith(
      passwordRecently: passwords.reversed.toList(),
      passwordApp: app,
      passwordBrowser: browser,
      cardStadistcs: cards.length
    ));
  }

  
  Future<void> _searchBrowserPassword(SearchBrowserPasswordEvent event, Emitter<HomeState> emit) async {
  
    final pass = state.passwordBrowser.where((e) => e.nickname.toLowerCase().contains(event.text)).toList();

    return emit(state.copyWith(searchPasswordBrowers: pass));
  }


  Future<void> _searchAppPassword(SearchAppPasswordEvent event, Emitter<HomeState> emit) async {
  
    final pass = state.passwordApp.where((e) => e.nickname.toLowerCase().contains(event.text)).toList();

    return emit(state.copyWith(searchPasswordApp: pass));
  }


  Future<void> _clearSearchBrowserPassword(ClearSearchBrowserPasswordEvent event, Emitter<HomeState> emit) async {
  
    return emit(state.copyWith(searchPasswordBrowers: const []));
  }


  Future<void> _clearSearchAppPassword(ClearSearchAppPasswordEvent event, Emitter<HomeState> emit) async {
  
    return emit(state.copyWith(searchPasswordApp: const []));
  }


  Future<void> _getCardsHome(GetCardsHomeEvent event, Emitter<HomeState> emit) async {
  
    emit(state.copyWith(cards: const []));
  
    final box = Hive.box<CardModel>('encrypt-card-wallet-fraved');

    final cards = box.values.toList();
  
    return emit(state.copyWith(
      cards: cards.reversed.toList(),
    ));
  }
  


}
