// lib/widgets/layout/navbar.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';
import '../../providers/app_provider.dart';

class Navbar extends StatefulWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<_NavItem> _items = const [
    _NavItem(label: 'Home', route: AppConstants.homeRoute),
    _NavItem(label: 'Services', route: AppConstants.servicesRoute),
    _NavItem(label: 'About', route: AppConstants.aboutRoute),
    _NavItem(label: 'Contact', route: AppConstants.contactRoute),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isScrolled = context.watch<AppProvider>().isScrolled;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);

    // Safely read current route
    String currentRoute = '/';
    try {
      currentRoute = GoRouterState.of(context).uri.toString();
    } catch (_) {}

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 72,
      decoration: BoxDecoration(
        color: isScrolled ? dc.surface.withOpacity(0.97) : Colors.transparent,
        border: isScrolled
            ? Border(bottom: BorderSide(color: dc.border, width: 1))
            : null,
        boxShadow: isScrolled
            ? [
                BoxShadow(
                  color: dc.neonBlue.withOpacity(0.06),
                  blurRadius: 20,
                )
              ]
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.value(context, mobile: 20, desktop: 80),
        ),
        child: Row(
          children: [
            // Logo
            _Logo(),
            const Spacer(),
            if (isMobile)
              _MobileMenuButton()
            else
              Row(
                children: [
                  ..._items.map((item) => _NavLink(
                        item: item,
                        isActive: currentRoute == item.route ||
                            (item.route != '/' &&
                                currentRoute.startsWith(item.route)),
                      )),
                  const SizedBox(width: 8),
                  _ThemeToggleButton(),
                  const SizedBox(width: 16),
                  _GetStartedButton(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return GestureDetector(
      onTap: () => context.go(AppConstants.homeRoute),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: AppColors.buttonGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.smart_toy_outlined,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 10),
          ShaderMask(
            shaderCallback: (bounds) =>
                AppColors.primaryGradient.createShader(bounds),
            child: Text(
              'RoboGenius',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.white,
                  ),
            ),
          ),
          Text(
            ' Tech',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: dc.textSecondary,
                ),
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final _NavItem item;
  final bool isActive;

  const _NavLink({required this.item, required this.isActive});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(widget.item.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.item.label,
                style: TextStyle(
                  color: widget.isActive || _hovered
                      ? dc.neonBlue
                      : dc.textSecondary,
                  fontWeight:
                      widget.isActive ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 15,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _hovered || widget.isActive ? 24 : 0,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  gradient: AppColors.buttonGradient,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GetStartedButton extends StatefulWidget {
  @override
  State<_GetStartedButton> createState() => _GetStartedButtonState();
}

class _GetStartedButtonState extends State<_GetStartedButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(AppConstants.contactRoute),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(8),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.neonBlue.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: const Text(
            'Get Started',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatefulWidget {
  @override
  State<_ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<_ThemeToggleButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<AppProvider>().isDark;
    return Tooltip(
      message: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      child: MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.read<AppProvider>().toggleTheme(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 44,
          height: 26,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            gradient: isDark
                ? AppColors.buttonGradient
                : const LinearGradient(
                    colors: [Color(0xFFFFB800), Color(0xFFFF6B00)]),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                        color: (isDark
                                ? AppColors.neonBlue
                                : const Color(0xFFFFB800))
                            .withOpacity(0.4),
                        blurRadius: 12)
                  ]
                : [],
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                    color: Colors.white, shape: BoxShape.circle),
                child: Icon(
                  isDark ? Icons.nightlight_round : Icons.wb_sunny_rounded,
                  size: 12,
                  color: isDark
                      ? const Color(0xFF1A1A2E)
                      : const Color(0xFFFF8C00),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Consumer<AppProvider>(
      builder: (_, app, __) => IconButton(
        onPressed: app.toggleMenu,
        icon: Icon(
          app.isMenuOpen ? Icons.close : Icons.menu,
          color: dc.textPrimary,
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String route;
  const _NavItem({required this.label, required this.route});
}

// ─── Mobile Nav Drawer ────────────────────────────────────────────────────────

class MobileNavDrawer extends StatelessWidget {
  const MobileNavDrawer({super.key});

  static const _items = [
    _NavItem(label: 'Home', route: AppConstants.homeRoute),
    _NavItem(label: 'Services', route: AppConstants.servicesRoute),
    _NavItem(label: 'About', route: AppConstants.aboutRoute),
    _NavItem(label: 'Contact', route: AppConstants.contactRoute),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return Consumer<AppProvider>(
      builder: (_, app, __) => AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: app.isMenuOpen ? Offset.zero : const Offset(0, -1),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: app.isMenuOpen ? 1.0 : 0.0,
          child: IgnorePointer(
            ignoring: !app.isMenuOpen,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 80, 24, 32),
              decoration: BoxDecoration(
                color: dc.surface.withOpacity(0.98),
                border: Border(bottom: BorderSide(color: dc.border)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._items.map((item) => _MobileNavItem(
                        item: item,
                        onTap: () {
                          app.closeMenu();
                          context.go(item.route);
                        },
                      )),
                  const SizedBox(height: 20),
                  // Theme toggle row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        app.isDark ? 'Dark Mode' : 'Light Mode',
                        style: TextStyle(
                          color: dc.textSecondary,
                          fontSize: 15,
                        ),
                      ),
                      _ThemeToggleButton(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        app.closeMenu();
                        context.go(AppConstants.contactRoute);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          gradient: AppColors.buttonGradient,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Get Started',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final _NavItem item;
  final VoidCallback onTap;
  const _MobileNavItem({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dc = DynamicColors(isDark);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: dc.border, width: 1)),
        ),
        child: Text(
          item.label,
          style: TextStyle(
            color: dc.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
