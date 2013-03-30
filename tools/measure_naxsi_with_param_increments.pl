#!/usr/bin/perl

use strict;
use warnings;

my $mode;
if (#$ARGV < 1) {
        if ($ARGV[0] == "wordpress") {
                $mode = "wordpress";
        } else {
                $mode = "http";
        }
} else {
        exit (-1);
}


open FILE, ">results.csv";

my $param = "";

for (my $i = 0; $i<=21; $i += 1) {
        if ($mode == "wordpress") {
                my $ret = `autobench --single_host --host1 wp_with_naxsi.test.nl --uri1 '/index.php?$param' --low_rate 190 --high_rate 190 --rate_step 1 --num_call 1 --const_test_time 60 | grep '^190' | cut -f 8`;
        } else {
                my $ret = `./bench.pl --step 1 --duration 60 --rounds 5 --low_con 380 --high_con 380 'http://200_with_naxsi.test.nl/?$param' | cut -d ',' -f 2-`;
        }

        chomp ($ret);
        print FILE "$i,$ret\n";

        if ($i gt 0) {
                $param = "";
                for (my $j=1; $j<=$i; $j++) {
                        $param .= "&foo$j=bar$j"
                }
                $param .= "&../";
        } else {
                $param = "../";
        }
}

close FILE

