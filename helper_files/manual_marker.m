clear;
[FilePath PathStr FileName Ext Index] = GetFilePath();
num = input('Enter number of data = ');

%% specify the size of the vessel purposely
yr_half = 40;
xr_half = 40;

%
im = double(imread(FilePath));
ims = imread(FilePath);
figure(1);% imagesc(im); colormap(gray); 
imshow(ims);

title('Click on point-of-interest to track'); hold on;
[x,y] = ginput(1); % read in coordinates of POI
xcent(1) = round(x);
ycent(1) = round(y);

im_roi = im(ycent(1)-yr_half:ycent(1)+yr_half,xcent(1)-xr_half:xcent(1)+xr_half);

for i = str2num(FileName):str2num(FileName) + (num-1)
    FilePath = strcat(PathStr,'/',num2str(i),Ext);
    I = imread(FilePath);
    %     im_roi = double(rgb2gray(I));
    im1 = double(I);
    
    figure(1); 
    %imagesc(im1); colormap(gray);
    imshow(I);
    
    title(strcat('Start Markering, Click The Border Area For Switch The Next Frame, Frame: ',num2str(i))); hold on;
    %     ButtonHandle = uicontrol('Style', 'PushButton', ...
    %         'String', 'Stop loop', ...
    %         'Callback', 'delete(gcbf)');
    %     key = get(gcf,'currentcharacter');
    %     stop=uicontrol('style','toggle','string','nextFrame','background','white');
    %                 textLabel = sprintf('Variable C = %f', C(xr_half,yr_half));
    %             set(handles.text1, 'String', textLabel);
    eh = uicontrol('Style','edit','String','NCC value');
    j = 1;
    m=[];
   while true
        

        %         if ~ishandle(ButtonHandle)
        %             break;
        %         else
        [x,y] = ginput(1); % read in coordinates of POI
        xcent(1) = round(x);
        ycent(1) = round(y);

        try
      
            m(j,:) = [x y];
            j = j+1; 
            im_nt = im1(ycent(1)-yr_half:ycent(1)+yr_half,xcent(1)-xr_half:xcent(1)+xr_half); % define template (regio-of-interest)
            %template matching score C
            C = template_matching2(im_roi,im_nt);
            %     C = MI_GG(im_roi,im_nt);
            %     [ymaxcorr,xmaxcorr]=find(C==max(C(:)));
            %     disp(num2str(ymaxcorr));
            %     disp(num2str(xmaxcorr));
            disp(num2str(C(xr_half,yr_half)));
            eh = uicontrol('Style','edit','String',num2str(C(xr_half,yr_half)));
            %% Instruction of your cursor placement to acquire the max NCC
            [ymaxcorr,xmaxcorr]=find(C==max(C(:)));
            diff_y = ymaxcorr - (yr_half+1);
            diff_x = xmaxcorr - (xr_half+1);
            if (diff_y<0)
                disp('towards up');
            else if (diff_y==0)
                    disp('perfect up-down');
                else
                    disp('towards down');
                end
            end
            
            if (diff_x<0)
                disp('towards left');
            else if (diff_x==0)
                    disp('perfect left-right');
                else
                    disp('towards right');
                end
            end
            
            if (diff_x==0&&diff_y==0)
                eh = uicontrol('Style','text','String',strcat(num2str(C(xr_half,yr_half)),'Perfect'));
            end
            
        catch
            marker(i,:) = [i; m(end-1,1); m(end-1,2)];
            break;
        end

    end
    
%     marker(i,:) = m(end-1,:);
end
dlmwrite('marker.csv',marker,'precision',9);    % type:[frameindex; x; y]
