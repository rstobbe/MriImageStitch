%====================================================
% (v1a)
%      
%====================================================

function [SCRPTipt,SCRPTGBL,err] = StitchImage_Local_v1a(SCRPTipt,SCRPTGBL)

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
IMG.stitchdatafunc = SCRPTGBL.CurrentTree.('StitchDatafunc').Func;
IMG.stitchoptionsfunc = SCRPTGBL.CurrentTree.('StitchOptionsfunc').Func;

%---------------------------------------------
% Get Working Structures from Sub Functions
%---------------------------------------------
STCHDATAipt = SCRPTGBL.CurrentTree.('StitchDatafunc');
if isfield(SCRPTGBL,('StitchDatafunc_Data'))
    STCHDATAipt.StitchDatafunc_Data = SCRPTGBL.StitchDatafunc_Data;
end
STCHOPTipt = SCRPTGBL.CurrentTree.('StitchOptionsfunc');
if isfield(SCRPTGBL,('StitchOptionsfunc_Data'))
    STCHOPTipt.StitchOptionsfunc_Data = SCRPTGBL.StitchOptionsfunc_Data;
end

%------------------------------------------
% Import Function Info
%------------------------------------------
func = str2func(IMG.stitchdatafunc); 
[SCRPTipt,SCRPTGBL,STCHDATA,err] = func(SCRPTipt,SCRPTGBL,STCHDATAipt);
if err.flag
    return
end
func = str2func(IMG.stitchoptionsfunc); 
[SCRPTipt,STCHOPT,err] = func(SCRPTipt,STCHOPTipt);
if err.flag
    return
end

%---------------------------------------------
% Stitch Image
%---------------------------------------------
func = str2func([IMG.method,'_Func']);
INPUT.STCHDATA = STCHDATA;
INPUT.STCHOPT = STCHOPT;
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
if auto == 0
    name = inputdlg('Name Image:','Name Image',[1 60],{IMG.name});
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
