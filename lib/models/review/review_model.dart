import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable {
  final String uid;
  final String hotelId;
  final String roomId;
  final String userEmail;
  final DateTime ratedTime;
  final String comment;
  final List<String> photos;
  final double rating;
  const ReviewModel({
    this.uid ='',
    required this.hotelId,
    required this.roomId,
    required this.userEmail,
    required this.ratedTime,
    required this.comment,
    required this.photos,
    required this.rating,
  });

  ReviewModel copyWith({
    String? uid,
    String? hotelId,
    String? roomId,
    String? userEmail,
    DateTime? ratedTime,
    String? comment,
    List<String>? photos,
    double? rating,
  }) {
    return ReviewModel(
      uid: uid ?? this.uid,
      hotelId: hotelId ?? this.hotelId,
      roomId: roomId ?? this.roomId,
      userEmail: userEmail ?? this.userEmail,
      ratedTime: ratedTime ?? this.ratedTime,
      comment: comment ?? this.comment,
      photos: photos ?? this.photos,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hotel': hotelId,
      'room': roomId,
      'user': userEmail,
      'rated_time': ratedTime.toLocal(),
      'comment': comment,
      'photos': photos,
      'rating': rating
    };
  }

  factory ReviewModel.fromMap(String uid, Map<String, dynamic> map) {
    return ReviewModel(
      uid: uid,
        hotelId: map['hotel'] ?? '',
        roomId: map['room'] ?? '',
        userEmail: map['user'] ?? '',
        ratedTime: (map['rated_time'] as Timestamp).toDate(),
        comment: map['comment'] ?? '',
        photos: List<String>.from(
          (map['photos'] ?? []),
        ),
        rating: map['rating'] ?? '');
  }

  @override
  List<Object> get props {
    return [
      hotelId,
      roomId,
      userEmail,
      ratedTime,
      comment,
      photos,
      rating,
    ];
  }
}
