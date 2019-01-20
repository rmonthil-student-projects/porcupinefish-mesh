// Gmsh project created on Wed Oct 17 14:27:41 2018
// Made with the 4.1.0 version of gmsh.

SetFactory("OpenCASCADE");

//-----------------------------------------------/
//+ Parameters ///////////////
//-----------------------------------------------/

nonInflate = 1;
inflate = 0;

inflateX = inflate * 0.3;
inflateY = inflate * 1.5;
inflateZ = inflate * 1.5;

//-----------------------------------------------/
//+ Parameters ///////////////
//-----------------------------------------------/

finW = DefineNumber[ 0.005 , Min 0, Max 1, Step 0.0001,
  Name "Epaisseur des nagoires" ];

lFish = DefineNumber[ 0.01 , Min 0, Max 1, Step 0.001,
  Name "Taille des mailles proches du poisson" ];
lFar = DefineNumber[ 0.1 , Min 0, Max 1, Step 0.001,
  Name "Taille des mailles loin du poisson" ];
nMaiNag = DefineNumber[ 21 , Min 0, Max 1000, Step 1,
  Name "Nombre de mailles nageoire" ];
  
dyTale = DefineNumber[ 0.02 , Min -1, Max 1, Step 0.0001,
  Name "Orientation queu" ];
dyLeft = DefineNumber[ 0.02 , Min -1, Max 1, Step 0.0001,
  Name "Orientation nageoire gauche" ];
dyRight = DefineNumber[ -0.02 , Min -1, Max 1, Step 0.0001,
  Name "Orientation nageoire droite" ];

//-----------------------------------------------/
//+ Function ///////////////
//-----------------------------------------------/

z = 0;

Function Fin

	/*
	* x, y, z, l, dl, hSim
	*/

	// Creating Points.
	Point(poId) = {x-l-dl, y+dy, z+h/2*hSim, 1.0};
	Point(poId+1) = {x, y, z, 1.0};
	Point(poId+2) = {x-l, y+dy, z-h/2/hSim, 1.0};

	// Creating Curve.
	Spline(spliId) = {poId, poId+1, poId+2, poId};

	// Creating Surface.
	Curve Loop(cuId) = {spliId};
	//Transfinite Curve {cuId} = nMaiNag Using Progression 1;
	Plane Surface(suId) = {cuId};
	//Transfinite Surface {suId};
	//Recombine Surface {suId};
	
	// Creating Volumes.
	Extrude {0, finW, 0} {
	  Surface{suId}; //Recombine;
	}
	Extrude {0, -finW, 0} {
	  Surface{suId}; //Recombine;
	}

Return

//-----------------------------------------------/
//+ Body /////////////////////
//-----------------------------------------------/

Sphere(1) = {0, 0, 0, 0.075, -Pi/2, Pi/2, 2*Pi};
Dilate {{0, 0, 0}, {3.*(1. + inflateX), 1.*(1. + inflateY), 0.8*(1. + inflateZ)}} {
  Volume{1}; 
}
Sphere(2) = {0.05*(1. + inflateX), 0, -0.01*(1. + inflateZ), 0.095, -Pi/2, Pi/2, 2*Pi};
Dilate {{0, 0, 0}, {2.*(1. + inflateX), 1.*(1. + inflateY), 1.*(1. + inflateZ)}} {
  Volume{2}; 
}

//-----------------------------------------------/
//+ Tale ////////////////////
//-----------------------------------------------/

poId = 7;
spliId = 9;
cuId = 9;
suId = 9;

x = -0.21*(1. + inflateX);
y = 0;
dy = dyTale;

l = 0.06;
h = 0.1;
dl = 0.01;
hSim = 1.5;

Call Fin;

//-----------------------------------------------/
//+ Left Fin ////////////////////
//-----------------------------------------------/

poId = 70;
spliId = 90;
cuId = 90;
suId = 90;

x = 0.08*(1. + inflateX);
y = 0.08*(1. + inflateY);
dy = dyLeft;

l = 0.06;
h = 0.1;
dl = 0.01;
hSim = 1.5;

Call Fin;

//-----------------------------------------------/
//+ Right Fin ////////////////////
//-----------------------------------------------/

poId = 700;
spliId = 900;
cuId = 900;
suId = 900;

x = 0.08*(1. + inflateX);
y = -0.08*(1. + inflateY);
dy = dyRight;

l = 0.06;
h = 0.1;
dl = 0.01;
hSim = 1.5;

Call Fin;

//-----------------------------------------------/
//+ Up Fin ////////////////////
//-----------------------------------------------/

poId = 7000;
spliId = 9000;
cuId = 9000;
suId = 9000;

x = -0.15*(1. + inflateX);
y = 0.0;
z = 0.035*(1. + inflateZ);
dy = 0.0;

