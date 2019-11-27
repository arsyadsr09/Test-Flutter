import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SelectSuggestion extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final getSuggestions, selectedSuggestion;

  SelectSuggestion(
      {this.controller,
      this.label,
      this.hint,
      this.getSuggestions,
      this.selectedSuggestion});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10),
        label != null
            ? Text(
                "$label",
                style: TextStyle(
                    fontFamily: "SFP_Text",
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0xFF2f3542)),
              )
            : Container(),
        SizedBox(height: 7),
        Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFf1f2f6),
            ),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                  autofocus: true,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF2F3542),
                    fontWeight: FontWeight.w500,
                  ),
                  controller: controller,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFF2F3542),
                    ),
                    fillColor: Color(0xFFced6e0),
                    hintText: "$hint",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: "SFP_Text",
                      color: Color(0xFF9D9D9D),
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  )),
              suggestionsCallback: (pattern) async {
                return await getSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion['employee_name']),
                );
              },
              onSuggestionSelected: (suggestion) {
                controller.text = suggestion['employee_name'];
                selectedSuggestion(suggestion);
              },
            )),
      ],
    );
  }
}
