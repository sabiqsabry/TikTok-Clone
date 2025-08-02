import 'package:flutter/material.dart';
import '../models/video.dart';

class VideoCard extends StatefulWidget {
  final Video video;
  final bool isVisible;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onFollow;

  const VideoCard({
    super.key,
    required this.video,
    required this.isVisible,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onFollow,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  bool _isLiked = false;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.video.isLiked;
    _isFollowing = widget.video.isFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          // Video background (placeholder for now)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[900],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Video: ${widget.video.caption}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Right side action buttons
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                _buildActionButton(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  label: _formatCount(widget.video.likesCount),
                  color: _isLiked ? Colors.red : Colors.white,
                  onTap: () {
                    setState(() {
                      _isLiked = !_isLiked;
                    });
                    widget.onLike?.call();
                  },
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  icon: Icons.comment,
                  label: _formatCount(widget.video.commentsCount),
                  onTap: widget.onComment,
                ),
                const SizedBox(height: 20),
                _buildActionButton(
                  icon: Icons.share,
                  label: _formatCount(widget.video.sharesCount),
                  onTap: widget.onShare,
                ),
                const SizedBox(height: 20),
                _buildProfileButton(),
                const SizedBox(height: 20),
                _buildMusicButton(),
              ],
            ),
          ),

          // Bottom left content
          Positioned(
            left: 16,
            bottom: 100,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '@${widget.video.user.username}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.video.user.isVerified)
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Icon(
                          Icons.verified,
                          color: Colors.blue,
                          size: 16,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.video.caption,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                if (widget.video.songName != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.music_note,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${widget.video.songName} - ${widget.video.songArtist ?? ''}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    Color? color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            icon,
            color: color ?? Colors.white,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isFollowing = !_isFollowing;
        });
        widget.onFollow?.call();
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: _isFollowing ? Colors.red : Colors.white,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.grey[600],
              child: widget.video.user.profileImageUrl != null
                  ? ClipOval(
                      child: Image.network(
                        widget.video.user.profileImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            color: Colors.white,
                          );
                        },
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Icon(
            _isFollowing ? Icons.remove : Icons.add,
            color: _isFollowing ? Colors.red : Colors.white,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildMusicButton() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Icon(
        Icons.music_note,
        color: Colors.white,
        size: 24,
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
}
