import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(RAS());
}

class RAS extends StatelessWidget {
  const RAS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Principio(),
    );
  }
}

class Principio extends StatefulWidget {
  const Principio({Key? key}) : super(key: key);

  @override
  _PrincipioState createState() => _PrincipioState();
}

class _PrincipioState extends State<Principio> {
  String _imageUrl =
      'https://thumbs.dreamstime.com/b/serpientes-hermosas-verdes-169366978.jpg';

  List<Report> _reports = [];

  @override
  void initState() {
    super.initState();
    fetchReports().then((reports) {
      setState(() {
        _reports = reports;
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar reportes: $error'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('R_A_S_C'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.green),
                accountName: Text(
                  "R_A_S_C",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("R_A_S_C@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "R",
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color.fromARGB(255, 66, 223, 19)),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('INICIO'),
              leading: Icon(Icons.home),
              onTap: () {
                Navigator.pop(context); // Cierra el Drawer
              },
            ),
            Divider(),
            ListTile(
              title: Text('REPORTES'),
              leading: Icon(Icons.report_off),
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text("Reportes"),
                      ),
                      body: _reports.isEmpty
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: _reports.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(_reports[index].url),
                                  ),
                                  title: Text(_reports[index].title),
                                  trailing:
                                      Text(_reports[index].id.toString()),
                                );
                              },
                            ),
                    );
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('PROGRAMADOR'),
              leading: Icon(Icons.contacts),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Desarrollador(
                      programador: Programador(
                        foto: _imageUrl, // Pasar la URL de la imagen
                        nombre: 'sebastian',
                        correo: 'sebastian@outlook.com',
                        telefono: '+1234567890',
                        gmail: 'sebastian@gmail.com',
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage(_imageUrl), // Mostrar la imagen aquí
              ),
              SizedBox(width: 20),
              Text('',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 20),
          Text('Grid imagenes de serpientes', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                Image.network(
                  'https://es3y77fcmfa.exactdn.com/wp-content/uploads/2023/02/Bothriechis-lateralis-.jpg?strip=all&lossy=1&ssl=1',
                  fit: BoxFit.cover,
                ),
                Image.network(
                  'https://efeverde.com/wp-content/uploads/2022/01/Mongabay-serpientes-FOTO-9.jpg',
                  fit: BoxFit.cover,
                ),
                Image.network(
                  'https://nubedemonte.com/wp-content/uploads/2021/04/120766903_202628284557039_5592220530880508101_n.jpg',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('DATOS'),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'NOMBRES'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'APELLIDOS'),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'EMAIL'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit),
                      label: Text('ACTUALIZAR'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        label: Text("FORM"),
        icon: Icon(Icons.format_align_center),
      ),
    );
  }
}

class Desarrollador extends StatelessWidget {
  final Programador programador;

  const Desarrollador({Key? key, required this.programador}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Desarrollador'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(programador.foto),
            ),
            SizedBox(height: 20),
            Text(programador.nombre,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(programador.correo),
            SizedBox(height: 10),
            Text(programador.telefono),
            SizedBox(height: 10),
            Text(programador.gmail),
          ],
        ),
      ),
    );
  }
}

class Report {
  final int id;
  final String title;
  final String url;

  Report({required this.id, required this.title, required this.url});

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}

Future<List<Report>> fetchReports() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<Report> reports =
        data.map((item) => Report.fromJson(item)).toList();
    return reports;
  } else {
    throw Exception('Failed to load reports');
  }
}

class Programador {
  final String foto;
  final String nombre;
  final String correo;
  final String telefono;
  final String gmail;

  Programador({
    required this.foto,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.gmail,
  });
}
