
clear all
close all

load block1_tau

net = bnn_init([],tau);

theta = bnn_pack(net,'weights');

%theta = randn(30,1);

netC = bnn_unpack(theta,net,'weights');

disp(' ');
disp('   Original            New');
disp([net.W1, netC.W1]);
disp([net.W2, netC.W2]);
disp([net.task{1}.w, netC.task{1}.w]);
disp([net.b1, netC.b1]);
disp([net.b2, netC.b2]);
disp([net.task{1}.b, netC.task{1}.b]);