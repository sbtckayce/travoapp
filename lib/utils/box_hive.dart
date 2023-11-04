import 'package:hive/hive.dart';
import '/models/place/place_model.dart';
import '/utils/variable_const.dart';

class BoxHive{

  static Box<PlaceModel> boxPlaces()=> Hive.box(VariableConst.boxPlace);
}