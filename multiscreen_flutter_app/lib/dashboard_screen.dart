import "package:flutter/material.dart";

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/profile',
              arguments: {
                'name': args?['name'] ?? 'No Name',
                'email': args?['email'] ?? 'No Email',
              },
            );
          },
          child: const Text('Go to Profile'),
        ),
      ),
    );
  }
}
