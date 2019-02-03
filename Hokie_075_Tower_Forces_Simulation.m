% Code simulating forces in a launch tower during lift
% Origin is at the pivot point of the tower
% Positive x is to the right, positive y is against gravity
% The tower lies with the pivot point on the left, and rotates to
% vertical in the counter-clockwise direction
% Counter-clockwise is positive for moments/torques
% Additional coordinate system: "along" - collinear to the tower, positive
% away from pivot point ; "away" - perpendicular to tower, in-plane with
% hydraulic ram, positive away from pivot point

clear all
close all
clc
clf

% [ MOST VALUES TEMPORARY ]

g = 32.2; % gravitational constant, ft/s^2
Th = 30; % tower length, ft - now only used for Tcg
Tcg = Th / 2; % distance of tower CG from pivot, ft - *assumed!* 1/2 tower
    % get a better number if necessary
Tm = 500; % tower mass, lbm [TEMPORARY VALUE]

Hx = 15; % distance along the I-beam between the pivot and the ram, ft
Hy = -2; % distance above the I-beam that the ram base is mounted, ft

Pd = sqrt((Hx^2) + (Hy^2)); % distance between the pivot points, ft
theta = rand(1,91); % angle the tower is raised from vertical, degrees
theta(1,:) = [0:1:90];
alpha = atand(Hy / Hx); % angle measured from the I-beam to the pivot-pivot line, degrees

Hal = 10; % distance along the tower between the pivot and the ram, ft
Hl = sqrt((Hal^2) + (Pd^2) - (2*Hal*Pd*cosd(theta - alpha))); % length of ram, ft

subplot(2,2,2)
grid on
degrees_vs_ram = plot(theta, Hl);
title("Length of Ram vs. Tower Angle")
xlabel("Tower angle, degrees")
ylabel("Length of ram, ft")

subplot(2,2,1)
title("Tower Lifting Simulation")
xlabel("X distance from tower pivot, ft")
ylabel("Y distance from tower pivot, ft")

grid on
xlim([-5, Th + 5])
ylim([Hy - 5, Th + 5])
ibeam = line([-5 Th*1.1],[0 0], "Color", "black"); % I-beam base
pivotline = line([0 Hx], [0 Hy], "LineStyle", ":");
Hal_line = line("Color", "blue");
extended_tower_line = line("Color", "blue");
ram = line("Color", "blue");

for angle_index = 1:91
    pause(0.05)
    ram_x = [Hx  Hal*cosd(theta(angle_index))];
    ram_y = [Hy  Hal*sind(theta(angle_index))];
    tower_tip = [((cosd(theta(angle_index))*(Th - Hal))+ram_x(2)) ((sind(theta(angle_index))*(Th - Hal))+ram_y(2))];
    
    set(ram, 'XData', ram_x, 'YData', ram_y)
    set(Hal_line, 'XData', [0 ram_x(2)], 'YData', [0 ram_y(2)])
    set(extended_tower_line, 'XData', [ram_x(2) tower_tip(1)], 'YData', [ram_y(2) tower_tip(2)])
end
    






