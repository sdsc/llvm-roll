#!/usr/bin/perl -w
# llvm roll installation test.  Usage:
# llvm.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/llvm';
my $output;

my $TESTFILE = 'tmpllvm';

if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'llvm installed');
} else {
  ok(! $isInstalled, 'llvm not installed');
}

`mkdir $TESTFILE.dir`;
open(OUT, ">$TESTFILE.sh");
  print OUT <<END;
module load llvm
cd $TESTFILE.dir
cp \$LLVMHOME/example/* .
g++ test.c `llvm-config --cxxflags --ldflags --libs core executionengine interpreter analysis native bitwriter --system-libs` 
./a.out <<EOF
4+5;
EOF
END
SKIP: {

  skip 'llvm not installed', 4 if ! $isInstalled;
  $output = `bash $TESTFILE.sh 2>&1`;
  like($output, qr/ret double 9.000000e\+00/, 'llvm works');
  `/bin/ls /opt/modulefiles/applications/llvm/[0-9]* 2>&1`;
  ok($? == 0, 'llvm module installed');
  `/bin/ls /opt/modulefiles/applications/llvm/.version.[0-9]* 2>&1`;
  ok($? == 0, 'llvm version module installed');
  ok(-l '/opt/modulefiles/applications/llvm/.version',
     'llvm version module link created');

}

`rm -fr $TESTFILE*`;
