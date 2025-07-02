import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String)? onSearch;

  const CustomAppBar({super.key, this.onSearch});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _CustomAppBarState extends State<CustomAppBar> {
  String _searchText = '';
  final List<String> _recentSearches = [];
  final TextEditingController _controller = TextEditingController();
  bool _showSearchIcon = false;

  void _handleSearch(String value) {
    setState(() {
      _searchText = value;
      _showSearchIcon = value.isNotEmpty;
    });
    if (widget.onSearch != null) {
      widget.onSearch!(value);
    }
  }

  void _addSearchItem() {
    if (_searchText.isNotEmpty && !_recentSearches.contains(_searchText)) {
      setState(() {
        _recentSearches.insert(0, _searchText);
        _controller.clear();
        _searchText = '';
        _showSearchIcon = false;
      });
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
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            onChanged: _handleSearch,
                            decoration: const InputDecoration(
                              hintText: AppStrings.searchHint,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (_showSearchIcon)
                          IconButton(
                            icon: const Icon(Icons.search, size: 20),
                            onPressed: _addSearchItem,
                          ),
                      ],
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

        // Recent Searches Section
        if (_recentSearches.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 150), // Limit height
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Recent Searches',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _recentSearches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.history, size: 18),
                      title: Text(_recentSearches[index],
                          style: const TextStyle(fontSize: 14)),
                      onTap: () {
                        // You can trigger search on tap
                        if (widget.onSearch != null) {
                          widget.onSearch!(_recentSearches[index]);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }
}
