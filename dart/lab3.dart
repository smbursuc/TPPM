class Queue<T> {
  List<T> _items = [];

  void push(T item) {
    _items.add(item);
  }

  T pop() {
    if (_items.isEmpty) throw Exception("Queue is empty");
    return _items.removeAt(0);
  }

  T back() {
    return _items.last;
  }

  T front() {
    return _items.first;
  }

  bool isEmpty() {
    return _items.isEmpty;
  }

  String toString() {
    return _items.toString();
  }
}

class Client {
  final String _name;
  double _PurchasesAmount = 0;

  double get() {
    return _PurchasesAmount;
  }

  void add(double amount) {
    _PurchasesAmount += amount;
  }

  Client(String name) : _name = name {}
}

class LoyalClient extends Client {
  LoyalClient(String name) : super(name) {}

  double getLC() {
    return _PurchasesAmount;
  }

  void discount() {
    _PurchasesAmount = super._PurchasesAmount * 0.9;
  }
}

void main() {
  Queue q = new Queue<int>();
  q.push(1);
  q.push(2);
  q.push(3);
  q.pop();
  print(q.back());
  print(q.front());
  print(q.isEmpty());
  print(q.toString());
  print("");
  Client c = new Client("John");
  c.add(100);
  LoyalClient lc = new LoyalClient("Jerry");
  lc.add(100);
  lc.discount();
  print(c.get());
  print(lc.getLC());
}
