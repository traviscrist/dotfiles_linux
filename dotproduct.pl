#!/usr/bin/env perl
use strict;
use warnings;

use YAML::XS;
use File::Slurp;

sub in {
	my ($v, @a) = @_;
	return (grep {$_ eq $v} @a);
}

sub subdir {
	my ($dir, $sdir) = @_;

	if ($dir =~ /^(.+?)\/*$/) {
		return $1 . '/' . $sdir;
	}
	return;
}
sub superdir {
	return subdir($_[0], "..");
}

sub usage {
	print "usage: dotproduct.pl <config.yml> <target (optional)>\n";
}
sub getArgs {
	my @args = ();
	if (defined $ARGV[0]) {
		push @args, $ARGV[0];
	} else {
		usage();
		exit;
	}
	if (defined $ARGV[1]) {
		push @args, $ARGV[1];
	} else {
		push @args, "";
	}
	return @args;
}
sub withinTarget {
	my ($dref, $target) = @_;

	if (exists $dref->{target}) {
		return ($dref->{target} eq $target);
	}
	return 1;
}

sub YAMLfromFile {
	my $file = shift;
	my $yaml = YAML::XS::LoadFile($file)
		or die "could not parse file as YAML";
	return $yaml;
}

sub processEntry {
	my ($file, $dref, $vref) = @_;

	my $src = $dref->{source}
		or die "could not find source for $file";
	my $dest = $dref->{destination}
		or die "could not find destination for $file";	
	my $delim = $dref->{delimeter} if exists $dref->{delimeter};

	if (-f $src) {
		processFile($src, $dest, $vref, $delim);
	} elsif (-d $src) {
		processFile($src, $dest, $vref, $delim);
	}
}
sub processFile {
	my ($src, $dest, $vref, $delim) = @_;


	if (-d $src) {
		opendir DIR, $src;
		while (readdir DIR) {
			if ($_ ne '.' && $_ ne '..') {
				processFile(subdir($src,$_), subdir($dest, $_), $vref, $delim);
			}
		}
		closedir DIR;
		return;
	}

	my $text = read_file($src);
	$text = replacePatterns($text, $vref, $delim) if defined $delim;

	copyToFile($text, $dest);
}

sub replacePatterns {
	my ($text, $vref, $delim) = @_;

	my $newtext = '';
	my $isvar = 0;
	foreach my $part (split /$delim/, $text) {

		if ($isvar && exists $vref->{$part}) {
			$newtext .= $vref->{$part};
		} else {
			$newtext .= $part;
		}
		$isvar = not $isvar;	
	}
	return $newtext;
}
sub copyToFile {
	my ($text, $dest) = @_;

	print "copying $dest\n";

	open FILE, '>', $dest
		or die "could not open $dest";
	print FILE $text;	
	close FILE;
}
sub runCommand {
	my ($script, $dref) = @_;
	
	my $command = $dref->{command}
		or die "could not find command for $script";
	print "running $script\n";
	system $command;
}

my ($configfile, $target) = getArgs();
my $data = YAMLfromFile($configfile);

foreach my $file (keys %{$data->{files}}) {
	if (withinTarget($data->{files}->{$file}, $target)) {
		processEntry($file, $data->{files}->{$file}, $data->{variables})
	}
}
foreach my $script (keys %{$data->{scripts}}) {
	if (withinTarget($data->{scripts}->{$script}, $target)) {
		runCommand($script, $data->{scripts}->{$script});	
	}
}

print "Complete!\n"
