package API::Hello;

use nginx;

use strict;
use warnings;

sub new {
	my $class = shift;
	my $self = {
	};

	bless $self, $class;
	return $self;
}

sub handler {
    my $self=shift;
    my $r = shift;

    $r->print("Hello World!");

}

1;