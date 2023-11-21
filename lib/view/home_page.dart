import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<String>> getLocation() async {
    Location location = new Location();
    LocationData _locationData = await location.getLocation();
    return [
      _locationData.longitude.toString(),
      _locationData.latitude.toString()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: FutureBuilder(
        future: getLocation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<String> data = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '経度' + data[0],
                  ),
                  Text(
                    '緯度' + data[1],
                  ),
                ],
              );
            } else {
              String data = 'エラー';
              return Text(data);
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else {
            String data = 'エラー';
            return Text(data);
          }
        },
      ),
    );
  }
}
