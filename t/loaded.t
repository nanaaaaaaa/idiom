#!perl

use strict;
use warnings;

use Test::More tests => 2;

# Does CouchDb work?
use_ok('Idiom::Sofa');

# Does the main module work?
use_ok('Idiom');
