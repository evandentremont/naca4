
// Copyright 2017 Evan d'Entremont. All rights reserved.
// NACA Airfoil Generator

// NACA # ABCD
// airfoil(A,B,CD)

// Cessna 172 (to scale)
//straight_wing(2,4,12,1500,5500);

// Compound wing 
compound_wing(0,0,15,4,5,15,100,300);

// needs to stay at 25 unless airfoil() is modified as well.
function x(i, datapoints = 25) = 1-cos(i*(90/(datapoints-1)));

function y_t(i, t) = (t/0.2)*((0.2969*pow( x(i),0.5))-(0.126* x(i))-(0.3516*pow( x(i),2))+(0.2843*pow( x(i),3))-(0.1015*pow( x(i),4)));

function y_c(i, c_pos, c_max) = x(i) < (c_pos/10) ? (c_max/pow((c_pos/10),2))*((2*(c_pos/10)*x(i) )-pow(x(i) ,2)) : (c_max/pow(((1-(c_pos/10))),2))*((1-(2*(c_pos/10)))+(2*(c_pos/10)*x(i) )-pow(x(i) ,2)) ;

function x_upper(i, t, c_pos, c_max) = x(i) - y_t(i, t)*(sin(atan((y_c(i, c_pos, c_max)-y_c(i-1, c_pos, c_max))/(x(i)-x(i-1) ))));

function y_upper(i, t, c_pos, c_max) = y_c(i, c_pos, c_max) + y_t(i, t)*(cos(atan((y_c(i, c_pos, c_max)-y_c(i-1, c_pos, c_max))/(x(i)-x(i-1)))));

function  x_lower(i, t, c_pos, c_max) = x(i) + y_t(i, t)*(sin(atan((y_c(i, c_pos, c_max)-y_c(i-1, c_pos, c_max, c_pos, c_max))/(x(i)-x(i-1)))));

function y_lower(i, t, c_pos, c_max) =y_c(i, c_pos, c_max) - y_t(i, t)*(cos(atan((y_c(i, c_pos, c_max)-y_c(i-1, c_pos, c_max))/(x(i)-x(i-1)))));


module straight_wing(c_max = 0, c_pos = 0, t = 15, chord =1 , span = 1){
    // Scale the height by the chord as well, the airfoil module generates a unit 1 wing.
    scale([chord,chord,span]) linear_extrude(height=1) airfoil(c_max,c_pos,t);
}

module compound_wing(c_max1 = 0, c_pos1 = 0, t1 = 15, c_max2 = 0, c_pos2 = 0, t2 = 15, chord =1 , span = 1){
  hull(){  
    scale([chord,chord,1]) linear_extrude(height=1) airfoil(c_max1,c_pos1,t1);   
    translate([0,0,span])scale([chord,chord,1]) linear_extrude(height=1) airfoil(c_max2,c_pos2, t2);
  }
}

// make the airfoil
module airfoil(NACA_maxcamber = 0, NACA_camberpos = 0, NACA_thickness = 15) {
    c_max = NACA_maxcamber/100;
    c_pos = NACA_camberpos;
    t = NACA_thickness/100;

