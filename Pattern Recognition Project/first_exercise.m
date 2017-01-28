clear ; close all; clc

load('fisheriris.mat');

% Plotting the dataset

gscatter(meas(:,1), meas(:,2), species,'rgb','osd');
xlabel('Sepal length');
ylabel('Sepal width');
N = size(meas,1);


fprintf('The Fisher Iris dataset has been loaded. Press enter to continue.\n');
pause

%% === Part A ===

rng default;

% k-NN classifier

% indices = crossvalind('Kfold',species);
% cp = classperf(species);

% tmp = arrayfun( @(x)(rand()), X(:,1) )
% trainX = X( tmp <= 0.8, :)
% trainY = Y( tmp <= 0.8 );
% testX = X( tmp > 0.8, : );
% testY = Y( tmp > 0.8 );
% for i = 1:5
%     class = knnclassify(testX,trainX,trainY,1);
%     classperf(cp(:),class,testX);
% end
% 
% fprintf('The k-NN classification error rate for k = 1 is: %f\n', cp.ErrorRate);
% 
% fprintf('Program paused. Press enter to continue.\n');
% pause
% 
% for i = 1:5
%     class = knnclassify(testX,trainX,trainY,3);
%     classperf(cp(:),class,testX);
% end
% 
% fprintf('The k-NN classification error rate for k = 1 is: %f\n', cp.ErrorRate);
% 
% fprintf('Program paused. Press enter to continue.\n');
% pause
% 
% for i = 1:5
%     class = knnclassify(testX,trainX,trainY,5);
%     classperf(cp(:),class,testX);
% end
% 
% fprintf('The k-NN classification error rate for k = 1 is: %f\n', cp.ErrorRate);
% 
% fprintf('Program paused. Press enter to continue.\n');
% pause

% % k = 1
% for i = 1:5
%     test = (indices == i); 
%     train = ~test;
%     class = knnclassify(meas(test,:),meas(train,:),species(train,:),1);
%     classperf(cp(:),class,test);
% end
% fprintf('The k-NN classification error rate for k = 1 is: %f\n', cp.ErrorRate);
% 
% fprintf('Program paused. Press enter to continue.\n');
% pause
% 
% % k = 3
% for i = 1:5
%     test = (indices == i); 
%     train = ~test;
%     class = knnclassify(meas(test,:),meas(train,:),species(train,:),3);
%     classperf(cp(:),class,test);
% end
% fprintf('The k-NN classification error rate for k = 3 is: %f\n', cp.ErrorRate);
% 
% fprintf('Program paused. Press enter to continue.\n');
% pause
% 
% % k = 5
% for i = 1:5
%     test = (indices == i); 
%     train = ~test;
%     class = knnclassify(meas(test,:),meas(train,:),species(train,:),5);
%     classperf(cp(:),class,test);
% end
% fprintf('The k-NN classification error rate for k = 5 is: %f\n', cp.ErrorRate);
% 
% fprintf('Program paused. Press enter to continue.\n');
% pause

fold_number = 5;
indices = crossvalind('Kfold',species, fold_number);

val = 1:2:5; % for these small k values there will not be an important difference
             % regarding the cp ErrorRates. The difference is going to be
             % observable for val = 1:2:100, for example!!! But the
             % exercise asks only for k = 1,3,5.

err_arr = [];

for k=val

    cp = classperf(species); % Reinitialize the cp-structure!

    for i = 1:fold_number
        test = (indices == i); 
        knntrain = ~test;
        class = knnclassify(meas(test,:),meas(knntrain,:),species(knntrain), k);
        %class = knnclassify(meas(test,2),meas(train,2),species(train), k); % To experiment only with the 2nd feature

        classperf(cp,class,test);
    end
    err_arr = [err_arr; cp.ErrorRate];
    fprintf('The k-NN classification error rate for k = %d is: %f\n', k,cp.ErrorRate);
end  

fprintf('\n The error array is: \n');
disp(err_arr);

fprintf('Program paused. Press enter to continue.\n');
pause

% group = meas(test,:);
% predicted_species = resubPredict(class);
%knowngroup = species(randperm(150));
%predicted_species = predict(class,species(1:30));

[C] = confusionmat(species(test),class);
fprintf('The confusion matrix of k-NN classification is: \n');
disp(C);

% fprintf('Program paused. Press enter to continue.\n');
% pause
% 
% fprintf('\n and the order matrix is: \n');
% disp(order);

fprintf('Program paused. Press enter to continue.\n');
pause

% labels = unique(species);
% conf_mat = HeatMap(C);
% view(conf_mat);

% fprintf('Program paused. Press enter to continue.\n');
% pause

% Conf_mat = plotconfusion(group,class);


% fprintf('Program paused. Press enter to continue.\n');
% pause

