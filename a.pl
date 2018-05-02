#!/usr/bin/perl

use warnings;

use strict;

my @input = split(/,/,$ARGV[0]);

my %seen;

foreach my $item (@input) {
  chomp($item);
  $item=~s/ //g;
  if(exists($seen{$item})){
    $seen{$item}=$seen{$item}+1;
  }else{
    $seen{$item}=1;
  }
}

#foreach my $key (keys %seen){
#  print "$key: $seen{$key}\n";
#}

my @keys = reverse sort { $seen{$a} <=> $seen{$b} } keys (%seen);

my $result="";

foreach my $i (@keys) {
  for(my $j=0; $j < $seen{$i}; $j++){
    $result = $result."$i, ";
  }
}

$result=~s/, $//;
print $result;
