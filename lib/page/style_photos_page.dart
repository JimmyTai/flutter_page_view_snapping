import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../model/photo_style.dart';

class StylePhotosPageArgs {
  final List<String> imageUrls;
  const StylePhotosPageArgs({@required this.imageUrls});
}

class StylePhotosPage extends StatefulWidget {
  static const String route = '/style-photos';

  const StylePhotosPage({Key key}) : super(key: key);

  @override
  _StylePhotosPageState createState() => _StylePhotosPageState();
}

class _StylePhotosPageState extends State<StylePhotosPage> {
  List<String> _imageUrls = [];
  PhotoStyle _selectedStyle = PhotoStyle.solid;

  bool _isSelectedStyle(int index) => PhotoStyle.values[index].type == _selectedStyle.type;

  void _selectStyle(int index) {
    setState(() {
      _selectedStyle = PhotoStyle.values[index];
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final arguments = ModalRoute.of(context).settings.arguments;
    if (arguments != null && arguments is StylePhotosPageArgs) {
      _imageUrls = arguments.imageUrls;
    } else {
      Navigator.of(context).pop();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Style Photos Page'),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 80),
          child: Container(
            height: 80,
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _selectStyle(index);
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (_isSelectedStyle(index))
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.pinkAccent.withOpacity(0.15),
                                    Colors.pinkAccent.withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.filter,
                              size: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                PhotoStyle.values[index].name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: PhotoStyle.values.length,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: SizedBox(
            // you may want to use an aspect ratio here for tablet support
            height: MediaQuery.of(context).size.width * 0.8,
            child: PageView.builder(
              // store this controller in a State to save the carousel scroll position
              controller: PageController(viewportFraction: 0.8),
              itemBuilder: (context, itemIndex) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildCarouselItem(context, itemIndex),
                );
              },
              itemCount: _imageUrls.length,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselItem(BuildContext context, int itemIndex) {
    if (_selectedStyle.type == PhotoStyle.solid.type) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 8),
        ),
        child: Image.network(_imageUrls[itemIndex], fit: BoxFit.cover),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000),
                spreadRadius: 5.0,
                blurRadius: 5.0,
                // offset: Offset(1, 1),
              ),
            ],
          ),
          child: Image.network(_imageUrls[itemIndex], fit: BoxFit.cover),
        ),
      );
    }
  }
}
