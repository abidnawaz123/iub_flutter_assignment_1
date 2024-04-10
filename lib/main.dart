import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Simple Application by Abid Nawaz'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late TextEditingController _nameController;
  bool _hasAssets = false;
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    employees = [
      Employee(name:"Abid Nawaz",hasAssets:true),
      Employee(name:"Ali Hamza",hasAssets:true),
    ];
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Employee Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Has Assets:'),
                Checkbox(
                  value: _hasAssets,
                  onChanged: (bool? value) {
                    setState(() {
                      _hasAssets = value ?? false;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                employees.add(Employee(name: _nameController.text, hasAssets: _hasAssets));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssetManagementPage(employees: employees),
                  ),
                );
              },
              child: Text('Manage Assets'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Employee {
  final String name;
  final bool hasAssets;

  Employee({required this.name, required this.hasAssets});
}

class AssetManagementPage extends StatelessWidget {
  final List<Employee> employees;

  const AssetManagementPage({Key? key, required this.employees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter employees who have assets
    final List<Employee> employeesWithAssets = employees.where((e) => e.hasAssets).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Asset Management Page'),
      ),
      body: ListView.builder(
        itemCount: employeesWithAssets.length,
        itemBuilder: (context, index) {
          final employee = employeesWithAssets[index];
          return ListTile(
            title: Text(employee.name),
            subtitle: Text('Has Assets: ${employee.hasAssets ? 'Yes' : 'No'}'),
          );
        },
      ),
    );
  }
}
