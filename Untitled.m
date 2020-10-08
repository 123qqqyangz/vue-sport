% % % % % % % % % % % clear;clc
f=imread('��ݮ.jpg');%%%imshow
% c=imread('����.jpg');
% imshow(f)
% figure,imshow(c)
help imwrite

imwrite(f,'������.jpg')

clear;clc
D=rand(5)
MIN=min(min(D.'));
MAX=max(max(D.'));
A=[1,0,1,0;1,0,1,0;1,1,1,1;0,0,1,0];
for i=1:5
    for j=1:5
        if D(i,j)>=0.5
            D(i,j)=1;
        else
            D(i,j)=0;
        end
    end
end

B= logical(D) % B��D���߼�����.
islogical(B)%B���߼�����
C = class_name(B)

g = mat2gray(D)
% % % % % % % % % % % % % % 
yangzhe()
A=[1,1;3,4];
B=[2,-1;3,2];
C=[1,2,2,3;4,5,3,1;2,3,4,1]
A.*B %��һ��=��һ��*��һ��
A(:)
D=logical([1 0;0 1])
A(D)
%����һ�� M*N�ľ�����˵  һ��Ԫ�صķ��� (r,c)  ��ӦԪ���±�Ϊ (c-1)*M+r
% �������
f=@sin%�򵥺������
g=@(x)x.^2;%�����������
g=@(x,y) sqrt(x.^2+y.^2);%�����������
image_stats(f)
y=sinfun1(5)
M=100;
f=@() sinfun1(M);
timeit(f) %���ڵõ��������ÿɿ��ġ����ظ���ʱ�������
M=500:500:20000;
for k=1:numel(M)
    f=@()sinfun1(M(k));
    t(k)=timeit(f);
end
a=timeit(@()sinfun1(20000))
b=timeit(@()sinfun2(20000))
a/b
timeit(@()sinfun3(20000))

% % % % % % % % % % % % % % 
f=timeit(@() twodsin1(1,1/(4*pi),1/(4*pi),512,512))
imshow(f,[ ])
% % % % % % % % % % % % % % 
x = -2:0.25:2;
y = x;
[X,Y] = meshgrid(x);%���ֶ�ά���� meshgrid����
F = X.*exp(-X.^2-Y.^2);
surf(X,Y,F)
% % % % % % % % % % % % % % 
[X,Y]=meshgrid(1:3,10:15)
Z=X+Y
% % % % % % % % % % % % % % 
timeit(@() twodsin2(1,1/(4*pi),1/(4*pi),512,512))%timeit ����ƽ��ʱ��
% % % % % % % % % % % % % % % % % % % % % % % % % % 
A = rand(2,3,4);
B = rand(2,3,5);
C = cat(3,A,B); %ά�ȵ���
szC = size(C)


clear;clc;
filename = uigetdir;  % E:\save_image\wheat_image
file = uigetdir; % E:\save_image\store_image\wheat_image_file
% filename = 'E:\save_image\wheat_image\';
num = length(ls(filename))-2;  % �ļ�����
B = zeros(1516,1516,num);
B = im2uint8(B);
for i=1:num  % [1-143]
    filename_ones=strcat(filename,'\',num2str(i-1,'%04d'),'.png'); %��ȡÿһ��ͼ�����
    C=imread(filename_ones);
    level = graythresh(C);
    C=im2bw(C,level);       % OTSU��ֵ��
    L = bwlabel(C);     % ����ͨ������б�� 
    C = removeLargeArea(C,20000,8); % ȥ����ͨ������
%     C = bwareaopen(C,100,8);
    B(:,:,i)=C*255;             % ÿ��ά�ȴ���B�� B(:,:,i)��ʾͼ�� i-1.png
end
% imshow(B(:,:,3));      % ��֤

CC=bwconncomp(B,26); % ��ȡ��ά��ͨ��
Stats_area = regionprops(CC,'Area'); % 3D ��ͨ������ṹ��
X = struct2cell(Stats_area);   % תΪԪ������
X_1 = cell2mat(X);            % תΪ����
p = find(X_1<1000); %  Ҫ�ҳ�ɾ�� ���С��400  ���±�
STATS = regionprops(CC,'BoundingBox');% ��ά��ͨ��������


cd(file);
if length(ls(file))~=2 % �����Ϊ�� ɾ����·���µ������ļ�
    rmdir '\' s;
end


for i=1:length(STATS)-length(p)
    mkdir(strcat(file,'\',num2str(i-1,'%04d')))
end
k=1;
for i=1:length(STATS)
    if find(p==i)
        continue;
    end
    ONE =  STATS(i).BoundingBox; %�õ�ÿһ���ľ��ε�����ϵ��
    for j=ceil(ONE(3)):floor(ONE(3)+ONE(6)) % z1 - z2  3-70
        I=imcrop(B(:,:,j),[ONE(1),ONE(2),ONE(4),ONE(5)]); %�ü���ͼ��
        file_1=strcat(file,'\',num2str(k-1 ,'%04d'));%ת����ÿ����ͨ���Ŀ¼
        file_2=strcat(file_1,'\',num2str(j-ceil(ONE(3)),'%04d'),'.png');%ÿ����ͨ���б���ͼ��
        imwrite(I,file_2);
    end
    k=k+1;
end






% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
path = 'E:\save_image\store_image\wheat_image_file\';
fileinfo = dir(path);
length(fileinfo); 


rectangle('Position', STATS(1).BoundingBox);




% % % % % % % % % % % % % % ������ͨ���ļ�
clear;clc;
cd('E:\save_image\store_image\wheat_image_file')
for i=1:length(STATS)
    mkdir(num2str(i-1,'%04d'))
end


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
clear;clc;
selpath = uigetdir;  % E:\save_image\wheat_image

