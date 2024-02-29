// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

class MemoryGame {
  MemoryGame() {
    randomizeData();
  }
  List<DataItem> data = []; // the data that will show on screen
  void randomizeData() {
    List<int> data2 = [0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7];
    Random rand = Random();
    List<int> traversedIndecies = [];
    List<DataItem> newData = [];
    int index;
    for (int i = 0; i < data2.length; i++) {
      index = rand.nextInt(16);
      while (traversedIndecies.contains(index)) {
        index = rand.nextInt(16);
      }
      traversedIndecies.add(index);
      newData.add(DataItem(number: data2[index], isClicked: false));
    }
    data = newData;
  }
}

class DataItem {
  int number;
  bool isClicked;
  DataItem({
    required this.number,
    required this.isClicked,
  });
}
