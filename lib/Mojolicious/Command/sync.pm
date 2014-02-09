package Mojolicious::Command::sync;
use Mojo::Base 'Mojolicious::Command';

use Data::Compare;
use Hash::Merge qw( merge );
use List::MoreUtils qw( uniq );
use Mojo::JSON 'j';
use Mojo::UserAgent;

use Getopt::Long qw(GetOptionsFromArray :config no_auto_abbrev no_ignore_case);

has description => "Run code against application.\n";
has usage => sub { shift->extract_usage };

Hash::Merge::set_behavior('RIGHT_PRECEDENT');

#my $couchdb = "http://burfarationsessalindsomm:ECxBSE6eKmui8UwVqSJ42AMR\@s1037989.cloudant.com/i70";
my $couchdb = "http://localhost:5984/i70";

our %dbh;

has ua => sub { Mojo::UserAgent->new };

sub run {
  my ($self, @args) = @_;

  my $loader = Mojo::Loader->new;
  for my $module (@{$loader->search("I70::EMR")}) {
    next if $module =~ /DB$/;
    my $e = $loader->load("${module}::DB");
    warn qq{Loading "$module" failed: $e} and next if ref $e;
    $dbh{$module} = "${module}::DB"->sync;
  }

  $self->sync($_, $dbh{$_}->{db}, @{$dbh{$_}->{sync}}) foreach keys %dbh;
}

sub sync {
  my ($self, $name, $dbh, @sql) = @_;
  say "DB Name: $name";
  foreach my $sql ( @sql ) {
    my $sth = $dbh->run(fixup => sub {
      my $sth = $_->prepare($sql);
      $sth->execute;
      $sth;
    });
    while ( my $row = $sth->fetchrow_hashref ) {
      my $deid = delete $row->{deid};
      delete $row->{$_} foreach grep { exists $row->{$_} } qw/id rev/;
      $row = {map { $_ => {$name => $row->{$_}} } keys %$row};
      my $tx = $self->ua->get("$couchdb/$deid");
      my $res = $tx->res->json;
      if ( $res->{error} ) {
        if ( $res->{error} eq 'not_found' ) {
          say "Creating $name/$deid...";
          my $tx = $self->ua->put("$couchdb/$deid" => json => $row);
          say j($tx->res->json);
        }
      } else {
        #say "$_\t$row->{$_}\t$res->{$_}" foreach keys $row;
        my $oldrow = {map { $_ => {$name => $res->{$_}->{$name}} } keys %$row};
        if ( Compare($oldrow, $row) ) {
          say "$deid already up to date";
        } else {
          say "Updating $name/$deid/$res->{_rev}...";
          #say Dumper($oldrow, $row);
          #$row->{_rev} = $res->{_rev};
          my $merge = merge($res, $row);
          #$merge->{$_} = [uniq @{$merge->{$_}}] foreach grep { ref $merge->{$_} eq 'ARRAY' } keys %$merge;
          my $tx = $self->ua->put("$couchdb/$deid" => json => $merge);
          say j($tx->res->json);
        }
      }
    }
  }
}

1;

=encoding utf8

=head1 NAME

Mojolicious::Command::eval - Eval command

=head1 SYNOPSIS

  Usage: APPLICATION eval [OPTIONS] CODE

    ./myapp.pl eval 'say app->ua->get("/")->res->body'
    ./myapp.pl eval -v 'app->home'
    ./myapp.pl eval -V 'app->renderer->paths'

  Options:
    -v, --verbose   Print return value to STDOUT.
    -V              Print returned data structure to STDOUT.

=head1 DESCRIPTION

L<Mojolicious::Command::eval> runs code against applications.

This is a core command, that means it is always enabled and its code a good
example for learning to build new commands, you're welcome to fork it.

See L<Mojolicious::Commands/"COMMANDS"> for a list of commands that are
available by default.

=head1 ATTRIBUTES

L<Mojolicious::Command::eval> inherits all attributes from
L<Mojolicious::Command> and implements the following new ones.

=head2 description

  my $description = $eval->description;
  $eval           = $eval->description('Foo!');

Short description of this command, used for the command list.

=head2 usage

  my $usage = $eval->usage;
  $eval     = $eval->usage('Foo!');

Usage information for this command, used for the help screen.

=head1 METHODS

L<Mojolicious::Command::eval> inherits all methods from
L<Mojolicious::Command> and implements the following new ones.

=head2 run

  $eval->run(@ARGV);

Run this command.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=cut