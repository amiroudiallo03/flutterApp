import 'package:flutter/material.dart';

// InputDecoration buildInputDcoration(String hinText, {required Icon prefixIcon}) {
//   return buildInputDcoration(
//     labelText:
//   )
// }

MaterialButton longButtons(String title, VoidCallback? fun,
    {Color color = Colors.orange, Color textColor = Colors.white}) {
  return MaterialButton(
    onPressed: fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}
