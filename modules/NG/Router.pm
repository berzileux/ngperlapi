package NG::Router;

use nginx;

use strict;
use warnings;

use aliased "Log::Log4perl::Appender::Screen";
use aliased "API::Hello";
use Try::Tiny;

my $logger = Screen->new(
  autoflush => 1,
  stdout    => 1,
  utf8      => 1,
);

my %routers = (
    '/v1/api/hello' => Hello->new(),
    '/v1/api/world' => Hello->new(),
);

sub handler {
	my $r = shift;

  try {

    $r->send_http_header("application/json");
    return OK if $r->header_only;
    my $route = $r->uri;
    $logger->log(route => $r->uri);
    print "buggy";
    #check if there is a route in place otherwise just output place welcome
    return $routers{$route}->handler($r) if (exists $routers{$route});

	 $r->print("No routes has been defined. $route");

 } catch {
         warn "caught error: $_";
 };
}

1;