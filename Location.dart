// import 'dart:async';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// class Loction extends StatefulWidget {
//   Loction({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _LoctionState createState() => _LoctionState();
// }

// class _LoctionState extends State<Loction> {
//   StreamSubscription _locationSubscription;
//   Location _locationTracker = Location();
//   Marker marker;
//   Circle circle;
//   GoogleMapController _controller;

//   static final CameraPosition initialLocation = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   Future<Uint8List> getMarker() async {
//     ByteData byteData =
//         await DefaultAssetBundle.of(context).load('assets/food-truck.png');
//     return byteData.buffer.asUint8List();
//   }

//   void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
//     LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
//     this.setState(() {
//       marker = Marker(
//           markerId: MarkerId("home"),
//           position: latlng,
//           rotation: newLocalData.heading,
//           draggable: false,
//           zIndex: 2,
//           flat: true,
//           anchor: Offset(0.5, 0.5),
//           icon: BitmapDescriptor.fromBytes(imageData));

//       circle = Circle(
//           circleId: CircleId("food-truck"),
//           radius: newLocalData.accuracy,
//           zIndex: 1,
//           strokeColor: Colors.orange,
//           center: latlng,
//           fillColor: Colors.orange.withAlpha(70));
//     });
//   }

//   void getCurrentLocation() async {
//     try {
//       Uint8List imageData = await getMarker();
//       var location = await _locationTracker.getLocation();

//       updateMarkerAndCircle(location, imageData);

//       if (_locationSubscription != null) {
//         _locationSubscription.cancel();
//       }

//       _locationSubscription =
//           _locationTracker.onLocationChanged.listen((newLocalData) {
//         if (_controller != null) {
//           _controller.animateCamera(CameraUpdate.newCameraPosition(
//               new CameraPosition(
//                   bearing: 192.8334901395799,
//                   target: LatLng(newLocalData.latitude, newLocalData.longitude),
//                   tilt: 0,
//                   zoom: 18.00)));
//           updateMarkerAndCircle(newLocalData, imageData);
//         }
//       });
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         debugPrint("Permission Denied");
//       }
//     }
//   }

//   @override
//   void dispose() {
//     if (_locationSubscription != null) {
//       _locationSubscription.cancel();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Food Truck Loction"),
//         backgroundColor: Colors.orange,
//       ),
//       body: GoogleMap(
//         mapType: MapType.hybrid,
//         initialCameraPosition: initialLocation,
//         markers: Set.of((marker != null) ? [marker] : []),
//         circles: Set.of((circle != null) ? [circle] : []),
//         onMapCreated: (GoogleMapController controller) {
//           _controller = controller;
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.location_searching),
//           onPressed: () {
//             getCurrentLocation();
//           }),
//     );
//   }
// }
