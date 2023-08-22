
function testv1
clc;
clear;
%%%%%% Initialization parameters  %%%%%%%%%%%%%
TN_BUCKs =1;
TN_RES = 32;
TN_Keys = 10000;
Status = 1;
choice = 1;   %% choices can 1, 3 and n
percent = 0;
removal_in_per = (TN_RES/100)*percent;
NUM_OF_RES_TO_REMV = TN_RES;  %% range from where to remove resources
RANGE_OF_VALUES_To_REMOV_From = removal_in_per; %% number of resources to remove. i.e. size of random removal
global ARRAYTODETERMINELOADONEACHNODE; %%%%%%%%%defining another array for evaluating load on each node %%%%%%%
global NUM_OF_EXTRACOMPUTATIONS_EACH_HIT; %%%%EXTRA computations when server is offline%%%%%
if (Status ==1)
        TN_Res_ARR_Wth_STATUS = ones( 1, TN_RES); 
RDM_RES_RMV = randperm(NUM_OF_RES_TO_REMV, RANGE_OF_VALUES_To_REMOV_From)  
size_RDM_RES_RMV = length(RDM_RES_RMV); %not using for sequenced removal
for i= 1: size_RDM_RES_RMV %removing sequenced 8 resources instead of random
    TN_Res_ARR_Wth_STATUS(RDM_RES_RMV(i))= 0;  %% using sequence instead of random
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%Removing random completed here %%%%%%%%%%%%%%%%%%%%%%
ARRAYTODETERMINELOADONEACHNODE = zeros (1, TN_RES);
NUM_OF_EXTRACOMPUTATIONS_EACH_HIT = zeros (1, TN_Keys);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic
for  keys= 1:TN_Keys  %%%% this loop is temporary for this version 1 only
    keys
OBJ_NAM_Char = int2str(keys);%['waqasss12']; this portion in in step a version 1
OBJ_NAM = string(keys);%["waqasss12"]; this portion in in step a version 1
BUCK_NUM =bucketv1 (TN_BUCKs, OBJ_NAM_Char);
[ARR_HVAL, cmiss, chit] = ARRofHASHVAL (OBJ_NAM, BUCK_NUM, TN_RES, TN_BUCKs, Status, choice, TN_Res_ARR_Wth_STATUS, ARRAYTODETERMINELOADONEACHNODE, TN_Keys, NUM_OF_EXTRACOMPUTATIONS_EACH_HIT);
%ARR_HVAL = ARRofHASHVAL (OBJ_NAM, BUCK_NUM, TN_RES, TN_BUCKs);
%[chit, cmiss]= RES_ARRAY_GEN (TN_RES, Status, BUCK_NUM, TN_BUCKs, ARR_HVAL, choice)
%[chit, cmiss]= RES_ARRAY_GEN_AND_OBJ_MAPPING (TN_RES, Status, BUCK_NUM, TN_BUCKs, ARR_HVAL, choice, ARRAYTODETERMINELOADONEACHNODE) %%mapping single/ triple
%[chit, cmiss]= RES_ARRAY_GEN_AND_OBJ_MAPPING_RNDM_RES_REMOV (TN_RES, Status, BUCK_NUM, TN_BUCKs, ARR_HVAL, choice, TN_Res_ARR_Wth_STATUS, ARRAYTODETERMINELOADONEACHNODE);
end
toc
a=length(RDM_RES_RMV)
ARRAYTODETERMINELOADONEACHNODE;
NUM_OF_EXTRACOMPUTATIONS_EACH_HIT;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i =1: TN_RES
    x(i)=i;
end
for i =1: TN_Keys
    y(i)=i;
end
%Histog_30RES_10000Keys= histogram (ARRAYTODETERMINELOADONEACHNODE)
figure(1);
bar(x, ARRAYTODETERMINELOADONEACHNODE)
xlim([0 TN_RES])
ylim([-1 (TN_Keys/TN_RES)*10])
figure(2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bar(y, NUM_OF_EXTRACOMPUTATIONS_EACH_HIT)
xlim([0 TN_Keys])
ylim([-1 100])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vr= var(ARRAYTODETERMINELOADONEACHNODE)
[Max_XTRA_COMPUT, AT_KEY] = max (NUM_OF_EXTRACOMPUTATIONS_EACH_HIT)
filename = "10Res10000kKeys10Percwithparallelcomputing.mat";
save(filename)
