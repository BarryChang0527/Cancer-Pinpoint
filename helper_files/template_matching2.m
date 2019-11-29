function [I_NCC,Idata]=template_matching2(T,I)


T=double(T); I=double(I);

% Calculate correlation output size  = input size + padding template
T_size = size(T); I_size = size(I);
outsize = I_size + T_size-1;

% calculate correlation in frequency domain
if(length(T_size)==2)
    FT = fft2(rot90(T,2),outsize(1),outsize(2));%对T做离散FFT
    
    Idata.FI = fft2(I,outsize(1),outsize(2));%对I做离散FFT
    
    Icorr = real(ifft2(Idata.FI.* FT));%傅立叶变换乘以傅立叶变换
else %N/A
    FT = fftn(rot90_3D(T),outsize);
    FI = fftn(I,outsize);
    Icorr = real(ifftn(FI.* FT));
end

% Calculate Local Quadratic sum of Image and Template

Idata.LocalQSumI= local_sum(I.*I,T_size);


QSumT = sum(T(:).^2); %求平方


% Normalized cross correlation STD

Idata.LocalSumI= local_sum(I,T_size);


% Standard deviation

Idata.stdI=sqrt(max(Idata.LocalQSumI-(Idata.LocalSumI.^2)/numel(T),0) );

stdT=sqrt(numel(T)-1)*std(T(:));
% Mean compensation
meanIT=Idata.LocalSumI*sum(T(:))/numel(T);
I_NCC= 0.5+(Icorr-meanIT)./ (2*stdT*max(Idata.stdI,stdT/1e5));

% Remove padding
I_NCC=unpadarray(I_NCC,size(I));
end

function T=rot90_3D(T)
T=flipdim(flipdim(flipdim(T,1),2),3);
end

function B=unpadarray(A,Bsize)
Bstart=ceil((size(A)-Bsize)/2)+1;
Bend=Bstart+Bsize-1;
  if(ndims(A)==2)
      B=A(Bstart(1):Bend(1),Bstart(2):Bend(2));
      elseif(ndims(A)==3)
        B=A(Bstart(1):Bend(1),Bstart(2):Bend(2),Bstart(3):Bend(3));
  end
end 

function local_sum_I= local_sum(I,T_size)
    % Add padding to the image
    B = padarray(I,T_size);
    
    % Calculate for each pixel the sum of the region around it,
    % with the region the size of the template.
    if(length(T_size)==2)
        % 2D localsum
        s = cumsum(B,1);
        c = s(1+T_size(1):end-1,:)-s(1:end-T_size(1)-1,:);
        s = cumsum(c,2);
        local_sum_I= s(:,1+T_size(2):end-1)-s(:,1:end-T_size(2)-1);
    else
        % 3D Localsum
        s = cumsum(B,1);
        c = s(1+T_size(1):end-1,:,:)-s(1:end-T_size(1)-1,:,:);
        s = cumsum(c,2);
        c = s(:,1+T_size(2):end-1,:)-s(:,1:end-T_size(2)-1,:);
        s = cumsum(c,3);
        local_sum_I  = s(:,:,1+T_size(3):end-1)-s(:,:,1:end-T_size(3)-1);
    end
end