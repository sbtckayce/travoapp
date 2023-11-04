part of 'room_cubit.dart';

 class RoomState  extends Equatable{
  @override

  List<Object?> get props => [];
 }

class RoomLoading extends RoomState {}
class RoomListLoaded extends RoomState {
  final List<RoomModel> rooms;

  RoomListLoaded({required this.rooms});
   @override

  List<Object?> get props => [rooms];
}
class RoomLoaded extends RoomState {
  final RoomModel room;

  RoomLoaded({required this.room});
   @override

  List<Object?> get props => [room];
}