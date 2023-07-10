%%
 prompt = "what is filename     "


filteredTable = rmmissing(input(prompt));
A=table2array(filteredTable);
x=A(:,1);
y=A(:,2);
z=A(:,3);
r=A(:,4);
g=A(:,5);
b=A(:,6);
k=A(:,8);
A1=A;
%% Guassian Curvature
format compact

%{
figure(1)
scatter3(x, y, z, 3, [r,g,b], 'filled');
xlabel('width[mm]');
ylabel('length[mm]')
zlabel('height[mm]')
title('colormap')
%}


figure(2)
scatter3(x(1:1:end), y(1:1:end), z(1:1:end), 6, k(1:1:end), 'filled');
xlabel('width[mm]');
ylabel('length[mm]')
zlabel('height[mm]')
title('Gauss curvature')
Center= 0.000248 ;
distrubution= 1*10^-3;  % this changes the resolution of the color bar, if your plot is all 1 color then adjust this value will most likely resolve that
caxis([Center-distrubution,Center+distrubution]);  %sets mins and maxes for the color bar based on the above inputs
colorbar
h = colorbar 
ylabel(h,'gaussian curvature [mm^-2]')

   

% Filtering Noise (Max and Mins)

    k1=k;% these 8 lines create and identical series of vertices and the curvature components  
    x1=x; %then you can specify the upper limit you want your data to be at and the program will remove 
    y1=y;% values that are greater then your limit
    z1=z;
    r1=r;
    g1=g;
    b1=b;
    M=2 %max value

      
    x1(k(:) > M) = [];
    y1(k(:) > M) = [];
    z1(k(:) > M) = [];
    k1(k(:) > M) = [];

 b1(k(:) > M) = [];
 r1(k(:) > M) = [];
  g1(k(:) > M) = [];



    N = -2 %min value
    x1(k(:) < N) = [];
    y1(k(:) < N) = [];
    z1(k(:) < N) = [];
    k1(k(:) < N) = [];
    
 b1(k(:) < N) = [];
 r1(k(:) < N) = [];
  g1(k(:) < N) = [];

  F = [];
F(:,1) =  x1;
F(:,2) =  y1;
F(:,3) =  z1;
F(:,4) =  k1;
Ffiltered = rmmissing(F);
% Graphing filtered data

figure(4)
scatter3(Ffiltered(:,1), Ffiltered(:,2),  Ffiltered(:,3), 3,  Ffiltered(:,4), 'filled');
ylabel(h,'gaussian curvature [mm^-2]')
colorbar;
caxis([Center-distrubution,Center+distrubution])
title("filtered gaussian curvature")
xlabel('width[mm]');
ylabel('length[mm]')
zlabel('height[mm]')





%{
figure(3)
scatter3(x1, y1, z1, 2, [r1,g1,b1], 'filled');
title("filtered color map")
colormap cool
xlabel('width[mm]');
ylabel('length[mm]')
zlabel('height[mm]')
%}


   

%% Finding Brushed K values
prompt = "would you like to find average brushed values of K enter 1 for yes and 0 for no   ";
B=input(prompt);
if B==1
    for i=1:length(x)
        for j=1:length(brushedData)
            if brushedData(j,1)==x(i)
                if brushedData(j,2)==y(i)
                    if brushedData(j,3)==z(i)
                        X(j)=x(i);
                        Y(j)=y(i);
                        Z(j)=z(i);
                        K(j)=k(i);
                    end
                end
            end
            j=j+1;
        end
        i=i+1;
    end
        figure(3)
    histogram(K)
    Kmean = mean(K)
K2=K;
    MaxK = max(K),  MinK = min(K),  stdev = std(K)
    if B==0
    fprintf("no K values then:(     ")
    end
end


   
  %  K2 = rmoutliers(K);


  %% Removes values greater than 3 standard deviations away from mean
  n=1

    for i=1:length(K)
        if K2(i)>(Kmean+stdev*n)
            K2(i) = nan;
            X(i) = nan;
            Y(i) = nan;
            Z(i) = nan;
        end
        if K2(i)<(Kmean-stdev*n)
            K2(i) = nan;
              X(i) = nan;
            Y(i) = nan;
            Z(i) = nan;
        end
    end
    X=X';
    Y=Y';
    Z=Z';
    K2=K2';
M = [];
M(:,1) =  X;
M(:,2) =  Y;
M(:,3) =  Z;
M(:,4) =  K2;
%M2=array2table
Mfiltered = rmmissing(M);
figure(6)
scatter3(Mfiltered(:,1), Mfiltered(:,2), Mfiltered(:,3), 6, Mfiltered(:,4), 'filled');
figure(7)
histogram(Mfiltered(:,4))
meanKfiltered = mean(Mfiltered(:,4))
%stdevfiltered = std((Mfiltered(:,4)))
fmin = min(Mfiltered(:,4))
fmax = max(Mfiltered(:,4))

