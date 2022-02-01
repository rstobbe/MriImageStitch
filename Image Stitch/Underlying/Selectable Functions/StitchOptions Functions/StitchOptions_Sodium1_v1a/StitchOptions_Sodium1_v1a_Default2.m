%====================================================
%
%====================================================

function [default] = StitchOptions_Sodium1_v1a_Default2(SCRPTPATHS)

global COMPASSINFO

m = 1;
default{m,1}.entrytype = 'RunExtFunc';
default{m,1}.labelstr = 'Recon_File';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Load';
default{m,1}.runfunc1 = 'LoadTrajImpCur';
default{m,1}.(default{m,1}.runfunc1).curloc = SCRPTPATHS.outloc;
default{m,1}.runfunc2 = 'LoadTrajImpDef';
default{m,1}.(default{m,1}.runfunc2).defloc = COMPASSINFO.USERGBL.trajreconloc;

m = m+1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'ZeroFill';
default{m,1}.entrystr = 64;
mat = (64:16:960).';
default{m,1}.options = mat2cell(mat,length(mat));

m = m+1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'Fov2Return';
default{m,1}.entrystr = 'Design';
default{m,1}.options = {'All','Design'};




