include <util.scad>;

$fn =50;

//Aluminuim profile 3030
ALUMINUM_SIZE=30;

// carraige mount
CARRAGE_MOUNT_X=35;
CARRAGE_MOUNT_Y=65;
CARRAGE_MOUNT_Z=7;
TOOL_CHANGER_Z=7;

//size
CMS =
[CARRAGE_MOUNT_X,
CARRAGE_MOUNT_Y,
CARRAGE_MOUNT_Z];

// tool changer
toolChangerSize = 
[CARRAGE_MOUNT_X,
CARRAGE_MOUNT_Y,
TOOL_CHANGER_Z];

// tool catcher
TC_BASE_X=ALUMINUM_SIZE;
TC_BASE_Y=5;
TC_BASE_Z=20;
TC_BASE=[TC_BASE_X,TC_BASE_Y,TC_BASE_Z];


//locking in location small rods
RODS_HEIGHT=9;   // real heigt is 12
RODS_DIA=3.5;
RODS_FROM_X_FRONT=6;
RODS_FROM_Y_FRONT=20;
RODS_DISTANCE_FRONT=24;

// HOOKS
HOOKS_HEIGT=6;
HOOKS_DIA=6;

//magnets
MAGNET_DIA=12.5;
MAGNET_HEIGHT=5.5;
MAGNET_DISTANCE=30;

//new magnets
MAGNET_NEW_DIA=20;
MAGNET_NEW_HEIGHT=6;

//Brass Knurl screw
BRASS_KNURL_SCREW_DIA=5;
BRASS_KNURL_SCREW_HEIGHT=5;

//V6 HOT END
v6_DIA=16;
v6_DIA_HEIGHT_DOWN=3;
v6_DIA_HEIGHT_UP=3.7;
v6_INNER_DIA=12;
v6_INNER_HEIGHT=6;

v6_MOUNT_HEIGHT=v6_DIA_HEIGHT_DOWN + v6_INNER_HEIGHT + v6_DIA_HEIGHT_UP - .2;
v6_MOUNT_WIDTH=20;

v6_SECOND_PART_WIDTH=11;

//tool change
TC_SCREW_DISTANCE = 55;
TC_SCREW_LENGTH = 25;
TC_SCREW_HEAD_HEIGHT = 5;
TC_SCREW_HEAD_DIA = 10;
TC_SCREW_DIA = 4;

//nut 
TC_SCREW_NUT_DIA = 8;
TC_SCREW_NUT_HEIGHT = 4;


//tool catcher
TOOL_CATHCER_SCREWS_DISTANCE = ALUMINUM_SIZE/2;

//plastic tie 
PLASTIC_TIE_HEIGHT = 2.2;
PLASTIC_TIE_DEPTH = 3;

//fan mount
FAN_MOUNT_DISTANCE=20;
FAN_MOUNT_TUBE_DIA=5;


module toolChangeScrew() {
//top
cylinder (h=TC_SCREW_HEAD_HEIGHT, d=TC_SCREW_HEAD_DIA);
//body
translate([0,0,TC_SCREW_HEAD_HEIGHT -.1])
cylinder (h=TC_SCREW_LENGTH, d=TC_SCREW_DIA);    
}

module toolChangeScrews(right=true, center=true) {
    r = right ? 180 : 0;
    c = center ? -TC_SCREW_DISTANCE/2 : 0;
    translate([c,0,0]) {
        rotate([r,0,0]) {
            toolChangeScrew();
            translate([TC_SCREW_DISTANCE,0,0])
                toolChangeScrew();
        }
  }
}

module toolChangeScrewsWithNut(right=true, center=true) {
    toolChangeScrews(right, center);
    c = center ? -TC_SCREW_DISTANCE/2 : 0;
    r = right ? -TC_SCREW_LENGTH : TC_SCREW_LENGTH;
    translate([c,0,0]) {
      translate([0,0, r]) nut();
      translate([TC_SCREW_DISTANCE,0,r]) nut();
    }
    
    
}

module M3Screw(length=10) {
    //top
    cylinder (h=3, d=5.5);
    //body
    translate([0,0,3 -.1])
    cylinder (h=length, d=3);
}

module M5Screw(length=10) {
    //top
    cylinder (h=5, d=9);
    //body
    translate([0,0,5 -.1])
    cylinder (h=length, d=5);
}

module brassKnurlScrew() {
    cylinder (h=BRASS_KNURL_SCREW_HEIGHT, d=BRASS_KNURL_SCREW_DIA);
}


module magnet(h=MAGNET_HEIGHT, d=MAGNET_DIA) {
    cylinder (h=MAGNET_HEIGHT, d=MAGNET_DIA);
}

module small_rods_relative(distanceBetweenRodsX=10, distanceBetweenRodsY=10 ,centerRode=true) {
    //up right
    cylinder(h=RODS_HEIGHT, d=RODS_DIA);
    //up left
    translate([distanceBetweenRodsX,0,0])
      cylinder(h=RODS_HEIGHT, d=RODS_DIA);
    //down right
    translate([0,distanceBetweenRodsY,0])
      cylinder(h=RODS_HEIGHT, d=RODS_DIA);
    //down left
    translate([distanceBetweenRodsX,distanceBetweenRodsY,0])
      cylinder(h=RODS_HEIGHT, d=RODS_DIA);
    if(centerRode){
    //center
    translate([distanceBetweenRodsX/2,distanceBetweenRodsY/2,0])
      cylinder(h=RODS_HEIGHT, d=RODS_DIA);
    }
}

module small_hooks_relative(distanceBetweenHooksX=10, distanceBetweenHooksY=10, hooksScale=1) {
    //up right
    scale(hooksScale) hook(h=HOOKS_HEIGT, d=HOOKS_DIA);
    //up left
    translate([distanceBetweenHooksX,0,0])
      scale(hooksScale) hook(h=HOOKS_HEIGT, d=HOOKS_DIA);
    //down right
    translate([0,distanceBetweenHooksY,0])
      scale(hooksScale) hook(h=HOOKS_HEIGT, d=HOOKS_DIA);
    //down left
    translate([distanceBetweenHooksX,distanceBetweenHooksY,0])
      scale(hooksScale) hook(h=HOOKS_HEIGT, d=HOOKS_DIA);
}

module magnetsRelative(distanceBetweenMagnet=15, center=true) {
    
    c = center ? 0 : -distanceBetweenMagnet/2 ;
    translate([c, 0,0 ]){
    
      //up center
      translate ([distanceBetweenMagnet/2, 0,0]) magnet();    
      //translate ([distanceBetweenMagnetX, distanceBetweenMagnetY,0])
       // magnet();
      translate ([-distanceBetweenMagnet/2, 0,0])
        magnet();
    }
}


module tieHole(tieSize=3, depth=10) {
   rotate_extrude(angle=180, $fn=100)
       translate([depth, 0]) circle(tieSize);   
}

module M3nut() {
    $fn=6;
    cylinder(d=6, h=3);
}

module newMagnet() {
    $fn=400;
    cylinder(h=MAGNET_NEW_HEIGHT, d=MAGNET_NEW_DIA);
}

module toolChangerScrewGate() {
    cone(TC_SCREW_DIA+1.5, TC_SCREW_DIA, 2);
}