include <startup.scad>;
include <util.scad>;

BASE_SIZE=30;
BASE_HEIGHT=1;

HOLDER_SIZE=10;
HOLDER_HEIGHT=30;

DIVIDER_WITH=3;

PEN_RADIUS=3.5;



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
    }
    // 45 degree grip
        hull() {
            cube([CARRAGE_MOUNT_X, 5, 1]);
            translate([0,0,-4]) rotate([90,0,0]) cube([CARRAGE_MOUNT_X, 5, 1]);
        
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

module penHolder() {
    $fn=200;
   
    rounded_cube([BASE_SIZE,BASE_SIZE,BASE_HEIGHT],0.1, 0.4);
    translate([(BASE_SIZE/2) - (HOLDER_SIZE/2)
    ,BASE_SIZE/2 - (HOLDER_SIZE/2), 0]) {
        difference() {
            union() {
                rounded_cube([HOLDER_SIZE,HOLDER_SIZE,HOLDER_HEIGHT],0.1, 0.4);
                
                //round pen holder outside
                rotate([90,0,0])
                    translate([(HOLDER_SIZE/2), 15, -HOLDER_SIZE-1]) 
                        cylinder(h=HOLDER_SIZE+2, r=PEN_RADIUS+4);
            }
            //round pen holder inside
            rotate([90,0,0]) translate([(HOLDER_SIZE/2), 15, -HOLDER_SIZE-1.5]) {
                cylinder(h=HOLDER_SIZE+3, r=PEN_RADIUS +2);
            }
            //divider
            translate([(HOLDER_SIZE/2) - (DIVIDER_WITH/2), -0.5, 0])
                rounded_cube([DIVIDER_WITH,HOLDER_SIZE+1,HOLDER_HEIGHT+1],0.1, 0.4);
            
            // screw hole
            translate([-DIVIDER_WITH-1, HOLDER_SIZE/2, HOLDER_HEIGHT-4]) rotate([0,90,0]) {
                cylinder(h=HOLDER_SIZE - DIVIDER_WITH +1, d=3);
            }
            // nut hole
            translate([DIVIDER_WITH+1, HOLDER_SIZE/2, HOLDER_HEIGHT-4]) rotate([0,90,0]) {
                $fn=6;
                cylinder(h=HOLDER_SIZE - DIVIDER_WITH +1, d=4.5);
            }
        }
    }
}

module headMount(toolChangerRightSide=false) {
    difference (){
    base();

    //magnets holes
      translate ([CARRAGE_MOUNT_X/2, CARRAGE_MOUNT_Y/2, TOOL_CHANGER_Z - HOOKS_HEIGT -1.1 ]) {
        attachToToolChange(center=true);
    }

        catcherScrews(toolChangerRightSide);
    }
        rotate([0,180,0]) translate([-CARRAGE_MOUNT_X/2 - BASE_SIZE/2, (CARRAGE_MOUNT_Y/2)-(BASE_SIZE/2),-BASE_HEIGHT-0.5]) {
        penHolder();
    }
}




translate([0,0,8])rotate([0,180,0]) headMount(false);

