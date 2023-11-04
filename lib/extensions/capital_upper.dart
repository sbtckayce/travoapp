extension CaptitalUpper on String{
  String capitalizeTheFirstLetter(){
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    
  }
  String capitalize(){
     return '${this[0].toUpperCase()}${substring(1)}';
  }
}