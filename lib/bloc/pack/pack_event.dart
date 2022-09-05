part of 'pack_bloc.dart';

abstract class PackEvent extends Equatable {
  const PackEvent();

  @override
  List<Object> get props => [];
}

class TogglePackMorale extends PackEvent {}

class TogglePackGroup extends PackEvent {}

class TogglePackBrother extends PackEvent {}

class TogglePackSupport extends PackEvent {}

class TogglePackDoubleSupport extends PackEvent {}
