import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:save_u/constants.dart';
import 'package:http/http.dart' as http;

class SafeMapPage extends StatefulWidget {
  const SafeMapPage({super.key});

  @override
  State<SafeMapPage> createState() => _SafeMapPageState();
}

class _SafeMapPageState extends State<SafeMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  //Completer() => Future<> 반환

  Set<Marker> _markers = Set();
  Set<Marker> _markers_earthquake = Set();
  Set<Marker> _markers_AED = Set();
  Set<Marker> _markers_hospital = Set();
  @override
  void initState() {
    super.initState();
    //_setInitialPosition();
    _markers.add(Marker(
      markerId: MarkerId('myInitialPosition'),
      position: LatLng(37.589667551557, 127.019849627),
      infoWindow: InfoWindow(title: 'My Position', snippet: 'where am I?'),
    ));
    _markers_earthquake.add(Marker(
      markerId: MarkerId('Korea Univ.'),
      position: LatLng(37.588556165888, 127.01998189277),
      infoWindow: InfoWindow(title: 'Korea Univ.'),
    ));
    _markers_hospital.add(Marker(
      markerId: MarkerId('hospital1'),
      position: LatLng(37.596838, 127.035598),
      infoWindow: InfoWindow(title: '성북 우리 아이들 병원'),
    ));
    _markers_hospital.add(Marker(
      markerId: MarkerId('hospital2'),
      position: LatLng(127.026508, 37.587191),
      infoWindow: InfoWindow(title: '고려대 부속 안암 병원'),
    ));
    /*_markers_hospital.add(Marker(
      markerId: MarkerId('hospital2'),
      position: LatLng(127.0073736, 37.5892371),
      infoWindow: InfoWindow(title: '리누스 병원'),
    ));
    
    _markers_hospital.add(Marker(
      markerId: MarkerId('hospital4'),
      position: LatLng(127.0356232, 37.5967276),
      infoWindow: InfoWindow(title: '성북 중앙 병원'),
    ));*/
  }

  /*_setInitialPosition() async {
    position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.lowest);
    setState(() {});
  }*/

  CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.589667551557, 127.019849627),
    zoom: 15,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller); //_controller를 이제 사용할 수 있다.
  }

  void _searchPlaces(
    String locationName,
    double latitude,
    double longitude,
  ) async {
    setState(() {
      _markers.clear();
    });
/*
    final url = Uri.parse(
        "$baseUrl?key=$API_KEY&location=$latitude,$longitude&radius=1000&language=ko&keyword=$locationName");

    final response = await http.get(url);
    print(response);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['status'] == 'OK') {
        GoogleMapController controller =
            await _controller.future; // GoogleMap Controller를 쓸 수 있게
        controller.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(latitude, longitude),
          ),
        );
        setState(
          () {
            final foundPlaces = data['results'];

            for (int i = 0; i < foundPlaces; i++) {
              _markers.add(Marker(
                markerId: MarkerId(foundPlaces[i]['place_id']),
                position: LatLng(
                  foundPlaces[i]['geometry']['location']['lat'],
                  foundPlaces[i]['geometry']['location']['lng'],
                ),
                infoWindow: InfoWindow(
                  title: foundPlaces[i]['name'],
                  snippet: foundPlaces[i]['vicinity'],
                ),
              ));
            }
          },
        );
      }
    } else {
      print("Fail to fetch place data");
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
          ),
          Container(
              margin: EdgeInsets.only(top: 7, right: 7, left: 7),
              alignment: Alignment.topRight,
              child: Row(
                children: <Widget>[
                  FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        _markers = _markers_earthquake;
                      });
                    },
                    label: Text("지진해일대피장소"),
                    icon: Icon(Icons.map),
                    elevation: 8,
                    backgroundColor: Colors.blue[400],
                  ),
                  SizedBox(width: 3),
                  FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        _markers = _markers_AED;
                      });
                    },
                    label: Text("AED"),
                    icon: Icon(Icons.map),
                    elevation: 8,
                    backgroundColor: Colors.green[400],
                  ),
                  SizedBox(width: 3),
                  FloatingActionButton.extended(
                    onPressed: () {
                      setState(() {
                        _markers = _markers_hospital;
                      });
                    },
                    label: Text("응급실"),
                    icon: Icon(Icons.map),
                    elevation: 8,
                    backgroundColor: Colors.red[400],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
