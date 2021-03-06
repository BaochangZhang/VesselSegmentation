numid=1;
DataFilepath =strcat( 'C:\Users\17488\Desktop\tof_space\TOF-1\Re_tof',num2str(numid,'%03d'),'_corr.nii');
%DataFilepath =strcat( 'C:\Users\17488\Desktop\tof_space\TOF-1\tof2.nii');
Data=load_untouch_nii(DataFilepath);
Image=Data.img;
% A=Image<=0;
% Mask=1-A;
% kernal1= strel('sphere',5);
% Mask=imerode(Mask,kernal1);
% Image=Image+max(Image(:))*A;
I = Image - min(Image(:));
I = I / prctile(I(I(:) > 0.5 * max(I(:))),90);
I(I>1) = 1;
Iout = vesselness3D(I, 1:2, [1;1;1], 0.7, true);
% Iout=Iout.*Mask;
Vessel= Iout>0.35;
[Vessel_maxConnect, ~,~] = Connection_Judge_3D(Vessel,2,[],200,1);
figure;
patch(isosurface(Vessel_maxConnect,0.5),'FaceColor',[1,0,0],'EdgeColor','none')
[a,b,c] = size(Vessel_maxConnect);axis([0 b 0 a 0 c]);view([270,270]);
daspect([1,1,1]);
title('Difference');camlight; camlight(-80,-10); lighting phong;