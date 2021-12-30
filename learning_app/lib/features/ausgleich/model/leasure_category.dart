import 'package:equatable/equatable.dart';

class LeasureCategory extends Equatable {
  final String title;
  final String assetString;
  final int starCount;
  final int countAids;

  const LeasureCategory({
    required this.title,
    required this.assetString,
    required this.starCount,
    required this.countAids,
  });

  @override
  List<Object?> get props => [title, assetString];
}
