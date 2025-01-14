import 'package:flame/components.dart';


var gameWidth = 220.0;
var gameHeight = 1600.0;

// ------ Espace de jeu

var objectZoneSpawnGap = gameWidth*0.1625; //ecart de base avant et après la zone de spawn des objets
var objectGap = gameWidth*0.1; // 3 x 0.1 soit 30% de la largeur

// du centre d'un objet à un autre

var other = gameWidth*0.225;

// 4 objets donc pour 50% de l'espace de jeu -> 50/4 : 12.5

// OBJET POSITIF 

var objectWidth =  gameWidth*0.125;
var objectHeight = objectWidth;

const spawnHeightObjects = 50.0;

var ballRadius = gameWidth * 0.02;

var batWidth = gameWidth * 0.2;
var batHeight = ballRadius * 2;

// Taille par défaut du chien variable par rapport à la taille de l'écran
var dogWidth = dogHeight/2 ;
// var dogHeight = gameHeight/6.5;
var dogHeight = gameHeight/4;

//distance parcourue par la batte à chaque appui sur les flèches du clavier
var batStep = gameWidth * 0.05;  

// coefficient de vitesse
const coeffVitesse = 1.15;
var vitesseJeu = Vector2(0.0, 200.0);
// délai de respawn (par défaut 3 secondes)
double delai = 3;
final List<int> paliersDeScore = [25,50,100,200,300,400,500];
Set<int> paliersAtteints = {}; //Set permet de ne faire l'exécution qu'une fois