l = 0.06;
h = 0.08;
dl = 0.01;
hSim = 1.5;

Call Fin;

Rotate {{0, 1, 0}, {x, y, z}, Pi/4} {
  Volume{10}; Volume{9}; 
}

//-----------------------------------------------/
//+ Down Fin ////////////////////
//-----------------------------------------------/

poId = 70000;
spliId = 90000;
cuId = 90000;
suId = 90000;

x = -0.13*(1. + inflateX);
y = 0.0;
z = -0.035*(1. + inflateZ);
dy = 0.0;

l = 0.06;
h = 0.08;
dl = 0.01;
hSim = 1.5;

Call Fin;

Rotate {{0, 1, 0}, {x, y, z}, -Pi/4} {
  Volume{12}; Volume{11}; 
}


//-----------------------------------------------/
//+ Gen Domain ////////////////////
//-----------------------------------------------/

Box(100) = {-1.25*(1. + inflateX), -0.5*(1. + inflateY), -0.5*(1. + inflateZ), 2*(1. + inflateX), 1*(1. + inflateY), 1*(1. + inflateZ)};


//-----------------------------------------------/
//+ Bool Operations ////////////////////
//-----------------------------------------------/

BooleanUnion{ Volume{1}; Delete; }{ Volume{2}; Delete; }

BooleanDifference{ Volume{4}; Delete; }{ Volume{101}; }
BooleanDifference{ Volume{3}; Delete; }{ Volume{101}; }

BooleanDifference{ Volume{6}; Delete; }{ Volume{101}; }
BooleanDifference{ Volume{5}; Delete; }{ Volume{101}; }

BooleanDifference{ Volume{8}; Delete; }{ Volume{101}; }
BooleanDifference{ Volume{7}; Delete; }{ Volume{101}; }

BooleanDifference{ Volume{10}; Delete; }{ Volume{101}; }
BooleanDifference{ Volume{9}; Delete; }{ Volume{101}; }

BooleanDifference{ Volume{12}; Delete; }{ Volume{101}; }
BooleanDifference{ Volume{11}; Delete; }{ Volume{101}; }

// Head

Sphere(20) = {0.34*(1. + 0.2 * inflateX), 0, -0.01*(1. + inflateZ), 0.08, -Pi/2, Pi/2, 2*Pi};
Dilate {{0, 0, 0}, {0.7*(1. + 1.2 * inflateX), 0.9*(1. + inflateY), 1.*(1. + 0.9*inflateZ)}} {
  Volume{20}; 
}

// Bosse
Sphere(21) = {0.27*(1. + 1.5*inflateX), 0, 0.035*(1. + 0.*inflateZ), 0.03, -Pi/2, Pi/2, 2*Pi};
Dilate {{0, 0, 0}, {1, 1.5, 1}} {
  Volume{21}; 
}

// Mouth
Sphere(22) = {0.295*(1. + 1.5*inflateX), 0, -0.03*(1. + 0.*inflateZ), 0.025, -Pi/2, Pi/2, 2*Pi};
Dilate {{0, 0, 0}, {0.95, 1.5, 1}} {
  Volume{22}; 
}

// Eyes
Sphere(23) = {0.25*(1. + 1.7*inflateX), 0.05*(1. + inflateY), 0., 0.025, -Pi/2, Pi/2, 2*Pi};
Sphere(24) = {0.25*(1. + 1.7*inflateX), -0.05*(1. + inflateY), 0., 0.025, -Pi/2, Pi/2, 2*Pi};

BooleanUnion{ Volume{101}; Delete; }{ 
	
	// Fins
	Volume{4}; Volume{3}; 
	Volume{5}; Volume{6}; 
	Volume{8}; Volume{7}; 
	Volume{10}; Volume{9}; 
	Volume{12}; Volume{11};
	
	// Head
	Volume{20};
	Volume{21};
	Volume{22};
	Volume{23};
	Volume{24};
	
	Delete; 
}

If(inflate)
	Sphere(25) = {0.12, 0, -0.2, 0.28, -Pi/2, Pi/2, 2*Pi};
EndIf

If(inflate)
	BooleanUnion{ Volume{101}; Delete; }{ Volume{25}; Delete; }
EndIf

//-----------------------------------------------/
//+ Fillet ////////////////////
//-----------------------------------------------/ 

If(nonInflate)
	Fillet{101}{90020}{0.12}
	Fillet{101}{90091, 90085}{0.03}
	Fillet{101}{90030, 90031}{0.04}
EndIf

If(inflate)
	/*Fillet{101}{90045, 90058}{0.01}
	Fillet{101}{90050, 90045}{0.01}
	Fillet{101}{90071}{0.01}
	Fillet{101}{90025, 90023}{0.01}
	Fillet{101}{90139, 90143, 90136, 90141}{0.01}*/
