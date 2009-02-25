package Idiom;

use strict;
use warnings;

use base 'Mojo';
use Idiom::Sofa;

my $cdb = Idiom::Sofa->new( host => 'localhost', port => 5984 );
my $peopledb = $cdb->db("people");

sub handler {
    my ($self, $tx) = @_;

    # $tx is a Mojo::Transaction instance
    $tx->res->code(200);
    $tx->res->headers->content_type('text/html');
    # $tx->res->body('Hello Mojo!');

    my $bodyc = "<html><body><h1>hello.</h1></body></html>\n\n";
    $tx->res->body($bodyc);

    return $tx;
}

1;
