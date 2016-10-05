use Config::Simple;
open(OUTF,"Radm_log.htm") or dienice("Can't open survey.out: $!");
@ary = <OUTF>;
$cfg = new Config::Simple('lastup.cfg');
$lastup = $cfg->param("lastupdate");
$lasttime = $cfg->param("lasttime");
$separator = ",";
close(OUTF);
$fromdate =0;
$lasttm =0;
$lasttmcfg="";
$lastdtcfg="";
 foreach $line (@ary) {
 
    if ($line =~ m/RServer3/){
	
	if ($line =~ m/$lastup/){
	$fromdate++;
		if ($line =~ m/$lasttime/){
		$lasttm++;
		}
	}	
	
    if (($fromdate>0)&&($lasttm>0)){

	my @radmin = split(/ +/,$line, 5);
    print "@radmin[2]";
	print $separator;
	$lasttmcfg = @radmin[3];
	$lastdtcfg = @radmin[2];
	print "@radmin[3]";
	print $separator;
	$str_br = @radmin[4];
	$find = "<br>";
	$replace = "";
	$str_br =~ s/$find/$replace/g;
	print $str_br;	
	}
    }
		$cfg->param("lastupdate", "$lastdtcfg");
		$cfg->param("lasttime", "$lasttmcfg");

    }
	  $cfg->write();