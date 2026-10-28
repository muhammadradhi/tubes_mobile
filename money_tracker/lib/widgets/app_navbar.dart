
import 'package:flutter/material.dart';

class AppNavbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color _backgroundColor = Color(0xFF1E293B);
  static const Color _activeColor = Colors.white;
  static const Color _inactiveColor = Color(0xFF94A3B8);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 12,
        left: 8,
        right: 8,
      ),
      child: Row(
        children: [
          _buildNavItem(
            icon: Icons.home_outlined,
            label: 'Beranda',
            index: 0,
          ),
          _buildNavItem(
            icon: Icons.add_circle_outline,
            label: 'Tambah',
            index: 1,
            isCenter: true,
          ),
          _buildNavItem(
            icon: Icons.history_outlined,
            label: 'Riwayat',
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    bool isCenter = false,
  }) {
    final bool isActive = currentIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onTap(index),
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 52,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: isCenter ? 28 : 24,
                  color: isActive ? _activeColor : _inactiveColor,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isActive ? _activeColor : _inactiveColor,
                    fontSize: 11,
                    fontWeight: isActive
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