plot(val, err_arr, 'LineWidth', 2);
grid on;
xlabel('K');
ylabel('ErrorRate');

fprintf('Program paused. Press enter to continue.\n');
pause

% % Multiple Least Squares
% fold_k = 5;
% cont = crossvalind('Kfold',species,fold_k);
% for i = 1:fold_k
%     [trainInd,valInd,testInd] = dividerand(150,0.8,0,0.2);
%     X_ls = meas(trainInd);
%     y_ls = species('versicolor');
%     % w = zeros(size(X_ls, 2), 1); % preallocation of w vector
%     w = pinv(X_ls'*X_ls)*(X_ls'*y_ls); % Normal Equation for finding w's.
% end
% m = length(y_ls);
% J = (1/(2*m)) * (X_ls*w-y_ls)' * (X_ls*w-y_ls);
% fprintf('The cost of least squares classification is: \n');
% fprintf(J);

train_label={zeros(40,1),ones(40,1),2*ones(40,1)};
train_cell={meas(1:40,:),meas(51:90,:),meas(101:140,:)};
[svmstruct,level] = Train_DSVM(train_cell,train_label);
label=[0 1 2];
test_mat=[meas(41:50,:);meas(91:100,:);meas(141:150,:)];
[Class_test] = Classify_DSVM(test_mat,label,svmstruct,level);
labels=[zeros(1,10),ones(1,10),2*ones(1,10)];
[Cmat,DA]= confusion_matrix(Class_test,labels,{'A','B','C'});



fprintf('Program paused. Press enter to continue.\n');
pause

%% Neural Network

% For neural network I use nnprtool. There are related screenshots from
% executing the asked neural network into the documentation.

%% === Part B ===

% [Xtrain,Xval,Xtest] = dividerand(150,0.7,0,0.3);
% X2 = meas(Xtrain,1:2);
% y2 = species(Xtest);

% Least Squares
train_label2={zeros(40,1),ones(40,1),2*ones(40,1)};
train_cell2={meas(1:40,3:4),meas(51:90,3:4),meas(101:140,3:4)};
[svmstruct2,level2] = Train_DSVM(train_cell2,train_label2);
label2=[0 1 2];
test_mat2=[meas(41:50,3:4);meas(91:100,3:4);meas(141:150,3:4)];
[Class_test2] = Classify_DSVM(test_mat2,label2,svmstruct2,level2);
labels2=[zeros(1,10),ones(1,10),2*ones(1,10)];
[Cmat2,DA2]= confusion_matrix(Class_test2,labels2,{'A','B','C'});
% figure;
% hold on;
% plot(test_mat2(:,1),labels2(1,:),'b.');
% plot(test_mat2(:,2),labels2(1,:),'r.');
% plot(test_mat2,labels2,'k-','LineWidth',1);

% w_svm = rand(30,1);
% b = 1;
% plot_x = linspace(min(test_mat2(:,1)),max(test_mat2(:,1)));
% plot_y = (1/w_svm(2))*(w_svm(1)*plot_x + b);
% plot(plot_x,plot_y,'k-','LineWidth',1);


fprintf('Program paused. Press enter to continue.\n');
pause

% Perceptron

