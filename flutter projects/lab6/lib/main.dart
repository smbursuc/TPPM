import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(ShoppingListApp());

class ShoppingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping List App',
      home: HomePage(),
    );
  }
}

class ShoppingList extends StatefulWidget {
  @override
  _ShoppingListState createState() => _ShoppingListState();
}

List<Map<String,String>> _items = [];
List<Map<String,String>> favorites = [];
var colors = [Colors.red,Colors.blue,Colors.green,Colors.purple];
int randomValue = 0;

class _ShoppingListState extends State<ShoppingList> {
  late Timer _timer;

  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
        Duration(seconds: 1),
            (t) => setState(() {
          randomValue = Random().nextInt(4);
        }));
  }

  void dispose() {
    _timer.cancel(); // cancel the timer
    super.dispose();
  }

  TextEditingController _itemName = TextEditingController();
  TextEditingController _categoryName = TextEditingController();

  void _addItem() {
    setState(() {
      String newItem = _itemName.text.trim();
      String category = _categoryName.text.trim();
      if (newItem.isNotEmpty && category.isNotEmpty) {
        var item = new Map<String,String>();
        item.addEntries([MapEntry(newItem, category)]);
        _items.add(item);
        _itemName.clear();
        _categoryName.clear();
      }
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  void _addFavorite(int index) {
    setState(() {
      favorites.add(_items[index]);
    });
  }


  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shopping List'),
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FavoritePage()),
                    );
                  },
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: _itemName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a shopping item',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  controller: _categoryName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter category',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: ElevatedButton(
                  child: const Text("Add item"),
                  onPressed: _addItem,
                )
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: _items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomPaint(
                      painter: TrianglePainter(color: colors[randomValue]),
                      child: ListTile(
                        title: Text(_items[index].keys.first),
                        subtitle: Text(_items[index].values.first),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _deleteItem(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.favorite),
                              onPressed: () => _addFavorite(index),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShoppingList()),
            );
          },
          child: const Text('Go to shopping!'),
        ),
      ),
    );
  }
}

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  late Timer _timer;

  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(
        Duration(seconds: 1),
            (t) => setState(() {
          randomValue = Random().nextInt(4);
        }));
  }

  void dispose() {
    _timer.cancel(); // cancel the timer
    super.dispose();
  }

  void _deleteFavorite(int index) {
    setState(() {
      favorites.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Favorites'),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: favorites.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return CustomPaint(
                  painter: TrianglePainter(color: colors[randomValue]),
                  child: ListTile(
                    title: Text(favorites[index].keys.first),
                    subtitle: Text(favorites[index].values.first),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteFavorite(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class SquarePainter extends CustomPainter {
  @override
  void DrawSmileyFace(Offset pos, Canvas canvas) {
    var paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, 100, paint);
    canvas.drawCircle(pos, 100, paint);
    paint
    ..color = Colors.black
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 5
    ..style = PaintingStyle.stroke;
    canvas.drawCircle(pos, 100, paint);
    canvas.drawCircle(Offset(pos.dx - 33, pos.dy - 10), 20, paint);
    canvas.drawCircle(Offset(pos.dx + 33, pos.dy - 10), 20, paint);
    canvas.drawArc(Rect.fromCenter(center: Offset(pos.dx, pos.dy + 30),
        width: 100, height: 80), 3.14, -3.14,false,paint);
  }

  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    DrawSmileyFace(center, canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({this.color = Colors.black});


  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width/2-size.width/10, size.height/4)
      ..lineTo(size.width/2+size.width/10, size.height/4)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

