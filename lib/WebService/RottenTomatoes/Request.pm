package WebService::RottenTomatoes::Request; 

use strict; 
use warnings; 

use Moo::Role; 
use Carp qw(confess);
use Data::Dumper; 
use HTTP::Tiny; 
use URI::Escape;

with 'WebService::RottenTomatoes::JSON';

has 'user_agent' => (
   is      => 'ro',
   lazy    => 1,
   default => sub {
      HTTP::Tiny->new(
         agent           => 'WebService-RottenTomatoes ',
         default_headers => { 'Content-Type' => 'application/json' }
      )
   },
);

has 'base_url' => (
   is      => 'ro',
   lazy    => 1,
   default => sub { 'http://api.rottentomatoes.com/api/public/v1.0/movies.json?' },
);

sub request {
   my ($self, $query) = @_;

   my $url = $self->_build_url($query);
   my $response = $self->user_agent->get($url);

   if ( $response->{success} ) {
      return $self->decode( $response->{content} );
   }

   confess "Request to $url failed " 
      . "(" . $response->{status} . ")"
      . " - " . $response->{content}
}

sub _build_url {
   my ($self, $query) = @_;

   my $api_key = $ENV{ROTTENTOMATOES_API_KEY}; 
   if ($api_key) {
      return $self->base_url 
         . "apikey=$api_key" 
         . "&q=" . uri_escape($query) 
         . '&page_limit=1';
   }

   confess 'Unable to find Rotten Tomatoes API key in environment. '
      . 'Please store your API key in ROTTENTOMATOES_API_KEY';
}

1;
