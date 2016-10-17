function[noPlate] = final(fullimageFileName,no)


I = imread(fullimageFileName);
imshow(I);


%%
I=imresize(I,[400 NaN]);
I = rgb2gray(I);
I = medfilt2(I,[3 3]);
s = strel('disk',1);
si = imdilate(I,s);
se = imerode(I,s);
I = imsubtract(si,se);
I = mat2gray(I);
I = conv2(I,[1 1;1 1]);
I = imadjust(I,[0.5 0.7],[0 1],0.1);
I = logical(I);
er = imerode(I,strel('line',50,0));
I = imsubtract(I,er);
I = imfill(I,'holes');
I = bwmorph(I,'thin',1);
I = imerode(I,strel('line',3,90));
I = bwareaopen(I,100);


%% 
Iprops=regionprops(I,'BoundingBox','Image');
NR=cat(1,Iprops.BoundingBox);
r=controlling(NR,no);
if ~isempty(r) 
    I={Iprops.Image};
    noPlate=[]; 
    for v=1:length(r)
        N=I{1,r(v)};
        letter=readLetter(N); 
        while letter=='O' || letter=='0' 
            if v<=3                      
                letter='O';              
            else                         
                letter='0';              
            end                          
            break;                       
        end
        while letter == 'Z' || letter == '2'
            if v<=3
                letter = 'Z';
            else
                letter ='2';
            end
            break;
        end
        noPlate=[noPlate letter]; 
    end  
else
    disp('ERROR IN DISPLAYING CHARACTERS THE USER IS NOT ALLOWED TO GO.');
    disp('EITHER THE PERSON IS NOT FOUND IN RECORD OR THE VEHICLE PLATE IS NOT CLEAR.\n');
end
end