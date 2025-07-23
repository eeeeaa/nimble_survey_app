import 'package:flutter/material.dart';

import '../../../../../../core/ui/theme/app_text_size.dart';
import '../../../../../../gen/colors.gen.dart';
import '../base_answer.dart';

class AnswerDropDown extends BaseAnswer {
  const AnswerDropDown({
    super.key,
    required super.onUpdateAnswer,
    required super.answers,
  });

  @override
  BaseAnswerState<AnswerDropDown> createState() => _AnswerDropDown();
}

class _AnswerDropDown extends BaseAnswerState<AnswerDropDown> {
  String? selectedItemId = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedItemId = widget.answers.first.id;
    });
    submitAnswer(widget.answers.first.id);
  }

  @override
  Widget buildAnswer(BuildContext context) {
    final answerList =
        widget.answers.map((item) {
          return DropdownMenuEntry(value: item.id, label: item.answerText);
        }).toList();

    return Center(
      child: DropdownMenu<String>(
        initialSelection: widget.answers.first.id,
        dropdownMenuEntries: answerList,
        textStyle: TextStyle(
          color: ColorName.primaryText,
          fontSize: AppTextSize.textSizeLarge,
          fontWeight: FontWeight.normal,
        ),
        onSelected: (String? itemId) {
          setState(() {
            selectedItemId = itemId;
          });
          if (itemId != null) {
            submitAnswer(itemId);
          }
        },
      ),
    );
  }
}
