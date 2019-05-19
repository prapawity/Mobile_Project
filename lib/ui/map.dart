import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class MapLocation extends StatefulWidget{
  final double lat, lng;
  MapLocation({this.lat, this.lng});
  @override
  State<StatefulWidget> createState() {
    return _MapLocationState();
  }
}

class _MapLocationState extends State<MapLocation>{
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
          appBar: AppBar(
            title: Text("แผนที่"),centerTitle: true,
          ),
          body: new FlutterMap(
              options: new MapOptions(
                  center: new LatLng(widget.lat, widget.lng), minZoom: 10.0),
              layers: [
                new TileLayerOptions(
                    urlTemplate:
                        "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                    additionalOptions: {
              'accessToken': 'pk.eyJ1IjoiZnJvbmctbnQiLCJhIjoiY2p1YXZxM3hrMDcwaTQzbWw2aDhnNjRkYyJ9.RWy6ovYfXelq1Ol1T0lwPQ',
              'id': 'mapbox.streets',
            }),
                new MarkerLayerOptions(markers: [
                  new Marker(
                      width: 45.0,
                      height: 45.0,
                      point: new LatLng(widget.lat, widget.lng),
                      builder: (context) => new Container(
                            child: IconButton(
                              icon: Icon(Icons.location_on),
                              color: Colors.red,
                              iconSize: 45.0,
                              onPressed: () {
                                print('Marker tapped');
                              },
                            ),
                          ))
                ])
              ]
              ),
    );
    }
  }
