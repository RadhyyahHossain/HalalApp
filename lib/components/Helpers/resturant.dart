import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Resturant {
  final String name;
  final String address;
  final int price;
  final String rating;

  Resturant({
    required this.name,
    required this.address,
    required this.price,
    required this.rating,
  });
}
