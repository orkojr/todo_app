import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:todo_app/helpers/color_helper.dart';
import 'package:todo_app/helpers/dimension_helper.dart';

loadingIndicator({Color? loadingColor}) {
  Center(
    child: SizedBox(
      width: DimensionHelper.size80,
      height: DimensionHelper.size20,
      child: LoadingIndicator(
        indicatorType: Indicator.ballBeat,
        colors: [loadingColor?? ColorHelper.primaryColor],
        strokeWidth: 2,
      ),
    ),
  );
}
