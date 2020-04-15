include <startup.scad>;
include <util.scad>;
use <carrage_mount.scad>;
use<profile_mount.scad>;
use <carrage_mount.scad>;
use<tool_catcher.scad>;
use<tool_catcher2.scad>;
use <v6hotend.scad>;



translate([CARRAGE_MOUNT_X,0,0]) rotate([90,0,180]) carrgeMount();

translate([35,15,65]) rotate([90,180,0]) headMount();

//translate([80,80,60]) rotate([0,0,90]) profileMount();

translate([-25,-34,12]) {
translate([80,70,65]) rotate([0,0,180]) toolChangerCathcer2(true);

translate([85,45,20]) rotate([0,90,0])  toolChangeScrews();
}