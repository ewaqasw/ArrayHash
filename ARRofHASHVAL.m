%%%% this is Array Hash function which generates array of hash values to 
%%%% further generate array of random and deterministic nodes ID 
%%%% for simplicity we work in integers %%%%%%%%%%
function ARR_HVAL = ARRofHASHVAL (OBJ_NAM, BUCK_NUM, TN_RES, TN_BUCKs)
%BUCK_NUM;
res_PR_bucket = ceil(TN_RES/TN_BUCKs)
%%%%%%%%%from here onward we will generate resources sequence for that
%%%%%%%%%input bucket
for i = 1: res_PR_bucket
    RES_LIST_FR_BUCK(i) = (i+(BUCK_NUM*res_PR_bucket))-res_PR_bucket;%% sequenced list of resources for that bucket
    STR_RES_LIST_FR_BUCK(i)= string (RES_LIST_FR_BUCK(i)); %% converting numeric to string
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
end
%RES_LIST_FR_BUCK              %% list is accurately generated
%STR_RES_LIST_FR_BUCK
CONC_ARR_NODE_WITHOBJ= CONCATENATION1v1 (OBJ_NAM, STR_RES_LIST_FR_BUCK);
CNCTD_ARR_SIZE = size(CONC_ARR_NODE_WITHOBJ);
for i=1: CNCTD_ARR_SIZE (2)
crc(i) = crc32v1(convertStringsToChars(CONC_ARR_NODE_WITHOBJ(i)));  %% will return of hash values
ARR_(i) = mod (crc(i), res_PR_bucket);% KY_SVR_SZ (2));  %% try it with different MODs
%%%%%% incrementing ARR_HVAL array element to avoid 0th element indexing%%
ARR_HVAL(i)= ARR_(i)+1;
end
crc;
ARR_;
ARR_HVAL;
