import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        fontFamily: 'Roboto',
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late List<double> arr = [3, 6, 9, 12, 15, 18, 21, 24, 27, 30];
  List<double> shuffledArr = [];
  double arraySize = 10;
  double speed = 100;

  @override
  void initState() {
    super.initState();
    _generateArray();
  }

  void _generateArray() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
              ),
              child: Text(
                'Visual Sorting Algorithm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  fontFamily: 'Roboto',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: 910,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(5, 5),
                  ),
                ],
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
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                width: 19,
                                height: shuffledArr[index] * 10,
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
              size: const Size(320, 40),
              label: 'Shuffle',
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onTap: bubbleSort,
                  size: const Size(150, 40),
                  label: 'Bubble Sort',
                ),
                CustomButton(
                  onTap: insertionSort,
                  size: const Size(150, 40),
                  label: 'Insertion Sort',
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onTap: selectionSort,
                  size: const Size(150, 40),
                  label: 'Selection Sort',
                ),
                CustomButton(
                  onTap: heapSort,
                  size: const Size(150, 40),
                  label: 'Heap Sort',
                ),
              ],
            ),
            Container(
              width: 320,
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Slider(
                value: speed,
                onChanged: (newValue) {
                  setState(() {
                    speed = newValue;
                  });
                },
                min: 0,
                max: 100,
                label: '${speed.round()}',
                thumbColor: Colors.white,
                overlayColor: const WidgetStatePropertyAll(
                  Colors.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Size size;
  final String label;

  const CustomButton({
    required this.onTap,
    required this.size,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Ink(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(5, 5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 1.2,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }
}
