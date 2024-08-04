import 'package:flutter/material.dart';

class UiSizes {
  static late final double _width;
  static late final double _height;

  UiSizes();

  void init(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;

    debugPrint("UiSizes.init(): Width: $_width, Height: $_height");
  }

  double get width => _width;
  double get height => _height;

  //getters for width
  double get w1 => _width * 0.01;
  double get w2 => _width * 0.02;
  double get w3 => _width * 0.03;
  double get w4 => _width * 0.04;
  double get w5 => _width * 0.05;
  double get w6 => _width * 0.06;
  double get w7 => _width * 0.07;
  double get w8 => _width * 0.08;
  double get w9 => _width * 0.09;
  double get w10 => _width * 0.1;
  double get w12 => _width * 0.12;
  double get w14 => _width * 0.14;
  double get w15 => _width * 0.15;
  double get w16 => _width * 0.16;
  double get w18 => _width * 0.18;
  double get w20 => _width * 0.2;
  double get w22 => _width * 0.22;
  double get w24 => _width * 0.24;
  double get w25 => _width * 0.25;
  double get w26 => _width * 0.26;
  double get w28 => _width * 0.28;
  double get w30 => _width * 0.3;
  double get w32 => _width * 0.32;
  double get w34 => _width * 0.34;
  double get w35 => _width * 0.35;
  double get w36 => _width * 0.36;
  double get w38 => _width * 0.38;
  double get w40 => _width * 0.4;
  double get w44 => _width * 0.42;
  double get w45 => _width * 0.45;
  double get w48 => _width * 0.48;
  double get w50 => _width * 0.5;
  double get w54 => _width * 0.54;
  double get w58 => _width * 0.58;
  double get w60 => _width * 0.6;
  double get w64 => _width * 0.64;
  double get w68 => _width * 0.68;
  double get w70 => _width * 0.7;
  double get w74 => _width * 0.72;
  double get w75 => _width * 0.75;
  double get w78 => _width * 0.78;
  double get w80 => _width * 0.8;
  double get w82 => _width * 0.82;
  double get w84 => _width * 0.84;
  double get w85 => _width * 0.85;
  double get w88 => _width * 0.88;
  double get w90 => _width * 0.9;
  double get w92 => _width * 0.92;
  double get w94 => _width * 0.94;
  double get w95 => _width * 0.95;
  double get w96 => _width * 0.96;
  double get w98 => _width * 0.98;

  //getters for height
  double get h1 => _height * 0.01;
  double get h2 => _height * 0.02;
  double get h3 => _height * 0.03;
  double get h4 => _height * 0.04;
  double get h5 => _height * 0.05;
  double get h6 => _height * 0.06;
  double get h7 => _height * 0.07;
  double get h8 => _height * 0.08;
  double get h9 => _height * 0.09;
  double get h10 => _height * 0.1;
  double get h12 => _height * 0.12;
  double get h14 => _height * 0.14;
  double get h15 => _height * 0.15;
  double get h16 => _height * 0.16;
  double get h18 => _height * 0.18;
  double get h20 => _height * 0.2;
  double get h22 => _height * 0.22;
  double get h24 => _height * 0.24;
  double get h25 => _height * 0.25;
  double get h26 => _height * 0.26;
  double get h28 => _height * 0.28;
  double get h30 => _height * 0.3;
  double get h32 => _height * 0.32;
  double get h34 => _height * 0.34;
  double get h35 => _height * 0.35;
  double get h36 => _height * 0.36;
  double get h38 => _height * 0.38;
  double get h40 => _height * 0.4;
  double get h44 => _height * 0.42;
  double get h45 => _height * 0.45;
  double get h48 => _height * 0.48;
  double get h50 => _height * 0.5;
  double get h54 => _height * 0.54;
  double get h58 => _height * 0.58;
  double get h60 => _height * 0.6;
  double get h64 => _height * 0.64;
  double get h68 => _height * 0.68;
  double get h70 => _height * 0.7;
  double get h74 => _height * 0.72;
  double get h75 => _height * 0.75;
  double get h78 => _height * 0.78;
  double get h80 => _height * 0.8;
  double get h82 => _height * 0.82;
  double get h84 => _height * 0.84;
  double get h85 => _height * 0.85;
  double get h88 => _height * 0.88;
  double get h90 => _height * 0.9;
  double get h92 => _height * 0.92;
  double get h94 => _height * 0.94;
  double get h95 => _height * 0.95;
  double get h96 => _height * 0.96;
  double get h98 => _height * 0.98;
}
