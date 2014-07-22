#!/usr/bin/perl

use strict; 
use warnings; 

use Data::Dumper; 
use WebService::RottenTomatoes; 

my $service = WebService::RottenTomatoes->new;
print Dumper $service->get_ratings('the avengers');
