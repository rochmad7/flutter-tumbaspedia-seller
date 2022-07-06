part of '../cubit/photo_cubit.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoaded extends PhotoState {
  final List<Photo> photos;

  PhotoLoaded({this.photos});
}

class PhotosByProductLoaded extends PhotoState {
  final List<Photo> photos;

  PhotosByProductLoaded({this.photos});
}

class PhotoLoadingFailed extends PhotoState {
  final String message;

  PhotoLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}

class PhotoAdded extends PhotoState {
  // final List<Photo> photos;
  final String message;

  PhotoAdded(this.message);

  @override
  List<Object> get props => [message];
}

class PhotoAddedFailed extends PhotoState {
  final String message;
  final Map<String, dynamic> error;

  PhotoAddedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}

class PhotoDeleted extends PhotoState {
  final String message;

  PhotoDeleted(this.message);

  @override
  List<Object> get props => [message];
}

class PhotoDeletedFailed extends PhotoState {
  final String message;
  final Map<String, dynamic> error;

  PhotoDeletedFailed(this.message, this.error);

  @override
  List<Object> get props => [message, error];
}
