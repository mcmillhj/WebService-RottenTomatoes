package WebService::RottenTomatoes; 

use Moo; 
use namespace::clean;
use Carp qw(confess);
use Memoize qw(memoize);
use WebService::RottenTomatoes::Movie;

with 'WebService::RottenTomatoes::Request';

=method search 

Searchs for the movie(s) specified in the query string $query

=cut 

memoize 'search';
sub search {
   my ($self, $query) = @_;
   
   return map {  
      WebService::RottenTomatoes::Movie->new($_) 
   } @{ $self->request($query)->{movies} };
}


1;
