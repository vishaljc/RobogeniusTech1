// lib/widgets/layout/scroll_scaffold.dart
//
// A Scaffold wrapper that:
//  - Listens for scroll events and updates AppProvider.isScrolled
//  - Shows the sticky Navbar as appBar
//  - Overlays the MobileNavDrawer on top of content
//  - Resets scroll state to false when the page is disposed

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import 'navbar.dart';

class ScrollScaffold extends StatefulWidget {
  final List<Widget> sections;

  const ScrollScaffold({super.key, required this.sections});

  @override
  State<ScrollScaffold> createState() => _ScrollScaffoldState();
}

class _ScrollScaffoldState extends State<ScrollScaffold> {
  @override
  void dispose() {
    // Reset navbar scroll state when navigating away
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        context.read<AppProvider>().setScrolled(false);
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: const Navbar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n is ScrollUpdateNotification) {
            context.read<AppProvider>().setScrolled(n.metrics.pixels > 10);
          }
          return false;
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: widget.sections,
              ),
            ),
            const MobileNavDrawer(),
          ],
        ),
      ),
    );
  }
}
