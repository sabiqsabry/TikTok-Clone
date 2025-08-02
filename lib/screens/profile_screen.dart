import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/video.dart';
import '../widgets/profile_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  User? _currentUser;
  List<Video> _userVideos = [];
  List<Video> _likedVideos = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadUserData();
  }

  void _loadUserData() {
    // Mock user data
    _currentUser = User(
      id: 'current_user',
      username: 'jacob_w',
      displayName: 'Jacob West',
      profileImageUrl: null,
      bio: 'Flutter developer and TikTok enthusiast',
      followersCount: 38,
      followingCount: 14,
      likesCount: 91,
      isVerified: false,
    );

    // Mock videos
    _userVideos = [
      Video(
        id: 'user_video_1',
        videoUrl: 'https://example.com/user_video1.mp4',
        user: _currentUser!,
        caption: 'My first TikTok video! #flutter #coding',
        likesCount: 45,
        commentsCount: 12,
        sharesCount: 8,
      ),
      Video(
        id: 'user_video_2',
        videoUrl: 'https://example.com/user_video2.mp4',
        user: _currentUser!,
        caption: 'Amazing sunset today #nature #beautiful',
        likesCount: 23,
        commentsCount: 5,
        sharesCount: 3,
      ),
    ];

    _likedVideos = [
      Video(
        id: 'liked_video_1',
        videoUrl: 'https://example.com/liked_video1.mp4',
        user: User(
          id: 'other_user_1',
          username: 'creative_user',
          displayName: 'Creative User',
        ),
        caption: 'Amazing creativity! #art #creative',
        likesCount: 1200,
        commentsCount: 89,
        sharesCount: 234,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.person_add, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              _currentUser!.displayName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              // TODO: Show more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile Header
          ProfileHeader(
            user: _currentUser!,
            onEditProfile: _onEditProfile,
            onBookmark: _onBookmark,
          ),

          // Tab Bar
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(
                  icon: Icon(Icons.grid_on),
                  text: '',
                ),
                Tab(
                  icon: Icon(Icons.favorite_border),
                  text: '',
                ),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVideoGrid(_userVideos),
                _buildVideoGrid(_likedVideos),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoGrid(List<Video> videos) {
    if (videos.isEmpty) {
      return _buildEmptyState();
    }

    return GridView.builder(
      padding: const EdgeInsets.all(1),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      itemCount: videos.length + 1, // +1 for the "create video" button
      itemBuilder: (context, index) {
        if (index == videos.length) {
          return _buildCreateVideoButton();
        }
        return _buildVideoThumbnail(videos[index]);
      },
    );
  }

  Widget _buildVideoThumbnail(Video video) {
    return Container(
      color: Colors.grey[300],
      child: Stack(
        children: [
          // Placeholder for video thumbnail
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[400],
            child: const Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 40,
            ),
          ),
          // Play button overlay
          Positioned(
            bottom: 8,
            left: 8,
            child: Row(
              children: [
                const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  _formatCount(video.likesCount),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateVideoButton() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.grey,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Tap to create\na new video',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.video_library_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No videos yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start creating amazing content!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  void _onEditProfile() {
    // TODO: Navigate to edit profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit profile functionality coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onBookmark() {
    // TODO: Navigate to bookmarks/saved videos
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bookmarks functionality coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
