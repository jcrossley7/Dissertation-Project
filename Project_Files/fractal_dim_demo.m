function fractal_dim_demo
    clc;
    clear all;
    close all;
    I = imread('brain1.jpg');
    Ibw = ~im2bw(I); %Note that the background need to be 0
    figure(1);
    imagesc(Ibw);
    colormap gray;
    tic
    dim_val=BoxCountfracDim(Ibw) %Compute the box-count dimension
    toc
end
%overlap measures - dice/jaggard
%fine tuning

