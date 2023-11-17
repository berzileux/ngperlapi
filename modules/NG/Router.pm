package NG::Router;

use nginx;

use strict;
use warnings;

use Log::Log4perl qw(get_logger);
use Try::Tiny;
use aliased "API::Hello";

Log::Log4perl::init('/etc/nginx/log4perl.conf');
my $logger = get_logger();

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
    my $existing = exists $routers{$route};
    my $found = ($existing) ? "route exists":"undefined";

    $logger->info( qq[route => $route, exists => $found ] );

    #check if there is a route in place otherwise just output place welcome
    return $routers{$route}->handler($r) if ($existing);

	 $r->print("No routes has been defined. $route");

 } catch {
         warn "caught error: $_";
 };
}

1;