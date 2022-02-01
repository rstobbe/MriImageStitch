%====================================================
%
%====================================================

function [default] = StitchImage_Local_v1a_Default2(SCRPTPATHS)

stitchpath = SCRPTPATHS.voyagerloc;
stitchdatafunc = 'StitchData_SiemensLocal_v1a';
stitchoptionsfunc = 'StitchOptions_Sodium1_v1a';

m = 1;
default{m,1}.entrytype = 'OutputName';
default{m,1}.labelstr = 'Image_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'ScriptName';
default{m,1}.labelstr = 'Script_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'StitchDatafunc';
default{m,1}.entrystr = stitchdatafunc;
default{m,1}.searchpath = stitchpath;
default{m,1}.path = [stitchpath,stitchdatafunc];

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'StitchOptionsfunc';
default{m,1}.entrystr = stitchoptionsfunc;
default{m,1}.searchpath = stitchpath;
default{m,1}.path = [stitchpath,stitchoptionsfunc];

m = m+1;
default{m,1}.entrytype = 'RunScrptFunc';
default{m,1}.scrpttype = 'Image';
default{m,1}.labelstr = 'Create Image';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Run';

