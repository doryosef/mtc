module rounded_cube(c=[1,1,1], r=0.1, h=0.4) {
    minkowski(){
      cube(c);
      cylinder(r,h);
    }
}

module half_cylinder(h=1, r=1) {
 intersection() {
     translate([0, -r, 0]) cube([r*2,r*2,h]);
     cylinder(r=r, h=h);
 }   
}

module halfSphere(r=1) {
 intersection() {
     translate([0, -r, -r]) cube([r*2,r*2,r*2]);
     sphere(r=r);
 }   
}

module pin(h=1) {
    hull(){
        cylinder(h=0.1,r=h/2);
        translate([0,0,h]) sphere(r=0.1);
    }
}

module hollow_cylinder(h=1, r=1, shell=0.1) {
    s = 1 - shell;
    difference() {
        cylinder(h=h,r=r);
        translate([0,0,-0.5]) cylinder(h=h+1,r=r*s);
    }
}

module cube_minus_sphere(size=1) {
    difference() {
       translate([-size/2,0.1,-size/2]) cube([size,size/2,size]);
       rotate([0,0,90]) halfSphere(r=size/2);
    }
}

module curve_cube(c=[1,1,1], curve=0.5) {
    difference() {
        rounded_cube(c);
        scale([1, 1, curve]) 
            translate([-1.5,c[1]/2,-c[1]/8]) 
                rotate([0,90,0]) 
                    cylinder(h=c[0]+3,r=c[1]/1.8);
    }    
}
module hook(h=5, d=3) {
    $fn=100;
    cylinder(h,d=d);
    translate([0,0,h]) sphere(d=d);
    
}

module cone(startDia=5, endDia=1, h=5) {
    $fn=200;
    hull() {
        cylinder(h=0.1, d=startDia);
        translate([0,0,endDia]) cylinder(h, d=endDia);
    }
}


module flexScrewHole(screwLength=10, screwDia=5, stretch=10, center=true ) {
    centerX = center ? -stretch/2 : 0;
    translate([centerX,0,0]){
        hull() {
            cylinder(h=screwLength, d=screwDia);
            translate([stretch,0,0]) cylinder(h=screwLength, d=screwDia);
        }
    }
}

module nut() {
    $fn=6;
    cylinder(d=TC_SCREW_NUT_DIA, h=TC_SCREW_NUT_HEIGHT);   
}

module hollow_rounded_cube(c=[1,1,1], shell=2.5, center=true) {
    //center
    centerX = center ? -c[0]/2 : 0;
    centerY = center ? -c[1]/2 : 0;
    translate([centerX,centerY, 0]) {
    
    difference() { 
        rounded_cube(c,0.1, 0.4);
        //inner
        translate([shell/2,shell/2,-.1]) {
            rounded_cube([c[0]-shell,c[1]-shell,c[2]+1],0.1, 0.4);
        }
    }
}
}

module triangle(size=100, height=10) {
 linear_extrude(height=height) polygon(points=[[0,0],[size,0],[0,size]], paths=[[0,1,2]]);
}