import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Resturant {
  final String name;
  final String address;
  final String price;
  final String phoneNumber;
  final String image;
  final String description;
  final String borough;
  final String latitude;
  final String longitude;

  Resturant({
    required this.name,
    required this.address,
    required this.price,
    required this.phoneNumber,
    required this.image,
    required this.description,
    required this.borough,
    required this.latitude,
    required this.longitude,
  });
}
