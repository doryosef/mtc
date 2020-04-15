include <startup.scad>;
include <util.scad>;

END_STOP_FROM_TOP = 20;

// END STOP
END_STOP_HEGIT=CARRAGE_MOUNT_Z-5;
END_STOP_X=10;
END_STOP_Y=26;

// TOP
TOP_X = 16;
TOP_Y = 25;
TOP_Z = CARRAGE_MOUNT_Z;

TOP_INNER_X=5;
TOP_INNER_Y=15;
TOP_INNER_OFFSET_FROM_BOTTOM = 5;



module endStopBase() {
    difference() {
        rounded_cube([END_STOP_X, END_STOP_Y, END_STOP_HEGIT],0.1, 0.4);
        translate([END_STOP_X/2,END_STOP_Y-3,-.1]) {
            cylinder(h=END_STOP_HEGIT+1, d=3);
            translate([0,-19.5,0]) cylinder(h=END_STOP_HEGIT+1, d=3);
        }
    }
}


module base(){
    rounded_cube(CMS,0.1, 0.4);
}

module attachToCarriageX() {
    small_rods_relative(RODS_DISTANCE_FRONT,RODS_DISTANCE_FRONT, true);
}

module top() {
    difference(){
        hull() {
          rounded_cube([TOP_X,TOP_Y,TOP_Z],0.1, 0.4);
          translate([TOP_X/2,TOP_Y,0])
          cylinder(d=TOP_X+2,h=TOP_Z);
        }
        translate([TOP_X/2,TOP_Y,0]) 
            translate([0,3,-.5]) 
                cylinder(d=3, h=TOP_Z+1);
        translate([TOP_X/2,TOP_INNER_OFFSET_FROM_BOTTOM,-.1]) 
            hull() {
                cylinder(d=TOP_INNER_X,h=TOP_Z+1);
                translate([0,TOP_INNER_Y,0]) 
                  cylinder(d=TOP_INNER_X,h=TOP_Z+1);
            }
            //cube([TOP_INNER_X,TOP_INNER_Y,TOP_Z+1]);
    }
}

module carrgeMount() { 
    difference(){
      base();
        // attach to X carriage rods
      translate ([RODS_FROM_X_FRONT, RODS_FROM_Y_FRONT, -.1]) {
        attachToCarriageX();
      }
  translate ([CARRAGE_MOUNT_X/2, CARRAGE_MOUNT_Y/2, CARRAGE_MOUNT_Z ]) {
      translate ([0, 0, -MAGNET_HEIGHT+0.11]) {   
         rotate([0,0,90]) magnetsRelative(MAGNET_DISTANCE, true);
      }
  }

    }
  translate ([CARRAGE_MOUNT_X/2, CARRAGE_MOUNT_Y/2, CARRAGE_MOUNT_Z ]) {
      relativeBetweenRods=25;
      translate([-relativeBetweenRods/2, -relativeBetweenRods/2-8, -2]) {
      small_hooks_relative(25,40); 
      }       
    }
//end stop mount
  translate ([0, CARRAGE_MOUNT_Y - END_STOP_Y - END_STOP_FROM_TOP -.5,
CARRAGE_MOUNT_Z-END_STOP_HEGIT ]) {
  translate ([CARRAGE_MOUNT_X+1,0,0]) endStopBase();
  translate ([-END_STOP_X-1,0,0]) endStopBase();
}

//top
translate([( CARRAGE_MOUNT_X/2) - (TOP_X/2),CARRAGE_MOUNT_Y,0,]) {
    top();
}

}

//linear_extrude(height = 0.5) projection()
carrgeMount();
