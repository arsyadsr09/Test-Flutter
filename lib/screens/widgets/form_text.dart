import 'package:flutter/material.dart';

class FormText extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final onChange;

  FormText({this.controller, this.label, this.hint, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        Text(
          "$label",
          style: TextStyle(
              fontFamily: "SFP_Text",
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Color(0xFF2f3542)),
        ),
        SizedBox(height: 7),
        Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFf1f2f6),
            ),
            child: TextField(
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF2F3542),
                fontWeight: FontWeight.w500,
              ),
              controller: controller,
              onChanged: (text) => onChange != null ? onChange(text) : {},
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                fillColor: Color(0xFFced6e0),
                hintText: "$hint",
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: "SFP_Text",
                  color: Color(0xFF9D9D9D),
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
            )),
      ],
    );
  }
}
