include <startup.scad>;
include <util.scad>;

module base(){
    rounded_cube(toolChangerSize,0.1, 0.4);
}

module attachToToolChange(relativeBetweenRods=25, center=false) {
    c = center ? -relativeBetweenRods/2 : 0;
    translate([c, c, 0]) {
  // attach to head mount hooks
    translate([0, -7.5, 0]) small_hooks_relative(25,40, 1.1);
  //magnets holes
  translate ([relativeBetweenRods/2, relativeBetweenRods/2, HOOKS_HEIGT+1.3 - MAGNET_NEW_HEIGHT]) {   
     newMagnet();
  }
  }
}

module v6HotendHolder() {
    $fn=100;
    cylinder(d=v6_DIA, h=v6_DIA_HEIGHT_DOWN+.1);
    translate([0,0,v6_DIA_HEIGHT_DOWN]) {
       cylinder(d=v6_INNER_DIA, h=v6_INNER_HEIGHT+.1);
        translate([0,0,v6_INNER_HEIGHT]) {
            cylinder(d=v6_DIA, h=v6_DIA_HEIGHT_UP);
        }
    }
}

leftScrewLocation = 
    [(CARRAGE_MOUNT_X/2) + (v6_DIA/2) + (CARRAGE_MOUNT_X - v6_DIA)/4, 
    v6_MOUNT_WIDTH +.1, v6_MOUNT_HEIGHT/2 ];

rightScrewLocation = 
    [(CARRAGE_MOUNT_X/2) - (v6_DIA/2) - ((CARRAGE_MOUNT_X - v6_DIA)/4), 
    v6_MOUNT_WIDTH +.1, v6_MOUNT_HEIGHT/2 ];

module v6TopMount() {
    difference() {
        cube([CARRAGE_MOUNT_X, v6_MOUNT_WIDTH, v6_MOUNT_HEIGHT ]);
        translate([CARRAGE_MOUNT_X/2,v6_MOUNT_WIDTH ,-.1]){
            v6HotendHolder();
        }
    translate(leftScrewLocation) rotate([90,0,0]) brassKnurlScrew();
    translate(rightScrewLocation) rotate([90,0,0]) brassKnurlScrew();
        
        // cables holder
        cableCylinderDia=8;
        translate([CARRAGE_MOUNT_X-1, 10, -.5]) 
            cylinder(h=v6_MOUNT_HEIGHT+1, d=cableCylinderDia);    
    }
    // 45 degree grip
        hull() {
            cube([CARRAGE_MOUNT_X, 5, 1]);
            translate([0,0,-4]) rotate([90,0,0]) cube([CARRAGE_MOUNT_X, 5, 1]);
    }
}

module V6SecondPart() {
    difference() {
        cube([CARRAGE_MOUNT_X, v6_SECOND_PART_WIDTH, v6_MOUNT_HEIGHT ]);
        translate([CARRAGE_MOUNT_X/2,0,-.1]){
            v6HotendHolder();
        }
        translate([0,v6_SECOND_PART_WIDTH - v6_MOUNT_WIDTH,0]) {
        translate(leftScrewLocation) {
            rotate([90,0,0]) M3Screw(v6_SECOND_PART_WIDTH);
        }
        translate(rightScrewLocation) {
            rotate([90,0,0]) M3Screw(v6_SECOND_PART_WIDTH);
        }
    }
    }
}

module catcherScrews(toolChangerRightSide=false) {
    toolChangeLocationX = 
      toolChangerRightSide ? 
        CARRAGE_MOUNT_X+TC_SCREW_HEAD_HEIGHT+2 : 
        - TC_SCREW_HEAD_HEIGHT-2;
    
    toolChangeGateLocationX = 
      toolChangerRightSide ? 
        CARRAGE_MOUNT_X+2: 
        -2;
    
        translate ([toolChangeLocationX , CARRAGE_MOUNT_Y/2,
    TOOL_CHANGER_Z/2]) {
        rotate([90,0,90]) toolChangeScrews(toolChangerRightSide, true);
        }
        translate([toolChangeGateLocationX ,CARRAGE_MOUNT_Y/2,CARRAGE_MOUNT_Z/2]) {
            translate([0,TC_SCREW_DISTANCE/2,]) rotate([0,90,0]) 
                toolChangerScrewGate();
            translate([0,-TC_SCREW_DISTANCE/2,]) rotate([0,90,0]) 
                toolChangerScrewGate();
    }
}

module headMount(toolChangerRightSide=false) {
    difference (){
    base();
    //m3 nuts    
    translate([CARRAGE_MOUNT_X/2,1.9,3.5]) rotate([90,0,0]) nuts_mount();
    translate([CARRAGE_MOUNT_X/2,CARRAGE_MOUNT_Y+1,3.5]) rotate([90,0,0]) nuts_mount();
        
    //plastic ties 
    tieLocation = toolChangerRightSide ? 0 : CARRAGE_MOUNT_X-1;
    plasticTieRotateY = toolChangerRightSide ? 45 : -45;
    translate([tieLocation,6,0]) {rotate([90,plasticTieRotateY,0])    {
        tieHole(PLASTIC_TIE_HEIGHT,PLASTIC_TIE_DEPTH);
    }}
    //magnets holes
      translate ([CARRAGE_MOUNT_X/2, CARRAGE_MOUNT_Y/2, TOOL_CHANGER_Z - HOOKS_HEIGT -1.1 ]) {
        attachToToolChange(center=true);
    }

        catcherScrews(toolChangerRightSide);
    }
        translate([0,20,0]) rotate([-90,0,0]) {
        v6TopMount();
        //translate([0,v6_MOUNT_WIDTH+10,0]) V6SecondPart();
    }
    

}

module nuts_mount() {
    translate([-FAN_MOUNT_DISTANCE/2,0,0]) 
        M3nut();
    translate([FAN_MOUNT_DISTANCE/2,0,0])
        M3nut();
}

//translate([0,0,8])rotate([0,180,0]) 
headMount(false);
//translate([10,20,11]) rotate([-90,0,0]) V6SecondPart();