    polygon( points=[ 
     
    // upper side front-to-back
        [0,0], 
        [x_upper(2, t, c_pos, c_max), y_upper(2, t, c_pos, c_max)],
        [x_upper(3, t, c_pos, c_max),y_upper(3, t, c_pos, c_max)],
        [x_upper(4, t, c_pos, c_max),y_upper(4, t, c_pos, c_max)],
        [x_upper(5, t, c_pos, c_max),y_upper(5, t, c_pos, c_max)],
        [x_upper(6, t, c_pos, c_max),y_upper(6, t, c_pos, c_max)],
        [x_upper(7, t, c_pos, c_max),y_upper(7, t, c_pos, c_max)],
        [x_upper(8, t, c_pos, c_max),y_upper(8, t, c_pos, c_max)],
        [x_upper(9, t, c_pos, c_max),y_upper(9, t, c_pos, c_max)],
        [x_upper(10, t, c_pos, c_max),y_upper(10, t, c_pos, c_max)],
        [x_upper(11, t, c_pos, c_max),y_upper(11, t, c_pos, c_max)],
        [x_upper(12, t, c_pos, c_max),y_upper(12, t, c_pos, c_max)],
        [x_upper(13, t, c_pos, c_max),y_upper(13, t, c_pos, c_max)],
        [x_upper(14, t, c_pos, c_max),y_upper(14, t, c_pos, c_max)],
        [x_upper(15, t, c_pos, c_max),y_upper(15, t, c_pos, c_max)],
        [x_upper(16, t, c_pos, c_max),y_upper(16, t, c_pos, c_max)],
        [x_upper(17, t, c_pos, c_max),y_upper(17, t, c_pos, c_max)],
        [x_upper(18, t, c_pos, c_max),y_upper(18, t, c_pos, c_max)],
        [x_upper(19, t, c_pos, c_max),y_upper(19, t, c_pos, c_max)],
        [x_upper(20, t, c_pos, c_max),y_upper(20, t, c_pos, c_max)],
        [x_upper(21, t, c_pos, c_max),y_upper(21, t, c_pos, c_max)],
        [x_upper(22, t, c_pos, c_max),y_upper(22, t, c_pos, c_max)],
        [x_upper(23, t, c_pos, c_max),y_upper(23, t, c_pos, c_max)],
        [x_upper(24, t, c_pos, c_max),y_upper(24, t, c_pos, c_max)],
            
        // lower side back to front
        [x_lower(24, t, c_pos, c_max), y_lower(24, t, c_pos, c_max)],
        [x_lower(23, t, c_pos, c_max), y_lower(23, t, c_pos, c_max)],
        [x_lower(22, t, c_pos, c_max), y_lower(22, t, c_pos, c_max)],
        [x_lower(21, t, c_pos, c_max), y_lower(21, t, c_pos, c_max)],
        [x_lower(20, t, c_pos, c_max), y_lower(20, t, c_pos, c_max)],
        [x_lower(19, t, c_pos, c_max), y_lower(19, t, c_pos, c_max)],
        [x_lower(18, t, c_pos, c_max), y_lower(18, t, c_pos, c_max)],
        [x_lower(17, t, c_pos, c_max), y_lower(17, t, c_pos, c_max)],
        [x_lower(16, t, c_pos, c_max), y_lower(16, t, c_pos, c_max)],
        [x_lower(15, t, c_pos, c_max), y_lower(15, t, c_pos, c_max)],
        [x_lower(14, t, c_pos, c_max), y_lower(14, t, c_pos, c_max)],
        [x_lower(13, t, c_pos, c_max), y_lower(13, t, c_pos, c_max)],
        [x_lower(12, t, c_pos, c_max), y_lower(12, t, c_pos, c_max)],
        [x_lower(11, t, c_pos, c_max), y_lower(11, t, c_pos, c_max)],
        [x_lower(10, t, c_pos, c_max), y_lower(10, t, c_pos, c_max)],
        [x_lower(9, t, c_pos, c_max), y_lower(9, t, c_pos, c_max)],
        [x_lower(8, t, c_pos, c_max), y_lower(8, t, c_pos, c_max)],
        [x_lower(7, t, c_pos, c_max), y_lower(7, t, c_pos, c_max)],
        [x_lower(6, t, c_pos, c_max), y_lower(6, t, c_pos, c_max)],
        [x_lower(5, t, c_pos, c_max), y_lower(5, t, c_pos, c_max)],
        [x_lower(4, t, c_pos, c_max), y_lower(4, t, c_pos, c_max)],
        [x_lower(3, t, c_pos, c_max), y_lower(3, t, c_pos, c_max)],
        [x_lower(2, t, c_pos, c_max), y_lower(2, t, c_pos, c_max)],
        [x_lower(1, t, c_pos, c_max), y_lower(1, t, c_pos, c_max)],
    ]
   ); 
}

