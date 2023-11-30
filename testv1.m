
function testv1
clc;
clear;
%%%%%% Initialization parameters  %%%%%%%%%%%%%
TN_BUCKs =1;
TN_RES = 1000;
Status = 1;
choice = 1;   %% choices can 1, 3 and n
NUM_OF_RES_TO_REMV = TN_RES;  %% range from where to remove resources
RANGE_OF_VALUES_To_REMOV_From= 500; %% number of resources to remove. i.e. size of random removal
global ARRAYTODETERMINELOADONEACHNODE;
%%%%%%%%%defining another array for evaluating load on each node %%%%%%%
%%%%%%%%%for version 1 step a
%%%%%%%%%defining another array for evaluating load on each node %%%%%%%
%%%%%%%%%for version 1 step a
%%%%%%%% Removing random resource and then we will pass these to function%%
if (Status ==1)
   % for i = 1: TN_RES
        TN_Res_ARR_Wth_STATUS = ones( 1, TN_RES);  % representing Online resources
   % end
   %% randperm (n, l) n is range and l is number of values to generate
RDM_RES_RMV = randperm(NUM_OF_RES_TO_REMV, RANGE_OF_VALUES_To_REMOV_From)  
%RDM_RES_RMV = randi(NUM_OF_RES_TO_REMV, RANGE_OF_VALUES_To_REMOV_From, 1) %%// these resources will be removed
size_RDM_RES_RMV = length(RDM_RES_RMV); %not using for sequenced removal
for i= 1: size_RDM_RES_RMV %removing sequenced 8 resources instead of random
    TN_Res_ARR_Wth_STATUS(RDM_RES_RMV(i))= 0;  %% using sequence instead of random
end
else 
  %  for i = 1: TN_RES
        TN_Res_ARR_Wth_STATUS = zeros( 1, TN_RES); % representing Offline resources
  %  end
%%  RDM_RES_RMV = randi(NUM_OF_RES_TO_REMV, RANGE_OF_VALUES_To_REMOV_From, 1) %%// these resources will be removed
%%size_RDM_RES_RMV = size(RDM_RES_RMV); not using for sequenced
for i= 1: size_RDM_RES_RMV
    TN_Res_ARR_Wth_STATUS(RDM_RES_RMV(i))= 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%%%%%%Removing random completed here %%%%%%%%%%%%%%%%%%%%%%
ARRAYTODETERMINELOADONEACHNODE = zeros (1, TN_RES);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TN_Res_ARR_Wth_STATUS = [ 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for  keys= 1:20000  %%%% this loop is temporary for this version 1 only
    keys
OBJ_NAM_Char = int2str(keys);%['waqasss12']; this portion in in step a version 1
OBJ_NAM = string(keys);%["waqasss12"]; this portion in in step a version 1
BUCK_NUM =bucketv1 (TN_BUCKs, OBJ_NAM_Char);
ARR_HVAL = ARRofHASHVAL (OBJ_NAM, BUCK_NUM, TN_RES, TN_BUCKs);
%[chit, cmiss]= RES_ARRAY_GEN (TN_RES, Status, BUCK_NUM, TN_BUCKs, ARR_HVAL, choice)
%[chit, cmiss]= RES_ARRAY_GEN_AND_OBJ_MAPPING (TN_RES, Status, BUCK_NUM, TN_BUCKs, ARR_HVAL, choice, ARRAYTODETERMINELOADONEACHNODE) %%mapping single/ triple
[chit, cmiss]= RES_ARRAY_GEN_AND_OBJ_MAPPING_RNDM_RES_REMOV (TN_RES, Status, BUCK_NUM, TN_BUCKs, ARR_HVAL, choice, TN_Res_ARR_Wth_STATUS, ARRAYTODETERMINELOADONEACHNODE);
end
a=length(RDM_RES_RMV)
ARRAYTODETERMINELOADONEACHNODE;
Vr= var(ARRAYTODETERMINELOADONEACHNODE)