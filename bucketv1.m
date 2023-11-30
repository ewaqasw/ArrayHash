%%%%%%%%%%This function will act as first hash function whoch take the
%%%%%%%%%%object name as input and return the corresponding bucket number
%%%%%%%%%%by crc32hash MOD Number of buckets
function BUCK_NUM =bucketv1 (TN_BUCKs, OBJ_NAM_Char)   %taking total num of buckets, OBJ_NAME and total num of resources
%%%%%%%%%%%%%%%%%%%%%%Initialize variables%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
data= OBJ_NAM_Char;
crc  = uint32(hex2dec('FFFFFFFF'));
poly = uint32(hex2dec('EDB88320'));
data = uint8(data);

% Compute CRC-32 value
for i = 1:length(data)
    crc = bitxor(crc,uint32(data(i)));
    for j = 1:8
        mask = bitcmp(bitand(crc,uint32(1)));
        if mask == intmax('uint32'), mask = 0; else mask = mask+1; end
        crc = bitxor(bitshift(crc,-1),bitand(poly,mask));
    end
end
crc = bitcmp(crc);
BUCK = mod (crc, TN_BUCKs); 
%%%%%%%%%% bucket number is generated %%%%%%%%%%%%%%%%%%%%%
BUCK_NUM = BUCK +1; 
