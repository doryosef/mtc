include <startup.scad>;
include <util.scad>;

X = TC_SCREW_HEAD_DIA*2;
Y = TC_SCREW_HEAD_HEIGHT*2;
Z = TC_SCREW_DISTANCE*1.3;


TC_BASE2_X = 15;
TC_BASE2_Y = 5;
TC_BASE2_Z = 25;
TC_BASE2=[TC_BASE2_X,TC_BASE2_Y,TC_BASE2_Z];
module base(){
    rounded_cube(TC_BASE2,0.1, 0.4);
}

module M5screwsHolderLocation(center=true) {
    centerX = -TC_BASE2_X/2;
    centerY = -TC_BASE2_Y/2 + TC_BASE_Y/2 ;
    screwLength = TC_BASE_Y+3;
    translate([centerX,centerY,0])  {
        hull() {
            translate([0,0,(TC_BASE2_Z/2)*0.8]) 
                rotate([90,0,0]) cylinder(h=screwLength, d=5);
            translate([0,0,-(TC_BASE2_Z/2)*0.3])
                rotate([90,0,0]) cylinder(h=screwLength,d=5);
        }
    }
}


module catcherScrews(right=false) {
    translateScrewStartX = right ? -1.1 : X+1.1;
    difference() {
        rounded_cube([X,Y,Z],0.1, 0.4);
        translate([translateScrewStartX ,Y/2,Z/2]) {
            rotate([0,-90,0]) toolChangeScrews(right);
        }
    }


}

module toolChangerCathcer2(right=false) {
    difference() {
        base(); 
        translate([TC_BASE_X/2,TC_BASE_Y+1+.1,TC_BASE_Z/2]) M5screwsHolderLocation();

    }
    //todo chnage this to something else
    hull() {
   rounded_cube([15,TC_BASE_Y,1],0.1, 0.4);
   translate([0,20,-10]) translate([0,.5,1]) { 
       rounded_cube([X,Y-.5,1],0.1, 0.4);
    }
    }
    
   translate([0,20,-80]) translate([0,0,0]) { 
       catcherScrews(right);
       }
}
//linear_extrude(height = 0.6) projection(cut=false)
//rotate([0,-90,0]) 
toolChangerCathcer2(true);