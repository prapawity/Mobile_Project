import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:mobile_project/model/restaurant_model.dart';

class MapLocation extends StatefulWidget {
  final double lat, lng;
  final Restaurant restaurant;
  MapLocation({this.lat, this.lng, this.restaurant});
  @override
  State<StatefulWidget> createState() {
    return _MapLocationState();
  }
}

class _MapLocationState extends State<MapLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แผนที่"),
        centerTitle: true,
      ),
      body: new FlutterMap(
          options: new MapOptions(
              center: new LatLng(widget.lat, widget.lng), minZoom: 10.0),
          layers: [
            new TileLayerOptions(
                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                    "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoiZnJvbmctbnQiLCJhIjoiY2p1YXZxM3hrMDcwaTQzbWw2aDhnNjRkYyJ9.RWy6ovYfXelq1Ol1T0lwPQ',
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
                            showBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return Container(
                                      height: 200,
                                      color: Colors.white,
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  left: 5,
                                                  right: 5,
                                                  bottom: 5),
                                              color: Color(0xff547AA5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.bookmark,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    '${widget.restaurant.name}',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.access_time),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    child: Text(
                                                      ' : ${widget.restaurant.detail.time[0]}',
                                                      textAlign: TextAlign.left,
                                                    )),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.home),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    width: 300,
                                                    child: Text(
                                                        ': ${widget.restaurant.detail.address}')),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.map),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    width: 300,
                                                    child: Text(
                                                        ': Latitude : ${widget.restaurant.lat}')),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(Icons.map),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    width: 300,
                                                    child: Text(
                                                        ': Longitude : ${widget.restaurant.lng}')),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                });
                            print('Marker tapped');
                          },
                        ),
                      ))
            ])
          ]),
    );
  }
}
