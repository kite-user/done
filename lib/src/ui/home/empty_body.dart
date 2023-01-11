import 'package:flutter/material.dart';

class EmptyBody extends StatelessWidget {
  const EmptyBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(
        child: Text('No tasks yet'),
      ),
    );
  }
}
