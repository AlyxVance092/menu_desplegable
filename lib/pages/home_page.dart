import 'package:flutter/material.dart';

import 'accounting_page.dart';
import 'business_page.dart';
import 'home_dashboard_page.dart';
import 'school_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // El mismo índice selecciona el título, el ícono y la pantalla.
  static const List<String> _titles = [
    'Business',
    'Home',
    'School',
    'Contabilidad',
  ];
  static const List<IconData> _icons = [
    Icons.business_center_outlined,
    Icons.home_outlined,
    Icons.school_outlined,
    Icons.account_balance_wallet_outlined,
  ];
  static const List<IconData> _selectedIcons = [
    Icons.business_center,
    Icons.home_rounded,
    Icons.school_rounded,
    Icons.account_balance_wallet_rounded,
  ];
  static const List<Widget> _pages = [
    BusinessPage(),
    HomeDashboardPage(),
    SchoolPage(),
    AccountingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex],
            style: const TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: const Color(0xFFF8F9FC),
        actions: [
          IconButton(
            tooltip: 'Información de ${_titles[_selectedIndex]}',
            onPressed: () => _showMessage(
                'Sección ${_titles[_selectedIndex]} (contenido de demostración)'),
            icon: const Icon(Icons.info_outline_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
        destinations: List<NavigationDestination>.generate(
          _titles.length,
          (index) => NavigationDestination(
            icon: Icon(_icons[index]),
            selectedIcon: Icon(_selectedIcons[index]),
            label: _titles[index],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            _showMessage('Acción simulada: ${_titles[_selectedIndex]}'),
        icon: const Icon(Icons.add_rounded),
        label: Text('Nuevo ${_titles[_selectedIndex]}'),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
