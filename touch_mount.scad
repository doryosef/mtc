include <startup.scad>;
include <util.scad>;

TOUCH_MOUNT_X=23;
TOUCH_MOUNT_Y=8;
TOUCH_MOUNT_Z=7;

WALL_HEIGHT=15;
WALL_WEIGHT=40;
WALL_LENGTH=2;

TOUCH_OFFSET=1.5;

CARRAGE_SCREW_DIA=3;

TOUCH_SCREW_DIA=3;

TOUCH_SCREW_DISTANCE=18;

GRIP_SIZE=5;

module grip() {
    hull() {
        cylinder(d=3, h=WALL_HEIGHT - TOUCH_MOUNT_Z -  TOUCH_OFFSET - 2);
        translate([0,GRIP_SIZE,0]) cylinder(d=3, h=.1);
    }
}

module  touchScrews() {
translate([-TOUCH_SCREW_DISTANCE/2,0,0]) 
    cylinder(d=TOUCH_SCREW_DIA,h=TOUCH_MOUNT_Z+1);
translate([TOUCH_SCREW_DISTANCE/2,0,0])
    cylinder(d=TOUCH_SCREW_DIA,h=TOUCH_MOUNT_Z+1);    
}

module touchMount() {
    difference() {
        rounded_cube([TOUCH_MOUNT_X, TOUCH_MOUNT_Y,TOUCH_MOUNT_Z], 0.1, 0.4);
        translate([TOUCH_MOUNT_X/2,TOUCH_MOUNT_Y/2 + TOUCH_SCREW_DIA,-.5]) 
            touchScrews();
    }
}

module wall() {
    difference() {
        rounded_cube([WALL_WEIGHT, WALL_LENGTH, WALL_HEIGHT],0.1, 0.4);
        translate([(WALL_WEIGHT/2) - (TOUCH_MOUNT_X/2) ,-.5,-.5]) 
            rounded_cube([TOUCH_MOUNT_X, WALL_LENGTH+1, TOUCH_OFFSET+.399],0.1, 0.4);
            translate([CARRAGE_SCREW_DIA/2+1,-1,CARRAGE_SCREW_DIA/2+1]) 
        rotate([-90,0,0]) cylinder(d=CARRAGE_SCREW_DIA, h=WALL_LENGTH+2);
            translate([WALL_WEIGHT - CARRAGE_SCREW_DIA/2-1,-1,CARRAGE_SCREW_DIA/2+1]) rotate([-90,0,0]) cylinder(d=CARRAGE_SCREW_DIA, h=WALL_LENGTH+2);
    }
}

module base() {
    wall();
    translate([0,0,TOUCH_OFFSET]){
    translate([(WALL_WEIGHT/2) - (TOUCH_MOUNT_X/2) ,WALL_LENGTH,0]) 
        touchMount();
    translate([(WALL_WEIGHT/2)  ,WALL_LENGTH, TOUCH_MOUNT_Z])
        grip();
    }
}

base();

