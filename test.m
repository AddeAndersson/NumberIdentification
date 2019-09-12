%%
%Algoritm 1 Nearest Neighbour

clear;
load uspsDigits.mat;

tic

%Storlek på träningsmängd
s = 7291;
s2 = 2007;

counter = 0;

for u = 1:s2
    if testAns(u,1) == 2
        
        %
        Test = testDigits(:,:,u);

        MinA = zeros(1,10);

        for i = 1:10;

            Dist = 9999;

            for k = 1:s
                if trainAns(k,1) == i-1;
                    Dist(end+1) = abs(norm(trainDigits(:,:,k)-Test));
                end

            end

            MinA(1,i) = min(Dist);

        end

        [y,x] = min(MinA);
        if x-1 == testAns(u,1);
            counter = counter +1;
        end
        %
    end
    
end

proc = (counter/198)*100;
fprintf('Nearest Neighbour is correct %2.2f percent of the time.\n', proc);

toc


%%
%Algoritm 2

clear;
load uspsDigits.mat;

tic
%Storlek på träningsmängd
s = 7291;
s2 = 2007;

    MinA = zeros(256,10);

    for i = 1:10

        pos = 0;

        for l = 1:s
            if trainAns(l,1) == i-1
                pos = pos + 1;
            end     
        end

        Dist = zeros(256,pos);

        plats = 0;
            for k = 1:s
                if trainAns(k,1) == i-1
                    plats = plats + 1;
                    dummy = trainDigits(:,:,k);
                    shapedDummy = reshape(dummy, [256,1]);
                    Dist(:,plats) = shapedDummy;
                end     
            end


        medel = mean(Dist, 2);
        MinA(:,i) = medel;
    end

    Dist1 = zeros(1,10);

    counter = 0;

for w = 1:s2
    
    Test = testDigits(:,:,w);
    
    if testAns(w,1) == 2
        for u = 1:10
            Dist1(1,u) = norm(MinA(:,u) - reshape(Test, [256,1]));
        end

        [y, x] = min(Dist1);
        %

        if x-1 == testAns(w,1)
            counter = counter +1;
        end
    end
    
end

proc = (counter/198)*100;
fprintf('Algoritm 2 is correct %2.2f percent of the time.\n', proc);
toc

%%
%Algoritm 3


clear;
load uspsDigits.mat;

%Storlek på träningsmängd
s = 7291;
s2 = 2007;

tic
%Dimension dim (5-10) 
dim = 10;

counter = 0;     
Underrum = zeros(256,10,10);

        for i = 1:10

            pos = 0;

            for l = 1:s
                if trainAns(l,1) == i-1
                    pos = pos + 1;
                end     
            end

            Dist = zeros(256,pos);

            plats = 0;
            for k = 1:s
               if trainAns(k,1) == i-1
                  plats = plats + 1;
                  Dist(:,plats) = reshape(trainDigits(:,:,k), [256,1]);
               end     
            end

            [U, S, V] = svd(Dist);
            Underrum(:,:,i) = U(:,1:dim);
        end

MinA = zeros(1,10);
        
for w = 1:s2 
    if testAns(w,1) == 2
        Test = testDigits(:,:,w);        
        
        for c = 1:10
            TestR = reshape(Test, [256,1]);
            X = Underrum(:,:,c)'*TestR;
            Proj = Underrum(:,:,c)*X;
            MinA(:,c) = abs(norm(TestR - Proj));
        end

        [y, x] = min(MinA);
       
        if x-1 == testAns(w,1)
            counter = counter + 1;
        end
    end
end

proc = (counter/198)*100;
fprintf('Algoritm 3 using %d dimensions is correct %2.2f percent of the time.\n', dim, proc);
toc