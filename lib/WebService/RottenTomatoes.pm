package WebService::RottenTomatoes; 

use Moo; 
use namespace::clean;
use Carp qw(confess);
use Memoize qw(memoize);

with 'WebService::RottenTomatoes::Request';

memoize 'search';
sub search {
   my ($self, $query) = @_;

   return $self->request($query);
}

1;
