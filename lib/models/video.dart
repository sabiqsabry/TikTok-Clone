import 'user.dart';

class Video {
  final String id;
  final String videoUrl;
  final String? thumbnailUrl;
  final User user;
  final String caption;
  final String? songName;
  final String? songArtist;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final bool isLiked;
  final bool isFollowing;
  final DateTime createdAt;

  Video({
    required this.id,
    required this.videoUrl,
    this.thumbnailUrl,
    required this.user,
    required this.caption,
    this.songName,
    this.songArtist,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.isLiked = false,
    this.isFollowing = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Video copyWith({
    String? id,
    String? videoUrl,
    String? thumbnailUrl,
    User? user,
    String? caption,
    String? songName,
    String? songArtist,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    bool? isLiked,
    bool? isFollowing,
    DateTime? createdAt,
  }) {
    return Video(
      id: id ?? this.id,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      user: user ?? this.user,
      caption: caption ?? this.caption,
      songName: songName ?? this.songName,
      songArtist: songArtist ?? this.songArtist,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      isLiked: isLiked ?? this.isLiked,
      isFollowing: isFollowing ?? this.isFollowing,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
