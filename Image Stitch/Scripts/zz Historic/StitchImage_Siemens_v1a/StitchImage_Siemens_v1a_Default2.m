%====================================================
%
%====================================================

function [default] = StitchImage_Siemens_v1a_Default2(SCRPTPATHS)

global COMPASSINFO

stitchpath = SCRPTPATHS.voyagerloc;
stitchdatafunc = 'StitchData_SiemensLocal_v1a';
stitchrunfunc = 'StitchRun_SiemensLocal_v1a';
stitchoptfunc = 'StitchOptions_ListAll_v1a';
stitchreconfunc = 'StitchRecon_Standard_v1a';

m = 1;
default{m,1}.entrytype = 'OutputName';
default{m,1}.labelstr = 'Image_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'ScriptName';
default{m,1}.labelstr = 'Script_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'RunExtFunc';
default{m,1}.labelstr = 'Dat_File';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Select';
default{m,1}.runfunc1 = 'SelectSiemensDataCur';
default{m,1}.(default{m,1}.runfunc1).curloc = SCRPTPATHS.experimentsloc;
default{m,1}.(default{m,1}.runfunc1).defloc = COMPASSINFO.USERGBL.tempdataloc;
default{m,1}.runfunc2 = 'SelectSiemensDataDisp';
default{m,1}.searchpath = SCRPTPATHS.scrptshareloc;
default{m,1}.path = SCRPTPATHS.scrptshareloc;

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'StitchDatafunc';
default{m,1}.entrystr = stitchdatafunc;
default{m,1}.searchpath = stitchpath;
default{m,1}.path = [stitchpath,stitchdatafunc];

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'StitchRunfunc';
default{m,1}.entrystr = stitchrunfunc;
default{m,1}.searchpath = stitchpath;
default{m,1}.path = [stitchpath,stitchrunfunc];

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'StitchOptionsfunc';
default{m,1}.entrystr = stitchoptfunc;
default{m,1}.searchpath = stitchpath;
default{m,1}.path = [stitchpath,stitchoptfunc];

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'StitchReconfunc';
default{m,1}.entrystr = stitchreconfunc;
default{m,1}.searchpath = stitchpath;
default{m,1}.path = [stitchpath,stitchreconfunc];

m = m+1;
default{m,1}.entrytype = 'RunScrptFunc';
default{m,1}.scrpttype = 'Image';
default{m,1}.labelstr = 'Create Image';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Run';

