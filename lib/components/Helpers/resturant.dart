import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Resturant {
  final String name;
  final String address;
  final String price;
  final String rating;
  final String image;
  final String description;
  final String borough;

  Resturant({
    required this.name,
    required this.address,
    required this.price,
    required this.rating,
    required this.image,
    required this.description,
    required this.borough,
  });
}
