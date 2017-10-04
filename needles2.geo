// Gmsh project created on Mon Aug  7 00:07:16 2017

// cone lin function: (a*x)^2 - y^2 =tz^2, y = sqrt((a*x)^2-tz^2), 
//tz is tip size
// at x = co_Len, y is same as cylinder radius, y=r
// so: a = sqrt(tz^2+r^2)/co_Len
// x10 on line is : x10 = tz/a

x0=100;
y0=0;
z0=0;
lcar = 20;
lcar1 = 2;
tz = 10; //tip size

r = 50;
co_Len = 300;
cy_len = 500;

dis = 1000;  // distance between needles
//
a = Sqrt(tz*tz+r*r)/co_Len;

N = 10; //  Numbers of points on cone spline
dx = (co_Len-tz/a)/N;
N = N-1;

x10 = x0 + tz/a;  // first point on the tip 

p000 = newp; Point(p000) = {0, 0, 0, lcar};
p100 = newp; Point(p100) = {x10, 0, 0, lcar1}; // first point on the tip
xx = x10+dx/100;
p1000 = newp; Point(p1000) = {xx, Sqrt((a*(xx-x0))^2-tz*tz), 0, lcar1}; //  first point on the tip 
xx = x10+dx/10;
p1001 = newp; Point(p1001) = {xx, Sqrt((a*(xx-x0))^2-tz*tz), 0, lcar1}; //  second point on the tip 
xx = x10+4*dx/10;
p1002 = newp; Point(p1002) = {xx, Sqrt((a*(xx-x0))^2-tz*tz), 0, lcar1}; // third point on the tip 
pc = newp;   Point(pc) = {x0+co_Len, 0, 0, lcar};    // center point at end of tip cone

pend =newp;  Point(pend) = {x0+co_Len+cy_len, r, 0, lcar};    // center point at end of tip cone

x = x10; p = newp; 
For i In {p:p+N}
  x += dx;
  Point(i) = {x, Sqrt((a*(x-x0))^2-tz*tz), 0, lcar};
EndFor
p0 = p;

//+
Recursive Delete {
  Point{pc}; Point{p000}; 
}
//+

l1 = newl;
//Spline(l1) = {p1+N:p1,p100,p0:p0+N};
Line(l1) = {pend,p0+N:p0,p1002,p1001,p1000,p100};

Rotate {{1, 0, 0}, {0, 0, 0}, Pi/2} {
  Duplicata { Line{l1}; }
}

Rotate {{1, 0, 0}, {0, 0, 0}, Pi} {
  Duplicata { Line{l1}; }
}

Rotate {{1, 0, 0}, {0, 0, 0}, -Pi/2} {
  Duplicata { Line{l1}; }
}


Extrude {{1, 0, 0}, {0, 0, 0}, Pi/2} {
  Line{l1}; Line{l1+1}; Line{l1+2}; Line{l1+3}; 
}

Line Loop(1) = {6, 9, 12, 15};
Plane Surface(17) = {1};
//+
//+
//ss[] = Surface "*";

////For i In {0: #ss[]-1}:
////	Printf('faces %g', ss[i]);
////EndFor

//+
//Symmetry {1, 0, 0, 1} {
//  Duplicata { Surface{16}; Surface{13}; Surface{7}; Surface{10}; Surface{17}; }
//}
Rotate {{0, 0, 1}, {0, 0, 0}, Pi} {
  Duplicata { Surface{7}; Surface{10}; Surface{13}; Surface{16}; Surface{17}; }
}



Physical Surface(2) = {22, 30, 18, 26, 34};
Physical Surface(1) = {13, 16, 7, 10, 17};


Translate {0, 0, dis} {
  Duplicata { Surface{13}; Surface{16}; Surface{10}; Surface{7}; Surface{17}; }
}

Translate {0, 0, -dis} {
  Duplicata { Surface{13}; Surface{16}; Surface{10}; Surface{7}; Surface{17}; }
}

Translate {0, dis, 0} {
  Duplicata { Surface{22}; Surface{30}; Surface{18}; Surface{26}; Surface{34}; }
}

Translate {0, -dis, 0} {
  Duplicata { Surface{22}; Surface{30}; Surface{18}; Surface{26}; Surface{34}; }
}//+

//+
Physical Surface(3) = {69, 73, 77, 81, 85};
//+
Physical Surface(4) = {86, 94, 90, 98, 102};
//+
Physical Surface(5) = {35, 47, 39, 43, 51};
//+
Physical Surface(6) = {52, 64, 60, 56, 68};
