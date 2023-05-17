

import 'package:flutter/cupertino.dart';

import 'export.dart';

late Assets assets;
late AppColors colors;
late AppConstant constant;
late AppSizes sizes;
late Styles textStyles;
late AppWidgets widgets;

void initializeAppResources({@required context}) {
  sizes = AppSizes();
  sizes.initializeSize(context);
  assets = Assets();
  colors = AppColors();
  constant = AppConstant();
  textStyles = Styles();
  widgets = AppWidgets();
}
