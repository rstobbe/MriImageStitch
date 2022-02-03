%=====================================================
%
%=====================================================

function [OPT,err] = StitchOptions_LungWater1_v1a_Func(OPT,INPUT)

Status2('busy','Stitch Setup',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Create Object
%---------------------------------------------
Options = StitchLungWater1aOptions(); 

Options.SetAcqInfoFile(OPT.TrajFile);
Options.SetFov2Return([OPT.Fov2Return OPT.Fov2Return OPT.Fov2Return]); 
Options.SetStitchSupportingPath('D:\StitchSupportingExtended\');
Options.SetZeroFill(OPT.ZeroFill);
Options.SetTrajMashFunc(OPT.TrajMashFunc);

Recon = StitchLungWater1a(Options);
Recon.Log.SetVerbosity(3);
Recon.Setup;

OPT.Recon = Recon;

Status2('done','',2);
Status2('done','',3);

