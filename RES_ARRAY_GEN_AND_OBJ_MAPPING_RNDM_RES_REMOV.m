%%generating total number of resource array in 2D with resource status as 1
%%and assigining single object/ triple  to resource and then removing
%%random resource to check cache hit and cache miss
function [chit, cmiss]= RES_ARRAY_GEN_AND_OBJ_MAPPING_RNDM_RES_REMOV (TN_RES, Status, BUCK_NUM, TN_BUCKs, ARR_HVAL, choice, TN_Res_ARR_Wth_STATUS, ARRAYTODETERMINELOADONEACHNODE)
%%%%%% total resources are generated %%%%%%%%
chit=0;
cmiss=0;
new_chit=0;
x= zeros (1, TN_RES);  %% variable for plot
global ARRAYTODETERMINELOADONEACHNODE;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%resource removal test code

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
res_PR_bucket = ceil(TN_RES/TN_BUCKs)
%for i = 1: res_PR_bucket
%    RES_LIST_FR_BUCK(i) = (i+(BUCK_NUM*res_PR_bucket))%% sequenced list of resources for that bucket
%end   
%RES_LIST_FR_BUCK    
ARR_HVAL;
switch choice
    case 1   %% for single object mapping
        for i = 1: res_PR_bucket
   %% you can apply condition for handling single obj , triple copy or block
if TN_Res_ARR_Wth_STATUS(((BUCK_NUM* res_PR_bucket)-res_PR_bucket)+ ARR_HVAL(i)) == 1
    chit=chit+1;
    ARRAYTODETERMINELOADONEACHNODE(((BUCK_NUM* res_PR_bucket)-res_PR_bucket)+ ARR_HVAL(i))=ARRAYTODETERMINELOADONEACHNODE(((BUCK_NUM* res_PR_bucket)-res_PR_bucket)+ ARR_HVAL(i))+1;
    %% assign the resource here before the break statement
    break
    %% assign the object here
   %% break here for single object mapping i.e. after 1 hit and also 

elseif TN_Res_ARR_Wth_STATUS(((BUCK_NUM* res_PR_bucket)-res_PR_bucket)+ ARR_HVAL(i)) == 0
        cmiss=cmiss+1;
 end
        end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 3   %% for mapping of triplication
 for i = 1: res_PR_bucket
   %% you can apply condition for handling single obj , triple copy or block
if TN_Res_ARR_Wth_STATUS(((BUCK_NUM* res_PR_bucket)-res_PR_bucket)+ ARR_HVAL(i)) == 1
    new_chit= chit+1;
        if (new_chit > chit )
   %% assign the object here object(new_chit)
   ARRAYTODETERMINELOADONEACHNODE(((BUCK_NUM* res_PR_bucket)-res_PR_bucket)+ ARR_HVAL(i))=ARRAYTODETERMINELOADONEACHNODE(((BUCK_NUM* res_PR_bucket)-res_PR_bucket)+ ARR_HVAL(i))+1;
   chit= new_chit
   if (new_chit >= 3)
       break
   end
        end
 %% break here for single object mapping i.e. after 1 hit and also 

elseif TN_Res_ARR_Wth_STATUS(((BUCK_NUM* res_PR_bucket)-res_PR_bucket)+ ARR_HVAL(i)) == 0
        cmiss=cmiss+1
 end
 end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ARRAYTODETERMINELOADONEACHNODE;
for i =1: TN_RES
    x(i)=i;
end
%Histog_30RES_10000Keys= histogram (ARRAYTODETERMINELOADONEACHNODE)
bar(x, ARRAYTODETERMINELOADONEACHNODE)
xlim([0 TN_RES])
ylim([-1 500])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    