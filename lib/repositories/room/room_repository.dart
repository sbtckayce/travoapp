import 'package:cloud_firestore/cloud_firestore.dart';
import '/repositories/room/base_room_repository.dart';
import '/models/room/room_model.dart';
import '/utils/variable_const.dart';

class RoomRepository extends BaseRoomRepository{
  final FirebaseFirestore _firebaseFirestore;

  RoomRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<RoomModel>> getAllRoomByHotel(String hotelId) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.roomCollection)
          .where('hotel', isEqualTo: hotelId)
          .snapshots()
          .map((event) {
        List<RoomModel> list = [];
        for (var doc in event.docs) {
          list.add(RoomModel.fromMap(doc.reference.id, doc.data()));
        }
        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Stream<RoomModel> getRoomWhereRoomId(String roomId) {
    try{
      return _firebaseFirestore.collection(VariableConst.roomCollection).doc(roomId).snapshots().map((event) {
        return RoomModel.fromMap(roomId, event.data() as Map<String,dynamic>);
      });
    }catch(e){
      throw Exception(e);
    }
  }
}
