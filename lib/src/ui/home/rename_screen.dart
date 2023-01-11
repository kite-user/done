import 'package:flutter/material.dart';

class RenameScreen extends StatefulWidget {
  const RenameScreen({
    super.key,
    required this.initName,
  });

  final String initName;

  @override
  State<RenameScreen> createState() => _RenameScreenState();
}

class _RenameScreenState extends State<RenameScreen> {
  late String inputName;

  @override
  void initState() {
    super.initState();
    inputName = widget.initName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rename list'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: inputName.isEmpty
                ? null
                : () => Navigator.pop(
                      context,
                      inputName,
                    ),
            child: const Text('Done'),
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            initialValue: inputName,
            onChanged: (value) => setState(() {
              inputName = value;
            }),
            autofocus: true,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'Enter a name',
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              border: InputBorder.none,
              filled: true,
              fillColor: Theme.of(context).colorScheme.background,
            ),
          ),
        ],
      ),
    );
  }
}
