import 'package:flutter/material.dart';
import '../models/video.dart';
import '../models/user.dart';
import '../widgets/video_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  List<Video> _videos = [];

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  void _loadVideos() {
    // Mock data - in a real app, this would come from an API
    final mockUsers = [
      User(
        id: '1',
        username: 'craig_love',
        displayName: 'Craig Love',
        profileImageUrl: null,
        followersCount: 1250,
        followingCount: 89,
        likesCount: 45000,
        isVerified: false,
      ),
      User(
        id: '2',
        username: 'karennne',
        displayName: 'Karen',
        profileImageUrl: null,
        followersCount: 8900,
        followingCount: 234,
        likesCount: 120000,
        isVerified: true,
      ),
      User(
        id: '3',
        username: 'martini_rond',
        displayName: 'Martini Rond',
        profileImageUrl: null,
        followersCount: 5600,
        followingCount: 156,
        likesCount: 78000,
        isVerified: false,
      ),
    ];

    _videos = [
      Video(
        id: '1',
        videoUrl: 'https://example.com/video1.mp4',
        user: mockUsers[0],
        caption: 'The most satisfying Job #fyp #satisfying #roadmarking',
        songName: 'The Round',
        songArtist: 'Roddy Roundicch',
        likesCount: 328700,
        commentsCount: 578,
        sharesCount: 1200,
      ),
      Video(
        id: '2',
        videoUrl: 'https://example.com/video2.mp4',
        user: mockUsers[1],
        caption: 'Beautiful sunset vibes #avicii #wflove',
        songName: 'Waiting For Love',
        songArtist: 'Avicii',
        likesCount: 4445,
        commentsCount: 64,
        sharesCount: 89,
      ),
      Video(
        id: '3',
        videoUrl: 'https://example.com/video3.mp4',
        user: mockUsers[2],
        caption: 'Amazing performance tonight! #music #live',
        songName: 'Original Sound',
        songArtist: 'Martini Rond',
        likesCount: 15600,
        commentsCount: 234,
        sharesCount: 456,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Video PageView
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _videos.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return VideoCard(
                video: _videos[index],
                isVisible: _currentIndex == index,
                onLike: () => _onLikeVideo(_videos[index]),
                onComment: () => _onCommentVideo(_videos[index]),
                onShare: () => _onShareVideo(_videos[index]),
                onFollow: () => _onFollowUser(_videos[index].user),
              );
            },
          ),

          // Top navigation
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 50, bottom: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side - Following/For You tabs
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildTab('Following', false),
                        const SizedBox(width: 32),
                        _buildTab('For You', true),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 20,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
      ],
    );
  }

  void _onLikeVideo(Video video) {
    setState(() {
      final index = _videos.indexWhere((v) => v.id == video.id);
      if (index != -1) {
        final updatedVideo = video.copyWith(
          likesCount:
              video.isLiked ? video.likesCount - 1 : video.likesCount + 1,
          isLiked: !video.isLiked,
        );
        _videos[index] = updatedVideo;
      }
    });
  }

  void _onCommentVideo(Video video) {
    // TODO: Implement comment functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Comments for: ${video.caption}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onShareVideo(Video video) {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${video.caption}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onFollowUser(User user) {
    // TODO: Implement follow functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${user.isFollowing ? 'Unfollowed' : 'Followed'} @${user.username}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
