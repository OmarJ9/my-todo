import 'package:flutter/material.dart';

abstract class AppTypography {
  static const FontWeight _medium = FontWeight.w500;
  static const FontWeight _bold = FontWeight.w700;

  // A static scale factor
  static const double _scaleFactor = 1.15;

  // Helper method to apply scaling
  static double _scale(double size) => (size * _scaleFactor);

  static TextStyle bold10({Color? color}) => TextStyle(
        fontSize: _scale(10),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold12({Color? color}) => TextStyle(
        fontSize: _scale(12),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold14({Color? color}) => TextStyle(
        fontSize: _scale(14),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold16({Color? color}) => TextStyle(
        fontSize: _scale(16),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold18({Color? color}) => TextStyle(
        fontSize: _scale(18),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold20({Color? color}) => TextStyle(
        fontSize: _scale(20),
        fontWeight: _bold,
        color: color,
        height: 0,
      );

  static TextStyle bold24({Color? color}) => TextStyle(
        fontSize: _scale(24),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold26({Color? color}) => TextStyle(
        fontSize: _scale(26),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold30({Color? color}) => TextStyle(
        fontSize: _scale(30),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold32({Color? color}) => TextStyle(
        fontSize: _scale(32),
        fontWeight: _bold,
        color: color,
        height: 0,
      );

  static TextStyle bold36({Color? color}) => TextStyle(
        fontSize: _scale(36),
        fontWeight: _bold,
        color: color,
        height: 0,
      );
  static TextStyle bold48({Color? color}) => TextStyle(
        fontSize: _scale(48),
        fontWeight: _bold,
        color: color,
        height: 0,
      );

  static TextStyle medium10({Color? color}) => TextStyle(
        fontSize: _scale(10),
        fontWeight: _medium,
        color: color,
        height: 0,
      );

  static TextStyle medium12({Color? color}) => TextStyle(
        fontSize: _scale(12),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
  static TextStyle medium14({Color? color}) => TextStyle(
        fontSize: _scale(14),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
  static TextStyle medium16({Color? color}) => TextStyle(
        fontSize: _scale(16),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
  static TextStyle medium18({Color? color}) => TextStyle(
        fontSize: _scale(18),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
  static TextStyle medium20({Color? color}) => TextStyle(
        fontSize: _scale(20),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
  static TextStyle medium24({Color? color}) => TextStyle(
        fontSize: _scale(24),
        fontWeight: _medium,
        color: color,
        height: 0,
      );

  static TextStyle medium30({Color? color}) => TextStyle(
        fontSize: _scale(30),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
  static TextStyle medium32({Color? color}) => TextStyle(
        fontSize: _scale(32),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
  static TextStyle medium40({Color? color}) => TextStyle(
        fontSize: _scale(40),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
  static TextStyle medium48({Color? color}) => TextStyle(
        fontSize: _scale(48),
        fontWeight: _medium,
        color: color,
        height: 0,
      );
}
