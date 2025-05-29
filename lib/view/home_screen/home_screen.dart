import 'package:flutter/material.dart';
import 'package:hisab_nikas/widgets/dashboard_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final menuItems = [
    {'title': 'হিসাব স্ক্যান', 'icon': Icons.document_scanner},
    {'title': 'বাকির হিসাব', 'icon': Icons.people},
    {'title': 'স্টক', 'icon': Icons.inventory},
    {'title': 'বিক্রি', 'icon': Icons.sell},
    {'title': 'রিপোর্ট', 'icon': Icons.analytics},
    {'title': 'ভয়েস এন্ট্রি', 'icon': Icons.mic},
    {'title': 'ডেলিভারি', 'icon': Icons.local_shipping},
    {'title': 'ব্যাকআপ', 'icon': Icons.backup},
  ];
      final theme = Theme.of(context);
    return Scaffold(

      appBar: AppBar(

        title: Text(
          "দোকানদার স্মার্ট খাতা",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return DashboardCard(title: item['title'].toString(), icon: item['icon'] as IconData,);
          },
        ),
      ),
    );
  }
}
