# Visual Sorting Algorithm - Flutter App

This Flutter application demonstrates the visualization of different sorting algorithms, including Bubble Sort, Selection Sort, Insertion Sort, and Heap Sort. The user can observe how each algorithm processes an array of numbers step by step, with a clear, animated representation of each swap or comparison between elements.

## Features

- **Visualize Sorting Algorithms**: The app provides visual representation and real-time animations for the following sorting algorithms:
  - **Bubble Sort**
  - **Selection Sort**
  - **Insertion Sort**
  - **Heap Sort**
  
- **User Interaction**:
  - **Shuffle**: Randomly shuffle the array to re-sort it with any of the algorithms.
  - **Speed Control**: Adjust the speed of the sorting process using a slider.

- **Animated Sorting**: Each sorting algorithm highlights the selected and comparing elements during the sorting process using different colors:
  - **Amber** for the currently selected element
  - **Red** for the comparing element
  - **PurpleAccent** for all other elements

## Screenshots

Include screenshots showing the UI, highlighting the sorting process, control buttons, and speed adjustment.

## Installation

To run this project locally, follow the steps below:

1. **Clone the repository**:
   
   git clone https://github.com/hammadasifali/Visual-Sorting-Algorithm.git

2. **Navigate to the project directory**:
      cd visual-sorting-algorithm-flutter

3. **Install dependencies**:
   flutter pub get

4. **Run the app**:
   flutter run

## How to Use

1. Start the app, and you will see a shuffled list of numbers.
2. Click the **Shuffle** button to reshuffle the numbers.
3. Choose one of the sorting algorithms (Bubble Sort, Insertion Sort, Selection Sort, Heap Sort) by clicking its respective button.
4. Use the speed slider to adjust the sorting animation speed.
5. Watch the visualization of the sorting algorithm in action!

## Dependencies

- `flutter`
- `dart:math`

## Customization

You can easily modify the number of elements, the colors, or even add more sorting algorithms by editing the `MainLayout` class. The array is generated and shuffled on initialization and can be manipulated via the shuffle and sorting buttons.

## Contributing

If you wish to contribute to this project, feel free to submit a pull request. Any suggestions or improvements are welcome!

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---
