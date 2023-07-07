part of 'pack_bloc.dart';

abstract class PackEvent extends Equatable {
  const PackEvent();

  @override
  List<Object> get props => [];
}

class TogglePackHorn extends PackEvent {}

class TogglePackMuster extends PackEvent {}

class TogglePackTightBond extends PackEvent {}

class TogglePackMoral extends PackEvent {}

class TogglePackDoubleMoral extends PackEvent {}
