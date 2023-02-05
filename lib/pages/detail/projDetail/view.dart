import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class ProjDetailPage extends StatelessWidget {
  String itemId;
  ProjDetailPage({Key? key, required this.itemId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProjDetailProvider(context, itemId),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final p = context.read<ProjDetailProvider>();
    final pp = Provider.of<ProjDetailProvider>(context, listen: true);
    p.init();
    return Scaffold(
      key: p.scaffoldkey,
    );
  }
}
