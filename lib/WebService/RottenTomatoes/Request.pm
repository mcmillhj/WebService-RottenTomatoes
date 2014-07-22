package WebService::RottenTomatoes::Request; 

use strict; 
use warnings; 

use Moo::Role; 
use Carp qw(confess);
use HTTP::Tiny; 
use URI::Escape;

with 'WebService::RottenTomatoes::JSON';

=attr user_agent 

A user agent object. Default is L<HTTP::Tiny>

=cut

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

=attr user_agent 

API endpoint against which HTTP requests are sent. 
Default is 'http://api.rottentomatoes.com/api/public/v1.0/movies.json?'

=cut

has 'base_url' => (
   is      => 'ro',
   lazy    => 1,
   default => sub { 'http://api.rottentomatoes.com/api/public/v1.0/movies.json?' },
);

=method request 

Retrieves JSON encoded data from Rotten Tomatoes about the movie
specified in $query. 

Currently returns ONLY a single result.

=cut

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

=method _build_url 

Forms a vaild Rotten Tomatoes URL given a search query

=cut

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
