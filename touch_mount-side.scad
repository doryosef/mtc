include <startup.scad>;
include <util.scad>;

TOUCH_MOUNT_X=24;
TOUCH_MOUNT_Y=8;
TOUCH_MOUNT_Z=5;

GRIP_HEIGHT=5;


CARRAGE_SCREW_DIA=3;

TOUCH_SCREW_DIA=3;

TOUCH_SCREW_DISTANCE=18;

GRIP_SIZE=15;

// END STOP
END_STOP_HEGIT=13;
END_STOP_X=10;
END_STOP_Y=26;

module grip() {
    hull() {
        cylinder(d=2, h=GRIP_HEIGHT );
        translate([0,GRIP_SIZE,0]) cylinder(d=2, h=.1);
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
        translate([TOUCH_MOUNT_X/2 -1,TOUCH_MOUNT_Y/2 ,-.5]) 
            touchScrews();
    }
}


module base() {
    translate([0 ,1,0]) 
        touchMount();
}
module endStopBase() {
    endstop_offset = 3;    
    translate([END_STOP_X,0,0]) rounded_cube([endstop_offset, END_STOP_Y, END_STOP_HEGIT],0.1, 0.4);
    difference() {
        rounded_cube([END_STOP_X, END_STOP_Y, END_STOP_HEGIT],0.1, 0.4);
        translate([END_STOP_X/2,END_STOP_Y-3,-.1]) {
            M3Screw(END_STOP_HEGIT);
            translate([0,-19.5,0]) 
            M3Screw(END_STOP_HEGIT);
        }
    }
}

module touch_holder() {
base();
rotate([0,0,90]) 
    translate([TOUCH_MOUNT_Y+1,-END_STOP_Y+1.5,TOUCH_MOUNT_Z]) grip();
}

module touch_mount() {
touch_holder();
translate([TOUCH_MOUNT_X+0.5,0,-15]) rotate([90,0,90]) 
endStopBase();
}
rotate([0,90,0]) 
touch_mount();