import 'package:flutter/material.dart';

///Stores parameters from the UI for easier modification and replication
class VisualConstants {
  //**************************************  COMMON *********************************/

  static const Widget loading = Padding(
    padding: EdgeInsets.all(10.0),
    child: Center(
      child: SizedBox.square(
        dimension: 15,
        child: CircularProgressIndicator(),
      ),
    ),
  );
  static const SizedBox endOfScroll = SizedBox(
    height: 50,
  );

  //***** Gridviews */
  static const EdgeInsets paddingAll = EdgeInsets.all(10);
  static const EdgeInsets paddingHoriz = EdgeInsets.symmetric(horizontal: 10);
  static const SliverGridDelegate gridConfig =
      SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 0.65);

  //**************************************  WIDGETS *********************************/

  //* character card *****

  static const EdgeInsets cardPadding = EdgeInsets.all(5);
  static const double cardImageHeight = 211;

  //* Navigation Drawer ******

  static const EdgeInsets drawerButtonPadding = EdgeInsets.all(30.0);

//**************************************  SCREENS *********************************/

  //* episode + location details screen *****
  static const double detailSpacing = 20;

  //* details screen *****
  static const Color infoTitleBackground = Color.fromRGBO(0, 0, 0, 0.05);
  static const BorderRadius detailShape = BorderRadius.only(
      bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5));
}
