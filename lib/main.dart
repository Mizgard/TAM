import 'package:flutter/material.dart';

// Punkt startowy każdej aplikacji Flutter
void main() {
  runApp(const MyApp()); // Uruchomienie głównego widgetu 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Główny widget aplikacji 
      title: 'KrakFlow',
      home: Scaffold( // Podstawowy layout ekranu 
        appBar: AppBar( // Pasek górny 
          title: const Text("KrakFlow"),
        ),
        body: Center( 
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center, // Dodatkowe wyśrodkowanie wewnątrz kolumny
            children: const [ // Lista elementów wyświetlanych jeden pod drugim [
              Text("KrakFlow"), 
              SizedBox(height: 20),
              Text("Organizacja studiów"),
              SizedBox(height: 20),
              Text("Dzisiejsze zadania"),
              Card(
                child: ListTile(
                leading: Icon(Icons.task),
                title: Text("Projekt Flutter"),
                subtitle: Text("termin: jutro"),
              
              ),
              ), 
              Card(
                child: ListTile(
                leading: Icon(Icons.task),
                title: Text("Cwiczenia z matematyki"),
                subtitle: Text("termin:  dziś"),
                ), 
              ),
              Card(
                child: ListTile(
                leading: Icon(Icons.task),
                title: Text("Przeczytać o widgetach"),
                subtitle: Text("termin:  w tym tygodniu"),
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}