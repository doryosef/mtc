include <startup.scad>;
include <util.scad>;

X = TC_SCREW_HEAD_DIA*2;
Y = TC_SCREW_HEAD_HEIGHT*2;
Z = TC_SCREW_DISTANCE*1.3;

module base(){
    rounded_cube(TC_BASE,0.1, 0.4);
}

module M3screwsHolderLocation(center=true) {
    centerX = center ? -TOOL_CATHCER_SCREWS_DISTANCE/2 : 0;
    centerY = center ? -TC_BASE_Y/2 : 0;
    screwLength = TC_BASE_Y+3;
     translate([centerX,centerY,0]) {
    hull() {
        cylinder(h=screwLength, d=3);
        translate([0,TOOL_CHANGER_Z/2,0])cylinder(h=screwLength,d=3);
    }
    translate([TOOL_CATHCER_SCREWS_DISTANCE,0,0]) {
        hull(){
        cylinder(h=screwLength, d=3);
        translate([0,TOOL_CHANGER_Z/2,0])cylinder(h=screwLength,d=3);
            
        }
    }
    }
}

module catcherScrews() {
    
    difference() {
        rounded_cube([X,Y,Z],0.1, 0.4);
        translate([X+1.1,Y/2,Z/2]) rotate([0,90,0])toolChangeScrews();
    }
}

module toolChangerCathcer() {
    difference() {
        base(); 
        translate([TC_BASE_X/2,TC_BASE_Y+1,TC_BASE_Z/2]) rotate([90,0,0]) M3screwsHolderLocation();
    }
    //todo chnage this to something else
    hull() {
   translate([10,0,0]) rounded_cube([20,TC_BASE_Y,1],0.1, 0.4);
   translate([TC_BASE_X/2,7,-10]) translate([0,.5,1]) { 
       rounded_cube([X,Y-.5,1],0.1, 0.4);
    }
    }
    
   translate([TC_BASE_X/2,7,-60]) translate([0,0,0]) { 
       catcherScrews();
       
       }
}
//linear_extrude(height = 0.3) projection(cut=false) 
rotate([0,90,0]) toolChangerCathcer();
