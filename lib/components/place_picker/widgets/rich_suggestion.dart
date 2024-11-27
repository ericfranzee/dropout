import 'package:flutter/material.dart';
import 'package:dropout/components/place_picker/entities/entities.dart';

class RichSuggestion extends StatelessWidget {
  final VoidCallback onTap;
  final AutoCompleteItem autoCompleteItem;

  const RichSuggestion(this.autoCompleteItem, this.onTap, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: RichText(text: TextSpan(children: getStyledTexts(context))),
        ),
      ),
    );
  }

  List<TextSpan> getStyledTexts(BuildContext context) {
    final List<TextSpan> result = [];
    const style = TextStyle(color: Colors.grey, fontSize: 15);

    final startText =
        autoCompleteItem.text?.substring(0, autoCompleteItem.offset);
    if (startText!.isNotEmpty) {
      result.add(TextSpan(text: startText, style: style));
    }

    final boldText = autoCompleteItem.text?.substring(autoCompleteItem.offset!,
        autoCompleteItem.offset! + autoCompleteItem.length!);
    result.add(
      TextSpan(
          text: boldText,
          style: style),
    );

    final remainingText = autoCompleteItem.text!
        .substring(autoCompleteItem.offset! + autoCompleteItem.length!);
    result.add(TextSpan(text: remainingText, style: style));

    return result;
  }
}