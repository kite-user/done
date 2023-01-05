import 'package:flutter/material.dart';

class HeadlineTitle extends StatelessWidget {
  const HeadlineTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 16,
      ),
      child: TextField(
        style: Theme.of(context).textTheme.headlineMedium,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Enter a title',
          hintStyle: Theme.of(context).textTheme.headlineMedium,
          contentPadding: EdgeInsets.zero,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
