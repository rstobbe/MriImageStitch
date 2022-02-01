%====================================================
% (v1a)
%      
%====================================================

function [SCRPTipt,SCRPTGBL,err] = StitchImage_Siemens_v1a(SCRPTipt,SCRPTGBL)

Status('busy','Create Image');
Status2('done','',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Clear Naming
%---------------------------------------------
inds = strcmp('Image_Name',{SCRPTipt.labelstr});
indnum = find(inds==1);
if length(indnum) > 1
    indnum = indnum(SCRPTGBL.RWSUI.scrptnum);
end
SCRPTipt(indnum).entrystr = '';
setfunc = 1;
DispScriptParam(SCRPTipt,setfunc,SCRPTGBL.RWSUI.tab,SCRPTGBL.RWSUI.panelnum);
SCRPTipt0 = SCRPTipt;

%---------------------------------------------
% Load Input
%---------------------------------------------
IMG.method = SCRPTGBL.CurrentTree.Func;
IMG.stitchoptfunc = SCRPTGBL.CurrentTree.('StitchOptfunc').Func;
IMG.stitchrunfunc = SCRPTGBL.CurrentTree.('StitchRunfunc').Func;
IMG.stitchreconfunc = SCRPTGBL.CurrentTree.('StitchReconfunc').Func;

%---------------------------------------------
% Get Working Structures from Sub Functions
%---------------------------------------------
STCHRUNipt = SCRPTGBL.CurrentTree.('StitchRunfunc');
if isfield(SCRPTGBL,('StitchRunfunc_Data'))
    STCHRUNipt.StitchRunfunc_Data = SCRPTGBL.StitchRunfunc_Data;
end
STCHOPTipt = SCRPTGBL.CurrentTree.('StitchOptfunc');
if isfield(SCRPTGBL,('StitchOptfunc_Data'))
    STCHOPTipt.StitchOptfunc_Data = SCRPTGBL.StitchOptfunc_Data;
end
STCHRECONipt = SCRPTGBL.CurrentTree.('StitchReconfunc');
if isfield(SCRPTGBL,('StitchReconfunc_Data'))
    STCHRECONipt.StitchReconfunc_Data = SCRPTGBL.StitchReconfunc_Data;
end

%------------------------------------------
% Import Function Info
%------------------------------------------
func = str2func(IMG.stitchoptfunc); 
[SCRPTipt,SCRPTGBL,STCHOPT,err] = func(SCRPTipt,SCRPTGBL,STCHOPTipt);
if err.flag
    return
end
func = str2func(IMG.stitchrunfunc); 
[SCRPTipt,SCRPTGBL,STCHRUN,err] = func(SCRPTipt,SCRPTGBL,STCHRUNipt);
if err.flag
    return
end
func = str2func(IMG.stitchreconfunc); 
[SCRPTipt,SCRPTGBL,STCHRECON,err] = func(SCRPTipt,SCRPTGBL,STCHRECONipt);
if err.flag
    return
end

%---------------------------------------------
% Stitch Image
%---------------------------------------------
func = str2func([IMG.method,'_Func']);
INPUT.STCHOPT = STCHOPT;
INPUT.STCHRUN = STCHRUN;
INPUT.STCHRECON = STCHRECON;
[IMG,err] = func(INPUT,IMG);
if err.flag
    return
end

%--------------------------------------------
% Output to TextBox
%--------------------------------------------
IMG.ExpDisp = PanelStruct2Text(IMG.PanelOutput);
global FIGOBJS
FIGOBJS.(SCRPTGBL.RWSUI.tab).Info.String = IMG.ExpDisp;

%--------------------------------------------
% Determine if AutoSave
%--------------------------------------------
auto = 0;
RWSUI = SCRPTGBL.RWSUI;
if isfield(RWSUI,'ExtRunInfo')
    auto = 1;
    if strcmp(RWSUI.ExtRunInfo.save,'no')
        SCRPTGBL.RWSUI.SaveScript = 'no';
        SCRPTGBL.RWSUI.SaveGlobal = 'no';
    elseif strcmp(RWSUI.ExtRunInfo.save,'all')
        SCRPTGBL.RWSUI.SaveScript = 'yes';
        SCRPTGBL.RWSUI.SaveGlobal = 'yes';
    elseif strcmp(RWSUI.ExtRunInfo.save,'global')
        SCRPTGBL.RWSUI.SaveScript = 'no';
        SCRPTGBL.RWSUI.SaveGlobal = 'yes';
    end
    name = ['IMG_',RWSUI.ExtRunInfo.name];
else
    SCRPTGBL.RWSUI.SaveScriptOption = 'yes';
    SCRPTGBL.RWSUI.SaveGlobal = 'yes';
end

%--------------------------------------------
% Name
%--------------------------------------------
%--
if isfield(FID,'DATA')
    ind = strfind(FID.DATA.file,'_');                           % hack
    FID.DATA.mid = FID.DATA.file(ind(1)+1:ind(2)-1);
    ind = strfind(FID.DATA.VolunteerID,'.');
    if not(isempty(ind))
        FID.DATA.VolunteerID2 = FID.DATA.VolunteerID(ind(end)+1:end);
    else
        FID.DATA.VolunteerID2 = FID.DATA.VolunteerID;
    end
end
%---

if auto == 0
    if isfield(FID,'DATA')
        name = inputdlg('Name Image:','Name Image',1,{['IMG_',FID.DATA.VolunteerID2,'_',FID.DATA.mid,'_',FID.DATA.Protocol]});
    elseif isfield(FID,'SAMP')
        name = inputdlg('Name Image:','Name Image',1,{['IMG_',FID.SAMP.OB.name]});
    else
        name = inputdlg('Name Image:','Name Image',1,{['IMG_',FID.DatName]});
    end
    name = cell2mat(name);
    if isempty(name)
        SCRPTipt = SCRPTipt0;
        setfunc = 1;
        DispScriptParam(SCRPTipt,setfunc,SCRPTGBL.RWSUI.tab,SCRPTGBL.RWSUI.panelnum);
        SCRPTGBL.RWSUI.SaveVariables = {IMG};
        SCRPTGBL.RWSUI.KeepEdit = 'yes';
        return
    end
end

if isempty(IMG.FID.path)
    IMG.path = IC.IMPLD.IMP.path;
else
    IMG.path = IMG.FID.path;
end 
IMG.name = name;
IMG.type = 'Image';   

%---------------------------------------------
% Return
%---------------------------------------------
SCRPTipt(indnum).entrystr = IMG.name;
SCRPTGBL.RWSUI.SaveVariables = IMG;
SCRPTGBL.RWSUI.SaveVariableNames = 'IMG';
SCRPTGBL.RWSUI.SaveGlobalNames = IMG.name;
SCRPTGBL.RWSUI.SaveScriptPath = IMG.path;
SCRPTGBL.RWSUI.SaveScriptName = IMG.name;

Status('done','');
Status2('done','',2);
Status2('done','',3);
