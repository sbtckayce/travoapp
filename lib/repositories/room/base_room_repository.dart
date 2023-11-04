import '../../models/room/room_model.dart';

abstract class BaseRoomRepository{
   Stream<List<RoomModel>> getAllRoomByHotel(String hotelId);

   Stream<RoomModel> getRoomWhereRoomId(String roomId);

   
}