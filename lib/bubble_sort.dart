import 'dart:math';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<double> arr;
  List<double> shuffledArr = [];
  double arraySize = 10;
  double speed = 10;

  @override
  void initState() {
    super.initState();
    _generateArray();
    shuffledArr = List.from(arr);
    shuffledArr.shuffle(Random());
  }

  void _generateArray() {
    arr = List.generate(
        arraySize.toInt(), (index) => Random().nextDouble() * 100);
    shuffledArr = List.from(arr);
    shuffledArr.shuffle(Random());
  }

  void shuffleValues() {
    setState(() {
      shuffledArr.shuffle(Random());
    });
  }

  late int selectedIndex = -1;
  late int comparingIndex = -1;

  Future<void> bubbleSort() async {
    int n = shuffledArr.length;
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (shuffledArr[j] > shuffledArr[j + 1]) {
          setState(() {
            selectedIndex = j;
            comparingIndex = j + 1;
          });
          await Future.delayed(Duration(milliseconds: speed.toInt()));
          double temp = shuffledArr[j];
          shuffledArr[j] = shuffledArr[j + 1];
          shuffledArr[j + 1] = temp;
        }
      }
    }
    setState(() {
      selectedIndex = -1;
      comparingIndex = -1;
    });
  }

  Future<void> selectionSort() async {
    int n = shuffledArr.length;
    for (int i = 0; i < n - 1; i++) {
      int minIndex = i;
      for (int j = i + 1; j < n; j++) {
        setState(() {
          selectedIndex = minIndex;
          comparingIndex = j;
        });
        await Future.delayed(Duration(milliseconds: speed.toInt()));

        if (shuffledArr[j] < shuffledArr[minIndex]) {
          setState(() {
            minIndex = j;
          });
        }
      }

      if (minIndex != i) {
        double temp = shuffledArr[i];
        shuffledArr[i] = shuffledArr[minIndex];
        shuffledArr[minIndex] = temp;
      }
    }
    setState(() {
      selectedIndex = -1;
      comparingIndex = -1;
    });
  }

  Future<void> insertionSort() async {
    int n = shuffledArr.length;
    for (int i = 1; i < n; i++) {
      double key = shuffledArr[i];
      int j = i - 1;

      setState(() {
        selectedIndex = i;
        comparingIndex = j;
      });
      await Future.delayed(Duration(milliseconds: speed.toInt()));

      while (j >= 0 && shuffledArr[j] > key) {
        setState(() {
          shuffledArr[j + 1] = shuffledArr[j];
        });
        await Future.delayed(Duration(milliseconds: speed.toInt()));
        j--;
      }

      setState(() {
        shuffledArr[j + 1] = key;
      });
    }
    setState(() {
      selectedIndex = -1;
      comparingIndex = -1;
    });
  }

  Future<void> quickSort(int low, int high) async {
    if (low < high) {
      int pi = await partition(low, high);

      await quickSort(low, pi - 1);
      await quickSort(pi + 1, high);
    }
  }

  Future<int> partition(int low, int high) async {
    double pivot = shuffledArr[high];
    int i = (low - 1);
    for (int j = low; j < high; j++) {
      setState(() {
        selectedIndex = i + 1;
        comparingIndex = j;
      });
      await Future.delayed(Duration(milliseconds: speed.toInt()));

      if (shuffledArr[j] < pivot) {
        i++;
        setState(() {
          double temp = shuffledArr[i];
          shuffledArr[i] = shuffledArr[j];
          shuffledArr[j] = temp;
        });
      }
    }

    setState(() {
      double temp = shuffledArr[i + 1];
      shuffledArr[i + 1] = shuffledArr[high];
      shuffledArr[high] = temp;
    });

    return i + 1;
  }

  Future<void> mergeSort(int left, int right) async {
    if (left < right) {
      int middle = left + (right - left) ~/ 2;

      await mergeSort(left, middle);
      await mergeSort(middle + 1, right);

      await merge(left, middle, right);
    }
  }

  Future<void> merge(int left, int middle, int right) async {
    int n1 = middle - left + 1;
    int n2 = right - middle;

    List<double> leftArr = List.generate(n1, (i) => shuffledArr[left + i]);
    List<double> rightArr =
        List.generate(n2, (i) => shuffledArr[middle + 1 + i]);

    int i = 0, j = 0;
    int k = left;

    while (i < n1 && j < n2) {
      setState(() {
        selectedIndex = k;
      });
      await Future.delayed(Duration(milliseconds: speed.toInt()));

      if (leftArr[i] <= rightArr[j]) {
        setState(() {
          shuffledArr[k] = leftArr[i];
        });
        i++;
      } else {
        setState(() {
          shuffledArr[k] = rightArr[j];
        });
        j++;
      }
      k++;
    }

    while (i < n1) {
      setState(() {
        selectedIndex = k;
        shuffledArr[k] = leftArr[i];
      });
      await Future.delayed(Duration(milliseconds: speed.toInt()));
      i++;
      k++;
    }

    while (j < n2) {
      setState(() {
        selectedIndex = k;
        shuffledArr[k] = rightArr[j];
      });
      await Future.delayed(Duration(milliseconds: speed.toInt()));
      j++;
      k++;
    }
    setState(() {
      selectedIndex = -1;
      comparingIndex = -1;
    });
  }

  Future<void> heapSort() async {
    int n = shuffledArr.length;

    // Build heap (rearrange array)
    for (int i = n ~/ 2 - 1; i >= 0; i--) {
      await heapify(n, i);
    }

    // One by one extract an element from heap
    for (int i = n - 1; i >= 0; i--) {
      setState(() {
        double temp = shuffledArr[0];
        shuffledArr[0] = shuffledArr[i];
        shuffledArr[i] = temp;
      });

      await heapify(i, 0);
    }
  }

  Future<void> heapify(int n, int i) async {
    int largest = i; // Initialize largest as root
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    setState(() {
      selectedIndex = largest;
    });

    // If left child is larger than root
    if (left < n && shuffledArr[left] > shuffledArr[largest]) {
      setState(() {
        comparingIndex = left;
      });
      largest = left;
    }

    // If right child is larger than largest so far
    if (right < n && shuffledArr[right] > shuffledArr[largest]) {
      comparingIndex = right;

      largest = right;
    }

    // If largest is not root
    if (largest != i) {
      setState(() {
        double swap = shuffledArr[i];
        shuffledArr[i] = shuffledArr[largest];
        shuffledArr[largest] = swap;
      });

      await Future.delayed(Duration(milliseconds: speed.toInt()));

      // Recursively heapify the affected sub-tree
      await heapify(n, largest);
    }
    setState(() {
      selectedIndex = -1;
      comparingIndex = -1;
    });
  }

  Future<void> radixSort() async {
    // Find the maximum number to know the number of digits
    double maxNum = shuffledArr.reduce(max);

    // Apply counting sort for every digit
    for (int exp = 1; maxNum ~/ exp > 0; exp *= 10) {
      await countSort(exp);
    }
  }

  Future<void> countSort(int exp) async {
    int n = shuffledArr.length;
    List<double> output = List.filled(n, 0);
    List<int> count = List.filled(10, 0);

    // Store count of occurrences
    for (int i = 0; i < n; i++) {
      count[(shuffledArr[i] ~/ exp) % 10]++;
    }

    // Change count[i] so that count[i] now contains the actual
    // position of this digit in output[]
    for (int i = 1; i < 10; i++) {
      count[i] += count[i - 1];
    }

    // Build the output array
    for (int i = n - 1; i >= 0; i--) {
      output[count[(shuffledArr[i] ~/ exp) % 10] - 1] = shuffledArr[i];
      count[(shuffledArr[i] ~/ exp) % 10]--;
    }

    // Copy the output array to shuffledArr[]
    for (int i = 0; i < n; i++) {
      setState(() {
        shuffledArr[i] = output[i];
      });
      await Future.delayed(Duration(milliseconds: speed.toInt()));
    }
  }

  Future<void> combSort() async {
    int n = shuffledArr.length;
    int gap = n;
    bool swapped = true;

    while (gap != 1 || swapped) {
      gap = (gap * 10) ~/ 13;
      if (gap < 1) {
        gap = 1;
      }

      swapped = false;

      for (int i = 0; i < n - gap; i++) {
        if (shuffledArr[i] > shuffledArr[i + gap]) {
          setState(() {
            double temp = shuffledArr[i];
            shuffledArr[i] = shuffledArr[i + gap];
            shuffledArr[i + gap] = temp;
          });
          swapped = true;
          await Future.delayed(Duration(milliseconds: speed.toInt()));
        }
      }
    }
  }

  Future<void> gnomeSort() async {
    int n = shuffledArr.length;
    int index = 0;

    while (index < n) {
      if (index == 0) {
        index++;
      }
      if (shuffledArr[index] >= shuffledArr[index - 1]) {
        index++;
      } else {
        setState(() {
          double temp = shuffledArr[index];
          shuffledArr[index] = shuffledArr[index - 1];
          shuffledArr[index - 1] = temp;
        });
        index--;
        await Future.delayed(Duration(milliseconds: speed.toInt()));
      }
    }
  }

  Future<void> cycleSort() async {
    int n = shuffledArr.length;

    for (int cycleStart = 0; cycleStart < n - 1; cycleStart++) {
      double item = shuffledArr[cycleStart];
      int pos = cycleStart;

      for (int i = cycleStart + 1; i < n; i++) {
        if (shuffledArr[i] < item) {
          pos++;
        }
      }

      if (pos == cycleStart) {
        continue;
      }

      while (item == shuffledArr[pos]) {
        pos++;
      }

      if (pos != cycleStart) {
        setState(() {
          double temp = item;
          item = shuffledArr[pos];
          shuffledArr[pos] = temp;
        });
        await Future.delayed(Duration(milliseconds: speed.toInt()));
      }

      while (pos != cycleStart) {
        pos = cycleStart;

        for (int i = cycleStart + 1; i < n; i++) {
          if (shuffledArr[i] < item) {
            pos++;
          }
        }

        while (item == shuffledArr[pos]) {
          pos++;
        }

        if (item != shuffledArr[pos]) {
          setState(() {
            double temp = item;
            item = shuffledArr[pos];
            shuffledArr[pos] = temp;
          });
          await Future.delayed(Duration(milliseconds: speed.toInt()));
        }
      }
    }
  }

  Future<void> pigeonholeSort() async {
    double minVal = shuffledArr.reduce(min);
    double maxVal = shuffledArr.reduce(max);
    int n = shuffledArr.length;

    int range = (maxVal - minVal).toInt() + 1;
    List<List<double>> holes = List.generate(range, (_) => []);

    for (int i = 0; i < n; i++) {
      holes[(shuffledArr[i] - minVal).toInt()].add(shuffledArr[i]);
    }

    int index = 0;
    for (int i = 0; i < range; i++) {
      for (int j = 0; j < holes[i].length; j++) {
        setState(() {
          shuffledArr[index++] = holes[i][j];
        });
        await Future.delayed(Duration(milliseconds: speed.toInt()));
      }
    }
  }

  Future<void> bucketSort() async {
    int n = shuffledArr.length;
    if (n <= 0) return;

    double maxVal = shuffledArr.reduce(max);
    double minVal = shuffledArr.reduce(min);

    int bucketCount = ((maxVal - minVal) ~/ 10 + 1).toInt();
    List<List<double>> buckets = List.generate(bucketCount, (_) => []);

    for (int i = 0; i < n; i++) {
      int bucketIndex = ((shuffledArr[i] - minVal) / 10).toInt();
      buckets[bucketIndex].add(shuffledArr[i]);
    }

    int index = 0;
    for (int i = 0; i < bucketCount; i++) {
      buckets[i].sort();
      for (int j = 0; j < buckets[i].length; j++) {
        setState(() {
          shuffledArr[index++] = buckets[i][j];
        });
        await Future.delayed(Duration(milliseconds: speed.toInt()));
      }
    }
  }

  Future<void> countingSort() async {
    int n = shuffledArr.length;
    double maxVal = shuffledArr.reduce(max);
    double minVal = shuffledArr.reduce(min);

    int range = (maxVal - minVal).toInt() + 1;
    List<int> count = List.filled(range, 0);
    List<double> output = List.filled(n, 0);

    for (int i = 0; i < n; i++) {
      count[(shuffledArr[i] - minVal).toInt()]++;
    }

    for (int i = 1; i < count.length; i++) {
      count[i] += count[i - 1];
    }

    for (int i = n - 1; i >= 0; i--) {
      output[count[(shuffledArr[i] - minVal).toInt()] - 1] = shuffledArr[i];
      count[(shuffledArr[i] - minVal).toInt()]--;
    }

    for (int i = 0; i < n; i++) {
      setState(() {
        shuffledArr[i] = output[i];
      });
      await Future.delayed(Duration(milliseconds: speed.toInt()));
    }
  }

  Future<void> shellSort() async {
    int n = shuffledArr.length;

    // Start with a big gap, then reduce the gap
    for (int gap = n ~/ 2; gap > 0; gap ~/= 2) {
      for (int i = gap; i < n; i++) {
        double temp = shuffledArr[i];
        int j;
        for (j = i; j >= gap && shuffledArr[j - gap] > temp; j -= gap) {
          setState(() {
            shuffledArr[j] = shuffledArr[j - gap];
          });
          await Future.delayed(Duration(milliseconds: speed.toInt()));
        }
        setState(() {
          shuffledArr[j] = temp;
        });
        await Future.delayed(Duration(milliseconds: speed.toInt()));
      }
    }
  }

  Future<void> cocktailShakerSort() async {
    bool swapped = true;
    int start = 0;
    int end = shuffledArr.length;

    while (swapped) {
      swapped = false;

      // Traverse the array from left to right
      for (int i = start; i < end - 1; i++) {
        if (shuffledArr[i] > shuffledArr[i + 1]) {
          setState(() {
            double temp = shuffledArr[i];
            shuffledArr[i] = shuffledArr[i + 1];
            shuffledArr[i + 1] = temp;
          });
          swapped = true;
          await Future.delayed(Duration(milliseconds: speed.toInt()));
        }
      }

      // If nothing moved, the array is sorted
      if (!swapped) break;

      // Otherwise, reset the swapped flag so that it
      // can be used in the next stage
      swapped = false;

      // Move the end point back by one, because
      // the item at the end is in its rightful spot
      end--;

      // Traverse the array from right to left
      for (int i = end - 1; i >= start; i--) {
        if (shuffledArr[i] > shuffledArr[i + 1]) {
          setState(() {
            double temp = shuffledArr[i];
            shuffledArr[i] = shuffledArr[i + 1];
            shuffledArr[i + 1] = temp;
          });
          swapped = true;
          await Future.delayed(Duration(milliseconds: speed.toInt()));
        }
      }

      // Increase the starting point, because
      // the last stage would have moved the next
      // smallest number to its rightful spot
      start++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Visual Sorting Algorithm"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Bubble Sort'),
              onTap: () {
                bubbleSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Selection Sort'),
              onTap: () {
                selectionSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Insertion Sort'),
              onTap: () {
                insertionSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Quick Sort'),
              onTap: () {
                quickSort(0, shuffledArr.length - 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Merge Sort'),
              onTap: () {
                mergeSort(0, shuffledArr.length - 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Heap Sort'),
              onTap: () {
                heapSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Radix Sort'),
              onTap: () {
                radixSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Shell Sort'),
              onTap: () {
                shellSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Cocktail Shaker Sort'),
              onTap: () {
                cocktailShakerSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Comb Sort'),
              onTap: () {
                combSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Gnome Sort'),
              onTap: () {
                gnomeSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Cycle Sort'),
              onTap: () {
                cycleSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Pigeonhole Sort'),
              onTap: () {
                pigeonholeSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Bucket Sort'),
              onTap: () {
                bucketSort();
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Counting Sort'),
              onTap: () {
                countingSort();
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Shuffle'),
              onTap: () {
                shuffleValues();
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Array Size'),
              subtitle: Slider(
                value: arraySize,
                min: 10,
                max: 100,
                divisions: 9,
                label: arraySize.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    arraySize = value;
                    _generateArray();
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Speed'),
              subtitle: Slider(
                value: speed,
                min: 1,
                max: 100,
                divisions: 99,
                label: speed.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    speed = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            width: 910,
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: shuffledArr.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 19,
                              height: shuffledArr[index] * 3.8,
                              decoration: BoxDecoration(
                                color: index == selectedIndex
                                    ? Colors.amber
                                    : index == comparingIndex
                                        ? Colors.red
                                        : Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          CustomButton(
            onTap: shuffleValues,
            size: const Size(320, 50),
            label: 'Shuffle',
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                onTap: bubbleSort,
                size: const Size(150, 50),
                label: 'Bubble Sort',
              ),
              CustomButton(
                onTap: insertionSort,
                size: const Size(150, 50),
                label: 'Insertion Sort',
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                onTap: selectionSort,
                size: const Size(150, 50),
                label: 'Selection Sort',
              ),
              CustomButton(
                onTap: heapSort,
                size: const Size(150, 50),
                label: 'Heap Sort',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.size,
    required this.label,
  });

  final VoidCallback onTap;
  final Size size;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.purple,
            Colors.pink,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: size,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