EndIf

//-----------------------------------------------/
//+ Pics ////////////////////
//-----------------------------------------------/ 

num = 101;

If(inflate)	
	N = 10;
	
	For i In {1:N}
		For j In {1:N}
			Cone(30) = {0.1, 0, -0.17, 0.38, 0, 0, 0.06, 0.01, 2*Pi};
			Rotate {{0, 1, 0}, {0.1, 0, -0.12}, 2.*Pi*i/N} {
			  Volume{30}; 
			}
			Rotate {{0, 0, 1}, {0.1, 0, -0.12}, 2.*Pi*j/N} {
			  Volume{30}; 
			}
			num = BooleanUnion{ Volume{num}; Delete; }{ Volume{30}; Delete; };
		EndFor
	EndFor
EndIf

//-----------------------------------------------/
//+ Length ////////////////////
//-----------------------------------------------/

pf() = PointsOf{ Volume{100}; };
Characteristic Length{pf()} = lFar;

pv() = PointsOf{ Volume{num}; };
Characteristic Length{pv()} = lFish;

BooleanDifference{ Volume{100}; Delete; }{ Volume{num}; Delete; }

//-----------------------------------------------/
//+ Adding Physical Groups ////////////////////
//-----------------------------------------------/

If(nonInflate)
	Physical Volume("vol") = {100};
	Physical Surface("inlet") = {90062};
	Physical Surface("outlet") = {90057};
	Physical Surface("walls") = {90061, 90058, 90060, 90059};
	Physical Surface("fish") = {90021, 90020, 90026, 90031, 90019, 90027, 90028, 90029, 90024, 90030, 90018, 90017, 90015, 90022, 90014, 90016, 90051, 90052, 90034, 90056, 90055, 90033, 90054, 90053, 90023, 90025, 90035, 90039, 90036, 90044, 90040, 90032, 90037, 90045, 90046, 90038, 90043, 90041, 90042, 90050, 90049, 90047, 90048};
EndIf

If(inflate)
	Physical Volume("vol") = {100};
	Physical Surface("inlet") = {90265};
	Physical Surface("outlet") = {90260};
	Physical Surface("walls") = {90261, 90263, 90264, 90262};
	Physical Surface("fish") = {90255, 90247, 90161, 90173, 90158, 90172, 90248, 90228, 90157, 90254, 90245, 90221, 90141, 90253, 90160, 90149, 90060, 90142, 90122, 90159, 90123, 90246, 90059, 90148, 90124, 90235, 90168, 90139, 90234, 90169, 90147, 90027, 90057, 90125, 90058, 90026, 90025, 90236, 90170, 90140, 90109, 90177, 90156, 90231, 90046, 90225, 90178, 90047, 90237, 90244, 90102, 90048, 90115, 90106, 90155, 90219, 90138, 90243, 90127, 90128, 90126, 90238, 90112, 90024, 90129, 90100, 90137, 90167, 90023, 90154, 90016, 90153, 90216, 90259, 90130, 90174, 90239, 90257, 90240, 90045, 90022, 90233, 90224, 90061, 90131, 90132, 90114, 90249, 90163, 90175, 90185, 90036, 90220, 90038, 90035, 90105, 90097, 90037, 90143, 90258, 90039, 90040, 90164, 90041, 90184, 90101, 90176, 90214, 90232, 90252, 90095, 90042, 90029, 90113, 90031, 90152, 90179, 90250, 90062, 90144, 90146, 90186, 90212, 90030, 90021, 90032, 90049, 90162, 90093, 90034, 90033, 90028, 90187, 90051, 90107, 90226, 90104, 90043, 90223, 90165, 90050, 90052, 90063, 90180, 90242, 90053, 90054, 90136, 90019, 90230, 90111, 90189, 90070, 90145, 90014, 90251, 90133, 90020, 90181, 90064, 90089, 90134, 90208, 90151, 90067, 90166, 90044, 90135, 90071, 90120, 90119, 90227, 90108, 90222, 90103, 90241, 90069, 90190, 90118, 90117, 90229, 90110, 90065, 90055, 90182, 90086, 90205, 90072, 90191, 90066, 90183, 90256, 90150, 90081, 90200, 90088, 90087, 90207, 90206, 90017, 90121, 90018, 90116, 90099, 90218, 90080, 90092, 90211, 90199, 90098, 90083, 90091, 90202, 90082, 90217, 90201, 90210, 90073, 90192, 90068, 90085, 90204, 90188, 90096, 90056, 90094, 90215, 90203, 90213, 90084, 90171, 90015, 90209, 90090, 90198, 90079, 90074, 90193, 90075, 90197, 90078, 90194, 90077, 90196, 90076, 90195};
EndIf

