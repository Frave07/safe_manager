part of 'general_bloc.dart';

@immutable
class GeneralState extends Equatable {

  final List<IconsLogo> listSearchIcons;
  final bool isShowPasswordVault;

  const GeneralState({
    this.listSearchIcons = const [],
    this.isShowPasswordVault = true,
  });

  GeneralState copyWith({
    List<IconsLogo>? listSearchIcons,
    bool? isShowPasswordVault,
  }) => GeneralState(
    listSearchIcons: listSearchIcons ?? this.listSearchIcons,
    isShowPasswordVault: isShowPasswordVault ?? this.isShowPasswordVault,
  );
  
  @override
  List<Object> get props => [
    listSearchIcons,
    isShowPasswordVault,
  ];
  
}
