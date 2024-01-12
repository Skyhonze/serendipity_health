import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Serendipity Health',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 16, 208, 9)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

// class MyHomePage extends StatelessWidget {
@override
Widget build(BuildContext context) {
  var appState = context.watch<MyAppState>();
  var pair = appState.current;
  IconData icon;
  if (appState.favorites.contains(pair)) {
    icon = Icons.star;
  } else {
    icon = Icons.star_border;
  }
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('A new random idea from serendipity:'),
          SizedBox(height: 10),
          BigCard(pair: pair),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Favorite'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department),
            label: 'Cek Kalori',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: 'Artikel',
          ),
          NavigationDestination(
            icon: Icon(Icons.apple),
            label: 'Program Diet',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
        ],
        selectedIndex: 0,
        onDestinationSelected: (value) {
          print('selected: $value');
        },
      ),
      body: Column(
        children: [
          // SafeArea(
          //   child: NavigationBar(
          //     destinations: [
          //       NavigationDestination(
          //         icon: Icon(Icons.home),
          //         label: 'Beranda',
          //       ),
          //       NavigationDestination(
          //         icon: Icon(Icons.local_fire_department),
          //         label: 'Cek Kalori',
          //       ),
          //       NavigationDestination(
          //         icon: Icon(Icons.list_alt),
          //         label: 'Artikel',
          //       ),
          //       NavigationDestination(
          //         icon: Icon(Icons.apple),
          //         label: 'Program Diet',
          //       ),
          //       NavigationDestination(
          //         icon: Icon(Icons.person),
          //         label: 'Akun',
          //       ),
          //     ],
          //     selectedIndex: 0,
          //     onDestinationSelected: (value) {
          //       print('selected: $value');
          //     },
          //   ),
          // ),
          Expanded(
            child: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: GeneratorPage(),
            ),
          ),
        ],
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
