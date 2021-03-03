import 'package:flutter/material.dart';
import 'package:flutter_app/page/style_photos_page.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _imageUrls =
      List.generate(100, (index) => 'https://source.unsplash.com/collection/$index/300x300');
  final List<int> _selectedIndex = [];

  int get _selectedCount => _selectedIndex.length;

  void _selectImage(int index) {
    setState(() {
      if (_selectedIndex.contains(index)) {
        _selectedIndex.remove(index);
      } else {
        _selectedIndex.add(index);
      }
    });
  }

  bool _isSelected(int index) => _selectedIndex.contains(index);

  Future<void> _navigateToStylePhotosPage() async {
    await Navigator.of(context).pushNamed(
      StylePhotosPage.route,
      arguments: StylePhotosPageArgs(
        imageUrls: _selectedIndex.map((index) => _imageUrls[index]).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 1.5,
                  crossAxisSpacing: 1.5,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _selectImage(index);
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          _imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                        if (_isSelected(index))
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.pinkAccent.withOpacity(0.3),
                              border: Border.all(
                                color: Colors.pinkAccent.withOpacity(0.4),
                                width: 8,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                itemCount: _imageUrls.length,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Row(
                children: [
                  Text(
                    '$_selectedCount files selected',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.all(16),
              child: RaisedButton(
                onPressed: () {
                  _navigateToStylePhotosPage();
                },
                color: Colors.pinkAccent,
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
