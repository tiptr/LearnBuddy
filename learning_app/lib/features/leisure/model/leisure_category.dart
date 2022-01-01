import 'package:equatable/equatable.dart';

class LeisureCategory extends Equatable {
  final String title;
  final String assetString;
  final int starCount;
  final int countAids;

  const LeisureCategory({
    required this.title,
    required this.assetString,
    required this.starCount,
    required this.countAids,
  });

  @override
  List<Object?> get props => [title, assetString];
}
