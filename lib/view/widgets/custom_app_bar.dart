import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/strings.dart';
import '../dialogs/SearchDialog.dart';
 // Make sure to import your dialog

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onSearch;

  const CustomAppBar({super.key, this.onSearch});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final List<String> _recentSearches = [];
  final TextEditingController _controller = TextEditingController();

  void _addSearchItem(String search) {
    if (search.isNotEmpty && !_recentSearches.contains(search)) {
      setState(() {
        _recentSearches.insert(0, search);
      });
    }
    _controller.text = search;
    if (widget.onSearch != null) {
      widget.onSearch!(search);
    }
  }

  Future<void> _openSearchDialog() async {
    final result = await showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Search',
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter,
          child: SearchDialog(
            initialHistory: _recentSearches,
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedValue = Curves.easeInOut.transform(animation.value);
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );

    if (result != null && result.isNotEmpty) {
      _addSearchItem(result);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Image.asset('assets/ziya_logo.png', width: 40),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: _openSearchDialog,
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 20, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              _controller.text.isEmpty
                                  ? AppStrings.searchHint
                                  : _controller.text,
                              style: TextStyle(
                                fontSize: 16,
                                color: _controller.text.isEmpty ? Colors.grey : Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Stack(
                  children: [
                    const Icon(Icons.notifications, color: Colors.blue, size: 28),
                    Positioned(
                      right: 0,
                      top: 2,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 1),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(width: 12),
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    'https://media.gettyimages.com/id/1317804578/photo/one-businesswoman-headshot-smiling-at-the-camera.jpg?s=612x612&w=gi&k=20&c=tFkDOWmEyqXQmUHNxkuR5TsmRVLi5VZXYm3mVsjee0E=',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
