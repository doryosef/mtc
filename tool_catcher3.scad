include <startup.scad>;
include <util.scad>;

X = TC_SCREW_HEAD_DIA*2;
Y = TC_SCREW_HEAD_HEIGHT*2;
Z = TC_SCREW_DISTANCE*1.3;

M5=5;

TC_BASE3_X = 40;
TC_BASE3_Y = ALUMINUM_SIZE*2;
TC_BASE3_Z = 6;
TC_BASE3=[TC_BASE3_X,TC_BASE3_Y,TC_BASE3_Z];
module base(){
    rounded_cube(TC_BASE3,0.1, 0.4);
}

module profileMount(){
    difference() {
        rounded_cube(TC_BASE3,0.1, 0.4);
        translate([TC_BASE3_X/2, TC_BASE3_Y/2,-0.1]) {
            translate([TC_BASE3_X*0.3, 0,0]) screwsHolderLocation(distance=TC_BASE3_Y*0.7, diameter=M5);
            translate([-TC_BASE3_X*0.3, 0,0]) screwsHolderLocation(distance=TC_BASE3_Y*0.7, diameter=M5);
        }
        
    }
}
/*
module M5screwsHolderLocation(center=true) {
    centerX = -TC_BASE3_X/2;
    centerY = -TC_BASE3_Y/2 + TC_BASE_Y/2 ;
    screwLength = TC_BASE_Y+3;
    translate([centerX,centerY,0])  {
        hull() {
            translate([0,0,(TC_BASE3_Z/2)*0.8]) 
                rotate([90,0,0]) cylinder(h=screwLength, d=5);
            translate([0,0,-(TC_BASE3_Z/2)*0.3])
                rotate([90,0,0]) cylinder(h=screwLength,d=5);
        }
    }
}
*/
module screwsHolderLocation(distance=TC_BASE3_Y, diameter=5) {
    screwLength = TC_BASE3_Z+3;
    translate([0,-distance/2,0]){
hull() {
            cylinder(h=screwLength, d=diameter);
        translate([0,distance,0])
            cylinder(h=screwLength,d=diameter);
        }
    } 
}



module catcherScrews(right=false) {
    translateX = right ? -1.1 : X+1.1;
    difference() {
        rounded_cube([X,Y,Z],0.1, 0.4);
        translate([translateX ,Y/2,Z/2]) rotate([0,-90,0]) toolChangeScrewsWithNut(right);
    }
}

module toolChangerCathcer3(right=false) {
    translate([0,-TC_BASE3_Y,0]) profileMount();
   hull() {
        rounded_cube([TC_BASE3_X ,1,TC_BASE3_Z ],0.1, 0.4);
       
       translate([TC_BASE3_X/2 - X/2,45,0])
       rounded_cube([X,1,TC_BASE3_Z ],0.1, 0.4);
    }
    
   translate([TC_BASE3_X/2 - X/2,35,0]){
       translate([0,0,-15]) rounded_cube([X,Y,15],0.1, 0.4);
      translate([0,0,-65]) 
       catcherScrews(right);
       
       }
}
//linear_extrude(height = 0.6) projection(cut=false)
toolChangerCathcer3();

//profileMount();
