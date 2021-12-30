import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/features/ausgleich/bloc/leasure_category_cubit.dart';
import 'package:learning_app/features/ausgleich/bloc/leasure_category_state.dart';
import 'package:learning_app/features/ausgleich/screens/ausgleich_screen.dart';

class LeisureScreen extends StatelessWidget {
  const LeisureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeasureCategoryCubit, LeasureCategoryState>(
      bloc: LeasureCategoryCubit(),
      builder: (context, state) {
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.leasureCategories.length,
          itemBuilder: (BuildContext ctx, int idx) => LeasureCategoryCard(
            leasureCategory: state.leasureCategories[idx],
          ),
        );
      },
    );
  }
}
