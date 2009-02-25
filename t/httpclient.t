#!perl
use strict;
use warnings;

use Test::More tests => 7;

# Start with the application.
use_ok('Idiom');
use Idiom;

# I almost think these are extraneous but for now...
use_ok('Mojo::Client');
use_ok('Mojo::Transaction');
use Mojo::Client;
use Mojo::Transaction;

# Next we need to be able to run a daemon...
use_ok('Mojo::Server::Daemon');
use_ok('threads');
use Mojo::Server::Daemon;
use threads ('yield', 'stack_size' => 64*4096, 'exit' => 'threads_only', 'stringify');

sub start_thread {
    my $s = shift;
    $s->run();
}

my $server = Mojo::Server::Daemon->new();
$server->port(8080);

# And start setting up a client to make a request.
my $tx = Mojo::Transaction->new();
$tx->req->method('GET');
$tx->req->url->parse('http://localhost:8080');

my $client = Mojo::Client->new();

# Our client is ready! We can move on to processing and testing.
my $thr = threads->create('start_thread', $server);
$thr->detach();

$client->process($tx);

# Do we have a response?
ok($tx->res);

# And is it a good response like it should be?
ok($tx->res->code eq 200);
