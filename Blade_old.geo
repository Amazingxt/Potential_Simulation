// Gmsh project created on Mon Aug  7 00:07:16 2017

// cone lin function: (a*x)^2 - y^2 =tz^2, y = sqrt((a*x)^2-tz^2), 
//tz is tip size
// at x = co_Len, y is same as cylinder radius, y=r
// so: a = sqrt(tz^2+r^2)/co_Len
// x10 on line is : x10 = tz/a

x0=524;  // 
y0=0;
z0=0;    // postion 
lcar = 200;  // mesh size
lcar1 = 20;  // mesh size
tz = 50; //tip size

r = 100;  // radius of cylinder
co_Len = 1000;  // length of cone (tip)
cy_len = 3000;  // lenght of cylinder

dis = 1000;  // distance between needles
N = 10; //  Numbers of points on cone spline


//
a = Sqrt(tz*tz+r*r)/co_Len;


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

x = x10; p = newp; 
For i In {p:p+N}
  x += dx;
  Point(i) = {x, Sqrt((a*(x-x0))^2-tz*tz), 0, lcar};
EndFor
p0 = p;

x = x10;p = newp; 
For i In {p:p+N}
  x += dx;
  Point(i) = {x, -Sqrt((a*(x-x0))^2-tz*tz), 0, lcar};
EndFor
pp0 = p;

xx = x10+4*dx/10;
pp1002 = newp; Point(pp1002) = {xx, -Sqrt((a*(xx-x0))^2-tz*tz), 0, lcar1}; // third point on the tip 

xx = x10+dx/10;
pp1001 = newp; Point(pp1001) = {xx, -Sqrt((a*(xx-x0))^2-tz*tz), 0, lcar1}; //  second point on the tip 

xx = x10+dx/100;
pp1000 = newp; Point(pp1000) = {xx, -Sqrt((a*(xx-x0))^2-tz*tz), 0, lcar1}; //  first point on the tip 


pend =newp;  Point(pend) = {x0+co_Len+cy_len, r, 0, lcar};    // center point at end of tip cone
pend1 =newp;  Point(pend1) = {x0+co_Len+cy_len, -r, 0, lcar};    // center point at end of tip cone

//+
Recursive Delete {
  Point{pc}; Point{p000}; 
}
//+

//l0 = newl;
//Line(l0) = {p0+N:p0,p1002,p1001,p1000,p100};
l1 = newl;
Line(l1) = {pend,p0+N:p0,p1002,p1001,p1000,p100};

//Printf ('l1 is %d',l1);
l2 = newl;
Line(l2) = {p100,pp1000,pp1001,pp1002,pp0:pp0+N,pend1};
l3 = newl;
Line(l3) = {pend1,pend};
//l4 = newl;
//Line(l4) = {,p0+N};
//ll = newll;
//Line Loop(ll)={l1,l2,l3};
////+
//Ruled Surface(1) = {ll};
////+
Extrude {0, 0, -250} {
  Line{-l1};Line{-l3}; Line{-l2}; 
}

//+
Line Loop(1) = {1, 2, 3};
//+
Plane Surface(16) = {1};
//+
Line Loop(2) = {12, 4, 8};
//+
Plane Surface(17) = {2};


//+
Surface Loop(1) = {11, 16, 7, 17, 15};
//+
Volume(1) = {1};
//+
Rotate {{0, 0, 1}, {0, 0, 0}, Pi/3} {
  Duplicata { Volume{1}; }
}
Rotate {{0, 0, 1}, {0, 0, 0}, Pi} {
  Duplicata { Volume{1}; }
}
Rotate {{0, 0, 1}, {0, 0, 0}, 4*Pi/3} {
  Duplicata { Volume{1}; }
}
//+
//+
//+

//+
Physical Surface(1) = {57, 53, 48, 44, 39, 17, 7, 16, 15, 11};
//+
Physical Surface(2) = {28, 37, 33, 24, 19, 68, 77, 64, 73, 59};
