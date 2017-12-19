% for a range of sn in position, estimates the corresponding 
% mean flux bias caused by missing the peak 
% can use different psfs for 

n = 200 ; pix = 1 ; box2 = n*pix ; x = box2*(-n:n)/n ; y = x ; 
[xx, yy] = meshgrid(x,y); rr = sqrt(xx.^2+yy.^2) ; 
sig_phot = 26  ;% sigma of psf for photometry 18.4 26, 36 
sig_det = 18.4 ;% sigma of psf for photometry

zz = exp(-rr.^2/sig_phot^2/2); % psf
nsamp = 100000;
nsn = 100 ; 
sn = linspace(2,10,nsn) ;
sigflux = zeros(size(sn)) ; 
meanflux = zeros(size(sn)) ; 
for isn = 1:nsn
sigpos = 0.6*sig_det/sn(isn); % sigma of positional error
xr = randn(nsamp,1)*sigpos ; yr = randn(nsamp,1)*sigpos ;  
out = abs(xr)>box2 ; xr(out) = sign(xr(out))*box2 ; 
out = abs(yr)>box2 ; yr(out) = sign(yr(out))*box2 ; 
ix = floor((xr+1)*n/box2)+n+1 ; iy = floor((yr+1)*n/box2)+n+1 ; 
zr = zz(sub2ind(size(zz),iy,ix)) ; 
rrr = sqrt(xr.^2+yr.^2) ; 
plot(rrr(:),zr(:),'.') ; 
meanflux(isn) = mean(zr(:)) ;
sigflux(isn)  = std(zr(:)) ; 

end

titext = sprintf('\\sigma_{psf}=%6.1f, \\sigma_{det}=%6.1f',sig_phot,sig_det); 
figure(1) ; plot(sn,sigflux) ; title(titext)
xlabel('signal/noise in detection image') ; ylabel('std dev flux') ; 
figure(2) ; plot(sn,meanflux) ; title(titext)
xlabel('signal/noise in detection image') ; ylabel('mean flux') ; 

