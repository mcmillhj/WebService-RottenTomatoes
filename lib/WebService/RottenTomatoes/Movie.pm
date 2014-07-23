package WebService::RottenTomatoes::Movie;

use Moo; 
use namespace::clean; 

has [qw(
   abridged_cast abridged_directors 
   alternate_ids critics_consensus
   id            links 
   mpaa_rating   posters
   release_dates runtime
   studio        synopsis 
   title 
)] => (is => 'ro');

1;
