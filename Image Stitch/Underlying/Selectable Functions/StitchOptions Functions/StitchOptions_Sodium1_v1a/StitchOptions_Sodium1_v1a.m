%=====================================================
% (v1a)
%=====================================================

function [SCRPTipt,OPT,err] = StitchOptions_Sodium1_v1a(SCRPTipt,OPTipt)

Status2('busy','Stitch Options',2);
Status2('done','',2);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OPT.method = OPTipt.Func;
OPT.ZeroFill = str2double(OPTipt.('ZeroFill'));
OPT.Fov2Return = OPTipt.('Fov2Return');

if isfield(OPTipt.('Recon_File').Struct,'selectedfile')
    OPT.TrajFile = OPTipt.('Recon_File').Struct.selectedfile;
    OPT.TrajName = OPTipt.('Recon_File').Struct.filename;
else
    err.flag = 1;
    err.msg = '(Re) Load Recon_File';
    ErrDisp(err);
    return
end

Status2('done','',2);
Status2('done','',3);









