import 'package:equatable/equatable.dart';

class LeasureCategory extends Equatable {
  final String title;
  final String assetString;
  final int starCount;
  final int countAids;

  const LeasureCategory(
      this.title, this.assetString, this.starCount, this.countAids);

  @override
  List<Object?> get props => [title, assetString];
}
