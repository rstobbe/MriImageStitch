%====================================================
%  
%====================================================

function [IMG,err] = StitchImage_Local_v1a_Func(INPUT,IMG)

Status('busy','Create Image');
Status2('done','',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
STCHDATA = INPUT.STCHDATA;
STCHOPT = INPUT.STCHOPT;
clear INPUT;

%----------------------------------------------
% Stitch Recon
%----------------------------------------------
func = str2func([IMG.stitchoptionsfunc,'_Func']);  
INPUT = [];
[STCHOPT,err] = func(STCHOPT,INPUT);
if err.flag
    return
end
clear INPUT;

%----------------------------------------------
% Stitch Data
%----------------------------------------------
func = str2func([IMG.stitchdatafunc,'_Func']);  
INPUT = [];
[STCHDATA,err] = func(STCHDATA,INPUT);
if err.flag
    return
end
clear INPUT;

%----------------------------------------------
% Stitch Run
%----------------------------------------------
Status2('busy','Stitch Run',2);
STCHOPT.Recon.CreateImage(STCHDATA.DataObj);
IMG = STCHOPT.Recon.ReturnIMG;

Status2('done','',1);
Status2('done','',2);
Status2('done','',3);


