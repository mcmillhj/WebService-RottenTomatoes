package WebService::RottenTomatoes::JSON; 

use strict; 
use warnings; 

use Moo::Role;
use JSON; 

=attr json

A JSON serializer/deserializer instance. Default is L<JSON>.

=cut

has 'json' => (
   is      => 'ro',
   lazy    => 1,
   default => sub { JSON->new } 
);

=method encode

Serialize a Perl data structure to a JSON string

=cut

sub encode {
   my ($self, $data) = @_;

   return $self->json->encode($data);
}

=method decode

Deserialize a JSON string to a Perl data structure

=cut

sub decode {
   my ($self, $data) = @_;

   return $self->json->decode($data);
}

1;
