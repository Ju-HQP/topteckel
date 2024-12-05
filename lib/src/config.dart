import 'package:flame/components.dart';
import 'package:flutter/material.dart';               


const gameWidth = 820.0;
const gameHeight = 1600.0;

// ------ Espace de jeu

const objectZoneSpawnGap = gameWidth*0.1625; //ecart de base avant et après la zone de spawn des objets
const objectGap = gameWidth*0.1; // 3 x 0.1 soit 30% de la largeur

// du centre d'un objet à un autre

const other = gameWidth*0.225;

// 4 objets donc pour 50% de l'espace de jeu -> 50/4 : 12.5

// OBJET POSITIF 

const goodObjectWidth =  gameWidth*0.125;
const goodObjectHeight = goodObjectWidth;

const spawnHeightObjects = 50.0;

const ballRadius = gameWidth * 0.02;

const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;

// Taille par défaut du chien variable par rapport à la taille de l'écran
const dogWidth = dogHeight/2 ;
const dogHeight = gameHeight/6.5;

//distance parcourue par la batte à chaque appui sur les flèches du clavier
const batStep = gameWidth * 0.05;  

// coefficient de vitesse
const coeffVitesse = 1.50;
var vitesseJeu = Vector2(0.0, 400.0);
// délai de respawn (par défaut 3 secondes)
double delai = 3;
final List<int> paliersDeScore = [5,10,20,30,50];
Set<int> paliersAtteints = {}; //Set permet de ne faire l'exécution qu'une fois
