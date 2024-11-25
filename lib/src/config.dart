import 'package:flutter/material.dart';               


const gameWidth = 820.0;
const gameHeight = 1600.0;

// ------ Espace de jeu

const objectZoneSpawnGap = gameWidth*0.1; // soit 20% de la largeur
const objectGap = gameWidth*0.1; // 3 x 0.1 soit 30% de la largeur

// d'un objet à un autre

const other = gameWidth*0.225;

// 4 objets donc pour 50% de l'espace de jeu -> 50/4 : 12.5

// OBJET POSITIF 

const goodObjectWidth =  gameWidth*0.125;
const goodObjectHeight = goodObjectWidth;

const ballRadius = gameWidth * 0.02;

const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;

// Taille par défaut du chien variable par rapport à la taille de l'écran
const dogWidth = dogHeight/2 ;
const dogHeight = gameHeight/6.5;

//distance parcourue par la batte à chaque appui sur les flèches du clavier
const batStep = gameWidth * 0.05;  


// Pour les briques 

// espace entre les briques
// const brickGutter = gameWidth * 0.015; 
// // largeur totale des briques
// final brickWidth =
//     (gameWidth - (brickGutter * (brickColors.length + 1)))
//     / brickColors.length;
// // hauteur des briques
// const brickHeight = gameHeight * 0.03;


// coefficient de vitesse
const difficultyModifier = 1.20;