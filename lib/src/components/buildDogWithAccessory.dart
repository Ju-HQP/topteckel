import 'package:topteckel/models/user.dart';
import 'package:topteckel/src/components/accessoryProperties.dart';
import 'package:flutter/material.dart';


Widget buildDogWithAccessory(User user, double widthDog, double heightDog) {
  final accessory = accessories[user.accessory];

  return Stack(
    clipBehavior: Clip.none, // Permet de ne pas découper l'accessoire
    children: [
      Image.asset(
        user.getDogImage(),
        width: widthDog,
        height: heightDog,
      ),
      if (accessory != null)
        Positioned(
          left: widthDog * 0.5 + accessory.offsetX - accessory.width * 0.5,
          top: heightDog * 0.5 + accessory.offsetY - accessory.height * 0.5,
          child: Image.asset(
            'assets/images/${user.accessory}.png',
            width: accessory.width,
            height: accessory.height,
          ),
        ),
    ],
  );
}

