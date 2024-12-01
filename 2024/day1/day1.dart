import 'dart:io';

Future<void> main() async {
  final lines = await File('./day1-input.txt').readAsLines();

  final lists = lines
      .map(
        (line) => line.split('   ').map(int.parse).toList(),
      )
      .toList();

  final leftList = lists.map((pair) => pair[0]).toList();
  final rightList = lists.map((pair) => pair[1]).toList();

  final leftSorted = leftList..sort();
  final rightSorted = rightList..sort();

  final part1 = sumOfDistance(leftList: leftSorted, rightList: rightSorted);

  final part2 = similarityScore(leftList: leftSorted, rightList: rightSorted);

  print(part2);
}

int sumOfDistance({
  required List<int> leftList,
  required List<int> rightList,
}) {
  final distances = List.generate(
    leftList.length,
    (i) => (leftList[i] - rightList[i]).abs(),
  );

  final sumOfDistance = distances.reduce(
    (value, element) => value + element,
  );

  return sumOfDistance;
}

int similarityScore({
  required List<int> leftList,
  required List<int> rightList,
}) {
  final rightFrequency = <int, int>{};
  for (var num in rightList) {
    rightFrequency[num] = (rightFrequency[num] ?? 0) + 1;
  }

  final similarityScore = leftList.fold<int>(0, (sum, left) {
    final count = rightFrequency[left] ?? 0;
    return sum + (count * left);
  });

  return similarityScore;
}
