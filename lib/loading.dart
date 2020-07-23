import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

// loader script because its like  common that  can be used at many places
class loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: SpinKitWave(
        color: Colors.black,
        size: 20.0,
      )),
    );
  }
}
