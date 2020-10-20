import 'package:flutter/material.dart';

class ServiceWidget extends StatelessWidget {
  final String service;

  const ServiceWidget({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(service),
    );
  }
}
