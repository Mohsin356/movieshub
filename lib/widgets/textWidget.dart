import 'package:flutter/material.dart';
class TextWidget extends StatelessWidget {
  const TextWidget({Key? key, required this.txt,this.txtWeight,this.txtClr}) : super(key: key);
    final String? txt;
    final FontWeight? txtWeight;
    final Color? txtClr;
  @override
  Widget build(BuildContext context) {
    return Text(txt!,
      style: TextStyle(fontWeight: txtWeight,color: txtClr),

    );
  }
}

