% % % % % % % % % % % clear;clc
f=imread('草莓.jpg');%%%imshow
% c=imread('下载.jpg');
% imshow(f)
% figure,imshow(c)
help imwrite

imwrite(f,'星月神话.jpg')

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

B= logical(D) % B是D的逻辑数组.
islogical(B)%B是逻辑数组
C = class_name(B)

g = mat2gray(D)
% % % % % % % % % % % % % % 
yangzhe()
A=[1,1;3,4];
B=[2,-1;3,2];
C=[1,2,2,3;4,5,3,1;2,3,4,1]
A.*B %第一项=第一项*第一项
A(:)
D=logical([1 0;0 1])
A(D)
%对于一个 M*N的矩阵来说  一个元素的访问 (r,c)  对应元素下标为 (c-1)*M+r
% 函数句柄
f=@sin%简单函数句柄
g=@(x)x.^2;%匿名函数句柄
g=@(x,y) sqrt(x.^2+y.^2);%匿名函数句柄
image_stats(f)
y=sinfun1(5)
M=100;
f=@() sinfun1(M);
timeit(f) %用于得到函数调用可靠的、可重复的时间测量。
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
[X,Y] = meshgrid(x);%划分二维网格 meshgrid函数
F = X.*exp(-X.^2-Y.^2);
surf(X,Y,F)
% % % % % % % % % % % % % % 
[X,Y]=meshgrid(1:3,10:15)
Z=X+Y
% % % % % % % % % % % % % % 
timeit(@() twodsin2(1,1/(4*pi),1/(4*pi),512,512))%timeit 测量平均时间
% % % % % % % % % % % % % % % % % % % % % % % % % % 
A = rand(2,3,4);
B = rand(2,3,5);
C = cat(3,A,B); %维度叠加
szC = size(C)


clear;clc;
filename = uigetdir;  % E:\save_image\wheat_image
file = uigetdir; % E:\save_image\store_image\wheat_image_file
% filename = 'E:\save_image\wheat_image\';
num = length(ls(filename))-2;  % 文件个数
B = zeros(1516,1516,num);
B = im2uint8(B);
for i=1:num  % [1-143]
    filename_ones=strcat(filename,'\',num2str(i-1,'%04d'),'.png'); %读取每一个图像矩阵
    C=imread(filename_ones);
    level = graythresh(C);
    C=im2bw(C,level);       % OTSU二值化
    L = bwlabel(C);     % 对连通区域进行标记 
    C = removeLargeArea(C,20000,8); % 去除连通域最大的
%     C = bwareaopen(C,100,8);
    B(:,:,i)=C*255;             % 每个维度存入B中 B(:,:,i)表示图像 i-1.png
end
% imshow(B(:,:,3));      % 验证

CC=bwconncomp(B,26); % 获取三维连通域
Stats_area = regionprops(CC,'Area'); % 3D 连通域体积结构体
X = struct2cell(Stats_area);   % 转为元胞数组
X_1 = cell2mat(X);            % 转为数组
p = find(X_1<1000); %  要找出删除 体积小于400  的下标
STATS = regionprops(CC,'BoundingBox');% 三维连通域外界矩形


cd(file);
if length(ls(file))~=2 % 如果不为空 删除此路径下的所有文件
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
    ONE =  STATS(i).BoundingBox; %得到每一个的矩形的坐标系列
    for j=ceil(ONE(3)):floor(ONE(3)+ONE(6)) % z1 - z2  3-70
        I=imcrop(B(:,:,j),[ONE(1),ONE(2),ONE(4),ONE(5)]); %裁剪的图像
        file_1=strcat(file,'\',num2str(k-1 ,'%04d'));%转换到每个连通域的目录
        file_2=strcat(file_1,'\',num2str(j-ceil(ONE(3)),'%04d'),'.png');%每个连通域中保存图像
        imwrite(I,file_2);
    end
    k=k+1;
end






% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
path = 'E:\save_image\store_image\wheat_image_file\';
fileinfo = dir(path);
length(fileinfo); 


rectangle('Position', STATS(1).BoundingBox);




% % % % % % % % % % % % % % 创建连通域文件
clear;clc;
cd('E:\save_image\store_image\wheat_image_file')
for i=1:length(STATS)
    mkdir(num2str(i-1,'%04d'))
end


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
clear;clc;
selpath = uigetdir;  % E:\save_image\wheat_image

