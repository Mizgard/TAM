import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      title: 'KrakFlow',
      home: Scaffold( 
        appBar: AppBar( 
          title: const Text("KrakFlow"), 
        ),
        body: Center( 
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, 
            children: const [
              Text("KrakFlow"), 
              SizedBox(height: 20),
              Text("Organizacja studiów"),
              SizedBox(height: 20),
              Text("Dzisiejsze zadania"),
              SizedBox(height: 20),
              
              TaskCard(
                title: "Projekt Flutter", 
                subtitle: "termin: jutro", 
                icon: Icons.task, 
              ),
              TaskCard(
                title: "Ćwiczenia z matematyki", 
                subtitle: "termin: dziś", 
                icon: Icons.calculate,
              ),
              TaskCard(
                title: "Przeczytać o widgetach", 
                subtitle: "termin: w tym tygodniu", 
                icon: Icons.book,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;    
  final String subtitle;
  final IconData icon;  
  const TaskCard({
    required this.title, 
    required this.subtitle, 
    required this.icon, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card( 
      child: ListTile( 
        leading: Icon(icon), 
        title: Text(title), 
        subtitle: Text(subtitle),
      ),
    );
  }
}