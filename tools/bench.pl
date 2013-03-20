#!/usr/bin/perl

use strict;
use warnings;
use Switch;
use Time::Local;

my $url = "http://200_without_naxsi.test.nl/";
my $rounds;
my $step;
my $duration;
my $low_con;
my $high_con;
my $file;

for (my $i=0; $i <= $#ARGV; $i++) {
	switch ($ARGV[$i]) {
		case '--step' {
			$step = $ARGV[$i + 1];
		}
		case '--duration' {
			$duration = $ARGV[$i + 1];
		}
		case '--rounds' {
			$rounds = $ARGV[$i + 1];
		}
		case '--low_con' {
			$low_con = $ARGV[$i + 1];
		}
		case '--high_con' {
			$high_con = $ARGV[$i + 1];
		}
		case '--file' {
			$file = $ARGV[$i + 1];
		}
	}
}

$url = $ARGV[$#ARGV];

if (!defined ($step) || !defined ($duration) || !defined ($rounds) || !defined ($low_con) || !defined ($high_con) || !defined ($file) || !defined ($url)) {
	print ("Usage: \./bench.pl options http://hostname[:port]/path\n");
	print ("Options are:\n");
	print ("\t--step\t\tNumber of concurrent connection to increment each step with\n");
	print ("\t--duration\tSeconds to max. wait for sponses for each round. ab implies -n 50000\n");
	print ("\t--rounds\tNumber of rounds to repeat each test\n");
	print ("\t--low_con\tNumber of concurrent connections to start with\n");
	print ("\t--high_con\tNumber of concurrent connection to end with\n");
	print ("\t--file\tOutput file\n");

	exit (-1);
}

my $hours= ($high_con - $low_con + $step) / $step * $rounds * $duration / 3600;
my $minutes= ($high_con - $low_con + $step) / $step * $rounds * $duration / 60;

if ($hours >= 1) {
	printf ("Expected time needed: %.2f hours\n", $hours);
} else {
	printf ("Expected time needed: %.2f minutes\n", $minutes);
}

open FILE, ">$file" or die $!;

for (my $i=$low_con; $i<=$high_con; $i+=$step) {
	my $low = 0;
	my $high = 0;
	my $avg = 0;
	my $total = 0;

	for (my $j=0; $j<$rounds; $j++) {
		my @ret=`ab -c $i -t $duration $url 2>/dev/null`;

		foreach my $line (@ret) {
			chomp ($line);

			if ($line =~ m/^Requests per second:\ *([0-9]+\.[0-9]{2})/) {
				if ($1 < $low || $low == 0) {
					$low = $1;
				}

				if ($1 > $high) {
					$high = $1;
				}

				$total += $1;
			}
		}
	}	

	$avg = $total / $rounds;
	print FILE "$i,$avg,$low,$high\n";

	#printf ("%.2f%% completed\n", 100 * ($i - $low_con) / ($high_con / $step - $low_con));
	printf ("%.2f%% completed\n", 100 * ($i - $low_con + $step) / ($high_con - $low_con + $step));
}

close FILE
