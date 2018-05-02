#!/usr/bin/perl

use warnings;

use strict;

use List::MoreUtils qw(uniq);

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

#implement tiebreaker here
my @uniq_input = uniq @input;

my $number_uniq_items=@uniq_input;

my %weight;

# add weight by virtue of position
# each unique item encountered earlier weighs 1 more than the one that follows
# it. the last item should just have a weight of 1.
foreach my $item (@uniq_input) {
  $weight{$item}=$number_uniq_items;
  $number_uniq_items--;
}

#show weight by virtue of position
#foreach my $item (keys %weight) {
#  print "$item $weight{$item}\n";
#}
#exit;

#add extra weight by virtue of occurences, this counts for more so we have an
#amplification_factor. this factor is based on the number of significant digits
#of the number of input items. eg. if 11 input items, sigfig=2, then
#af=10^2=100
#

my $number_items = @input;
my $amplification_factor = 10 ** (length $number_items);

foreach my $key (uniq keys %seen) {
  $weight{$key}=($seen{$key}*$amplification_factor)+$weight{$key};
}

#show input fully weighted
#foreach my $item (keys %weight) {
#  print "$item $weight{$item}\n";
#}
#exit;

my @sorted = reverse sort { $weight{$a} <=> $weight{$b} } keys (%weight);

my $result="";

foreach my $i (@sorted) {
  for(my $j=0; $j < $seen{$i}; $j++){
    $result = $result."$i, ";
  }
}

$result=~s/, $//;
print $result;
