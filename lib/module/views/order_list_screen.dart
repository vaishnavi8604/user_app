import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<dynamic> _allItems = [];
  final List<dynamic> _filteredItems = [];

  int _page = 0;
  final int _limit = 20;
  bool _isLoading = false;
  bool _hasMore = true;

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    _fetchItems();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
          !_isLoading &&
          _hasMore) {
        _fetchItems();
      }
    });
  }

  Future<void> _fetchItems() async {
    setState(() => _isLoading = true);

    final url = "https://dummyjson.com/products?limit=$_limit&skip=${_page * _limit}&select=title,price,meta";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      List<dynamic> newItems = json['products'];

      if (newItems.isEmpty) {
        setState(() => _hasMore = false);
      } else {
        _allItems.addAll(newItems);
        _applyFilter();
        _page++;
      }
    }

    setState(() => _isLoading = false);
  }

  void _applyFilter() {
    _filteredItems.clear();

    if (selectedDate == null) {
      _filteredItems.addAll(_allItems);
    } else {
      _filteredItems.addAll(_allItems.where((item) {
        final createdAt = DateTime.parse(item['meta']['createdAt']);
        return createdAt.year == selectedDate!.year &&
            createdAt.month == selectedDate!.month &&
            createdAt.day == selectedDate!.day;
      }));
    }
    setState(() {});
  }

  void _onDateSelected(DateTime? date) {
    if (date != null) {
      setState(() => selectedDate = date);
      _applyFilter();
    }
  }

  void _clearDateFilter() {
    setState(() {
      selectedDate = null;
    });
    _applyFilter();
  }

  void _share() {
    print("Share tapped");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Preparing to share..."),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.lightBlue,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );
                        _onDateSelected(picked);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      child: Row(
                        children: [
                          Text(
                            selectedDate != null
                                ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                                : 'Select date',
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  if (selectedDate != null)
                    TextButton(
                      onPressed: _clearDateFilter,
                      child: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: _share,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.share, color: Colors.white, size: 18),
                            SizedBox(width: 6),
                            Text(
                              "Share",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _filteredItems.isEmpty && !_isLoading
                  ? const Center(
                child: Text(
                  'No data found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                controller: _scrollController,
                itemCount: _filteredItems.length + (_hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < _filteredItems.length) {
                    final item = _filteredItems[index];
                    final createdAt = DateTime.parse(item['meta']['createdAt']);
                    return ListTile(
                      title: Text(item['title']),
                      subtitle: Text('Price: \$${item['price']}'),
                      trailing: Text(DateFormat('yyyy-MM-dd').format(createdAt)),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
