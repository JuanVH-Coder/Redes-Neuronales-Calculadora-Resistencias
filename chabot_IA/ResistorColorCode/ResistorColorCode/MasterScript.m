%% controls all the other scripts
%% First We seperate each resistor from the main image
Imain=imread(imageres);
run('segapp.m');
%% Finally we determine the value of each resistor and show the output
run('resvalue.m');
clear all;