---
id: 93
layout: post
title: >
    Counting my demons.
---

<code>
use People qw/Nick/;

my $good_ones = 0;

my @demons = Nick::count('demons');

while ( my $every_day = scalar @demons ) {
	place( @Nick::shoulders, $demons->[0] );
	@demons = ();
}

if ( $you->{'feel'} eq 'neglected' && $you->{'think'} eq 'all is lost' ) {
	@demons = Nick::count('demons');
	Nick->hopes( 'all' ne 'lost' );
}
</code>
