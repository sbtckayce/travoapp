import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

import '/models/room/room_model.dart';
import '/repositories/room/room_repository.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  final RoomRepository _roomRepository;
  RoomCubit(this._roomRepository) : super(RoomLoading());

  getAllRoomByHotel(String hotelId) {
    emit(RoomLoading());
    _roomRepository.getAllRoomByHotel(hotelId).listen((event) {
      emit(RoomListLoaded(rooms: event));
    });
  }
  getRoomWhereRoomId(String roomId){
    emit(RoomLoading());
    _roomRepository.getRoomWhereRoomId(roomId).listen((event) {
      emit(RoomLoaded(room: event));
    });
  }
}
