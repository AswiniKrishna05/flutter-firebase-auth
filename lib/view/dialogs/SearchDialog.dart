import 'package:flutter/material.dart';

class SearchDialog extends StatefulWidget {
  final List<String> initialHistory;

  const SearchDialog({Key? key, required this.initialHistory}) : super(key: key);

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _controller = TextEditingController();
  late List<String> _searchHistory;

  @override
  void initState() {
    super.initState();
    _searchHistory = List.from(widget.initialHistory);
  }

  void _submitSearch() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      Navigator.of(context).pop(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(left: 16,top: 40,right: 16,bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Back Button
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 8),
                // Search Box with Shadow
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                            ),
                            onSubmitted: (_) => _submitSearch(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Green Search Button
                Container(
                  height: 40, // ✅ Set desired height
                  width: 56,  // ✅ Set desired width
                  decoration: BoxDecoration(
                    color: const Color(0xFFB6E23A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 24), // ✅ Optional: Reduce icon size
                    padding: EdgeInsets.zero, // ✅ Remove default padding
                    constraints: const BoxConstraints(), // ✅ Remove size constraints from IconButton
                    onPressed: _submitSearch,
                  ),
                )

              ],
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Search History',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 8),
            if (_searchHistory.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: ListView.builder(
                  shrinkWrap: true, // ✅ Add this to take minimum height
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: _searchHistory.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -4), // 🔥 Reduce vertical spacing
                      contentPadding: EdgeInsets.zero, // 🔥 Remove default padding
                      leading: const Icon(Icons.history, size: 20),
                      title: Text(
                        _searchHistory[index],
                        style: const TextStyle(fontSize: 14), // Optional: You can reduce font size if you want it even tighter
                      ),
                      onTap: () {
                        Navigator.of(context).pop(_searchHistory[index]);
                      },
                    );

                  },
                ),
              ),

            if (_searchHistory.isEmpty)
              const Text(
                'No recent searches.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