t1 = randperm(50);
X1a = meas(t1(1:35),3:4);
t2 = randperm(100);
X2a = meas(50 + t2(1:35),3:4);
clear t1 t2;
Xa = [X1a X2a];
Ya = [-ones(35,1) ones(35,1)];
wa = rand(35,1);
wtaga = perceptron(Xa,Ya,wa); % call perceptron
ytaga = wtaga'*Xa; % predict
Yauxa = sign(wtaga'*Xa);

t1 = randperm(50);
X1b = meas(50+t1(1:35),3:4);
t2 = randperm(100);
X2b = meas(t2(1:35),3:4);
clear t1 t2;
Xb = [X1b X2b];
Yb = [-ones(35,1) ones(35,1)];
wb = rand(35,1);
wtagb = perceptron(Xb,Yb,wb); % call perceptron
ytagb = wtagb'*Xb; % predict
Yauxb = sign(wtagb'*Xb);

t1 = randperm(50);
X1c = meas(t1(1:35),3:4);
t2 = randperm(100);
X2c = meas(50 + t2(1:35),3:4);
clear t1 t2;
Xc = [X1c X2c];
Yc = [-ones(35,1) ones(35,1)];
wc = rand(35,1);
wtagc = perceptron(Xc,Yc,wc); % call perceptron
ytagc = wtagc'*Xc; % predict
Yauxc = sign(wtagc'*Xc);

%% Plotting

% Class A('Setosa')
figure;
hold on;


plot(X1a(1,:),X1a(2,:),'b.');
plot(X2a(1,:),X2a(2,:),'r.');

plot(Xa(1,ytaga<0),Xa(2,ytaga<0),'bo');
plot(Xa(1,ytaga>0),Xa(2,ytaga>0),'ro');

% gscatter(X1a,X2a,Ya);

% plotpv(Xa(1:2,:),logical(Ya));

legend('class +1','class -1','pred +1','pred -1');
title('Setosa');

figure;
plot(X1a(:,1),X1a(:,2),'r.','Markersize',15);
hold on;
plot(X2a(:,1),X2a(:,2),'b.','Markersize',15);
plot_res1 = decisionBoundary();

% x = 0:0.1:10;
% func = log(x-1.8)+0.9;
% plot(x,func);
% ezpolar('(x+0.5).^2');
% ezpolar('(x+1.5).^2');
% ezpolar(@(x)+3);
%contour(X1a,X2a,Ya);
axis equal;
title('Setosa');

% Class B('Versicolor')

figure;
hold on;

plot(X1b(1,:),X1b(2,:),'b.');
plot(X2b(1,:),X2b(2,:),'r.');

plot(Xb(1,ytaga<0),Xb(2,ytaga<0),'bo');
plot(Xb(1,ytaga>0),Xb(2,ytaga>0),'ro');

legend('class +1','class -1','pred +1','pred -1');
title('Versicolor');

figure;
plot(X1b(:,1),X1b(:,2),'r.','Markersize',15);
hold on;
plot(X2b(:,1),X2b(:,2),'b.','Markersize',15);
plot_res2 = decisionBoundary();
%ezpolar('(x+1.5).^2');
% ezpolar(@(x)2);
% ezpolar(@(x)4);
%contour(X1a,X2a,Ya);
axis equal;
title('Versicolor');

% Class C('Virginica')

%% 
figure;
hold on;

plot(X1c(1,:),X1c(2,:),'b.');
plot(X2c(1,:),X2c(2,:),'r.');

plot(Xc(1,ytaga<0),Xc(2,ytaga<0),'bo');
plot(Xc(1,ytaga>0),Xc(2,ytaga>0),'ro');

legend('class +1','class -1','pred +1','pred -1');
title('Virginica');

figure;
plot(X1c(:,1),X1c(:,2),'r.','Markersize',15);
hold on;
plot(X2c(:,1),X2c(:,2),'b.','Markersize',15);
plot_res3 = decisionBoundary();
%ezpolar('(x+1.5).^2');
% ezpolar(@(x)2);
% ezpolar(@(x)4);
%contour(X1a,X2a,Ya);
axis equal;
title('Virginica');

 % ----Alltogether----
 
figure;
hold on;


plot(X1a(1,:),X1a(2,:),'b.');
plot(X2a(1,:),X2a(2,:),'r.');

plot(Xa(1,ytaga<0),Xa(2,ytaga<0),'bo');
plot(Xa(1,ytaga>0),Xa(2,ytaga>0),'ro');

plot(X1b(1,:),X1b(2,:),'b.');
plot(X2b(1,:),X2b(2,:),'r.');

plot(Xb(1,ytaga<0),Xb(2,ytaga<0),'bo');
plot(Xb(1,ytaga>0),Xb(2,ytaga>0),'ro');

plot(X1c(1,:),X1c(2,:),'b.');
plot(X2c(1,:),X2c(2,:),'r.');

plot(Xc(1,ytaga<0),Xc(2,ytaga<0),'bo');
plot(Xc(1,ytaga>0),Xc(2,ytaga>0),'ro');

% b = 1;
% X_per = mean(Xa+Xb+Xc);
% w_db = mean(wa+wb+wc);
% plot_x = linspace(Xa(:,1),Xb(:,1));
% plot_y = (1/w_db(2)')*(w_db(1)'*plot_x + b);
% plot(plot_x,plot_y,'k-','LineWidth',1);

legend('class +1','class -1','pred +1','pred -1');
title('All classes');

% % coding (+1/-1) of 3 classes
% a = [-1 -1 +1]';
% b = [-1 +1 -1]';
% c = [+1 -1 -1]';
% % define training inputs
% rand_ind = randperm(50);
% trainSeto = meas(rand_ind(1:35),:);
% trainVers = meas(50 + rand_ind(1:35),:);
% trainVirg = meas(100 + rand_ind(1:35),:);
% trainInp = [trainSeto trainVers trainVirg];
% % define targets
% tmp1 = repmat(a,1,length(trainSeto));
% tmp2 = repmat(b,1,length(trainVers));
% tmp3 = repmat(c,1,length(trainVirg));
% T = [tmp1 tmp2 tmp3];
% clear tmp1 tmp2 tmp3;
% %% network training
% trainCor = zeros(10,10);
% valCor = zeros(10,10);
% Xn = zeros(1,10);
% Yn = zeros(1,10);
% for k = 1:10
%     Yn(1,k) = k;
%     for n = 1:10
%         Xn(1,n) = n;
%         net = newff(trainInp,T,[k n],{},'trainbfg');
%         net = init(net);
%         net.divideParam.trainRatio = 1;
%         net.divideParam.valRatio = 0;
%         net.divideParam.testRatio = 0;
%         %net.trainParam.show = NaN;
%         net.trainParam.max_fail = 2;
%         valSeto = 0;
%         valVers = 1;
%         valVirg = 2;
%         valInp = [valSeto valVers valVirg];
%         VV.P = valInp;
%         tmp1 = repmat(a,1,length(valSeto));
%         tmp2 = repmat(b,1,length(valVers));
%         tmp3 = repmat(c,1,length(valVirg));
%         valT = [tmp1 tmp2 tmp3];
%         net = train(net,trainInp,T,[],[],VV);%,TV);
%         Y = sim(net,trainInp);
%         [Yval,Pfval,Afval,Eval,perfval] = sim(net,valInp,[],[],valT);
%         % calculate [%] of correct classifications
%         trainCor(k,n) = 100 * length(find(T.*Y > 0)) / length(T);
%         valCor(k,n) = 100 * length(find(valT.*Yval > 0)) / length(valT);
%     end
% end
% clear tmp1 tmp2 tmp3;
% figure;
% surf(Xn,Yn,trainCor/3);
% view(2);
% figure;
% surf(Xn,Yn,valCor/3);
% view(2);
% %% final training
% k = 3;
% n = 3;
% fintrain = [trainInp valInp];
% finT = [T valT];
% net = newff(fintrain,finT,[k n],{},'trainbfg');
% net.divideParam.trainRatio = 1;
% net.divideParam.valRatio = 0;
% net.divideParam.testRatio = 0;
% net = train(net,fintrain,finT);
% finY = sim(net,fintrain);
% finCor = 100 * length(find(finT.*finY > 0)) / length(finT);
% fprintf('Num of neurons in 1st layer  = %d\n',net.layers{1}.size);
% fprintf('Num of neurons in 2nd layer  = %d\n',net.layers{2}.size);
% fprintf('Correct class   = %.3f %%\n',finCor/3);
% %% Testing
% % define test set
% testInp = [testSeto testVers testVirg];
% tmp1 = repmat(a,1,length(testSeto));
% tmp2 = repmat(b,1,length(testVers));
% tmp3 = repmat(c,1,length(testVirg));
% testT = [tmp1 tmp2 tmp3];
% testOut = sim(net,testInp);
% testCor = 100 * length(find(testT.*testOut > 0)) / length(testT);
% fprintf('Correct class   = %.3f %%\n',testCor/3);
% % plot targets and network response
% clear tmp1 tmp2 tmp3;
% figure;
% plot(testT');
% xlim([1 21]);
% ylim([0 2]);
% set(gca,'ytick',[1 2 3]);
% hold on;
% grid on;
% plot(testOut','r');
% legend('Targets','Network response');
% xlabel('Sample No.');


% === Part C ===

X = meas;

% BSAS Algorithm
q = 3; % number of classes
theta = 0.334211; % fisher iris dataset dissimilarity threshold
order = randperm(N); % random order of accessing the vectors
bel = BSAS(X(randperm(N),:),theta,q); % bel: is an N-dimensional vector whose ith element 
                                    % indicates the cluster where the ith data vector is
                                    % assigned
                                    % repre: is a matrix that contains the l-dimensional (mean) 
                                    % representative of the clusters in its columns.

% K-means Algorithm
m = 3; % 3 classes
rng default; % for reproducibility
%theta_ini = rand(1,m); % Random initialization of thetas 
[idx,C] = kmeans(X,3);

fprintf('The vector of predicted cluster indices idx is: \n');
disp(idx);

fprintf('Program paused. Press enter to continue.\n');
pause

fprintf('\n and the final centroid locations matrix C is: \n');
disp(C);


fprintf('Program paused. Press enter to continue.\n');
pause

%  HERE IT MUST BE INSERTED THE PLOTTING OF K-MEANS CLUSTERING!!!
cluster1 = meas(idx == 1,:);
cluster2 = meas(idx == 2,:);
cluster3 = meas(idx == 3,:);

figure;
axes;
hold all;

plot3(cluster1(:,1),cluster1(:,2),cluster1(:,3),'*');
plot3(cluster2(:,1),cluster2(:,2),cluster2(:,3),'*');
plot3(cluster3(:,1),cluster3(:,2),cluster3(:,3),'*');

grid on;
box on;

fprintf('Goodbye!\n');