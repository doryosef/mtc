include <startup.scad>;
include <util.scad>;

X = 16;
Y = TC_SCREW_HEAD_HEIGHT*3;
Z = TC_SCREW_DISTANCE*1.3;

echo( Z);


TC_BASE2_X = 30;
TC_BASE2_Y = 3;
TC_BASE2_Z = 30;
TC_BASE2=[TC_BASE2_X,TC_BASE2_Y,TC_BASE2_Z];
module base(){
    rounded_cube(TC_BASE2,0.1, 0.4);
}
  

module M5screwsHolderLocation(center=true) {
    screwLength = TC_BASE_Y+3;
    SCREW_DIA = 5;
    rotate([90,90,0]) flexScrewHole(screwLength, SCREW_DIA, (TC_BASE2_Z/3));    
}


module catcherScrews(right=false) {
    translateScrewStartX = right ? -1.1 : X+1.1;
    difference() {
        rounded_cube([10,Y,Z],0.1, 0.4);
        translate([translateScrewStartX ,Y/2,Z/2]) {
            rotate([0,-90,0]) toolChangeScrews(right);
        }
    }
}
module profileMount() {
    bottom_layer_z_height = 4;
    difference() {
        translate([0,0,bottom_layer_z_height]) base(); 
        translate([TC_BASE2_X/2,TC_BASE2_Y+2,TC_BASE2_Z/2 + bottom_layer_z_height])
            M5screwsHolderLocation();
    }
    rounded_cube([TC_BASE2_X,TC_BASE2_Y,bottom_layer_z_height],0.1, 0.4);
    translate([0,1,1]) rotate([90,0,0]) difference() {
        translate([0,0,1]) base(); 
        translate([TC_BASE2_X/2,TC_BASE2_Y+2,TC_BASE2_Z/2]) M5screwsHolderLocation();
    }
}


module toolChangerCathcer2(right=false) {
    profileMount();
    translate([TC_BASE2_X -10,0,0]) rounded_cube([TC_SCREW_HEAD_DIA,50+ Y,10],0.1, 0.4);
    translate([TC_BASE2_X -10,50,-4]) rounded_cube([TC_SCREW_HEAD_DIA,Y,4],0.1, 0.4);
    translate([TC_BASE2_X -10,50,-74]){
        difference() {
            catcherScrews(right);
            
            // locking alcove
            translate([6,10,-1]) 
                rotate([90,-90,0]) half_cylinder(h=5, r=3);
   }
   
   }
   //griping triangle
translate([TC_BASE2_X+1,TC_BASE2_X +20,1]) rotate([180,90,]) triangle(65,5);   
}


//linear_extrude(height = 0.6) projection(cut=false)
//rotate([0,90,0]) 
toolChangerCathcer2(true);
