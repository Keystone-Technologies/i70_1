package I70::EMR;
use Mojo::Base 'Mojolicious::Controller';

use SQL::Abstract;

has sql => sub { SQL::Abstract->new };

sub _time { shift->render(text => scalar localtime) };

sub rest_list {
  my ($self, $table) = @_;
  $table ||= $self->table;
  my $sth = $self->db->run(fixup => sub {
      my $primary_key = $self->colM->[0]->{dataIndx};
      my $sth = $_->prepare($self->sql->select($table, [\qq{$primary_key AS recId}, map {$_->{dataIndx}} @{$self->colM}]));
      $sth->execute;
      $sth;
  });
  $self->render(json => {data => $sth->fetchall_arrayref({})});
}

sub rest_create {
  my ($self, $table) = @_;
  $table ||= $self->table;
  $self->db->run(fixup => sub {
      my ($stmt, @bind) = $self->sql->insert($table, {map {$_->{dataIndx} => $self->param($_->{dataIndx}) || undef} @{$self->colM}});
      $_->do($stmt, undef, @bind);
  });
  $self->rest_list;
}
 
sub rest_show {
  my $self = shift;
  my ($id) = $self->param('patientsid');
  $self->render(text => "Show $id: ".scalar localtime);
}
 
sub rest_remove {
  my ($self, $table, $key) = @_;
  $table ||= $self->table;
  $key ||= $self->key;
  $self->db->run(fixup => sub {
      my ($stmt, @bind) = $self->sql->delete($table, {$self->colM->[0]->{dataIndx} => $self->param($key) || undef});
      $_->do($stmt, undef, @bind);
  });
  $self->rest_list;
}
 
sub rest_update {
  my ($self, $table, $key) = @_;
  $table ||= $self->table;
  $key ||= $self->key;
  $self->db->run(fixup => sub {
      my ($stmt, @bind) = $self->sql->update($table, {map {$_->{dataIndx} => $self->param($_->{dataIndx}) || undef} @{$self->colM}}, {$self->colM->[0]->{dataIndx} => $self->param($key) || undef});
      $_->do($stmt, undef, @bind);
  });
  $self->rest_list;
}
 
sub index {
  my $self = shift;
  push @{$self->app->renderer->classes}, __PACKAGE__ unless grep { $_ eq __PACKAGE__ } @{$self->app->renderer->classes};
  push @{$self->app->renderer->classes}, ref $self unless grep { $_ eq ref $self } @{$self->app->renderer->classes};
  $self->render(lc(((split /::/, ref $self))[-1]).'/index');
}

1;

__DATA__
@@ layouts/pqgrid.html.ep
<!DOCTYPE html>
<html>
  <head>
    <title><%= title %></title>
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/themes/base/jquery-ui.css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>    
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.9.2/jquery-ui.min.js"></script>
   
    <style>
        .pq-grid-crud-popup *
        {
            font-family:Tahoma;
            font-size:11px;        
        }
        .pq-grid-crud-popup form.pq-grid-crud-form
        {
            margin-top:10px;
        }
        .pq-grid-crud-popup form.pq-grid-crud-form input
        {
            width:300px;
            overflow:visible;/*fix for IE*/
        }
        .pq-grid-crud-popup form.pq-grid-crud-form td.label
        {
            font-weight:bold;padding-right:5px;
        }
        div.pq-grid-toolbar-crud-remote
        {
            text-align:center;
        }
    </style>
    <!--ParamQuery Grid files-->
    <link rel="stylesheet" href="/pqgrid.dev.css" />
    <script type="text/javascript" src="/pqgrid.dev.js" ></script>   
    <script type="text/javascript" src="/pqGridCrud.js" ></script>   
    <script>
        $(function () {
            var colM = <%== j $self->colM =%>;
            var dataModel = {
                location: "remote",
                sorting: "local",
                paging: "local",
                dataType: "JSON",
                method: "GET",
                //sortIndx: "contact",
                url: "<%= $url %>",
                sortDir: "up",
                getData: function (dataJSON) {
                    var data = dataJSON.data;
                    return { data: dataJSON.data };
                }
            };
            var newObj = {
                flexHeight: true,
                flexWidth: true,
                customData: {a: "b"},
                dataModel: dataModel,
                bottomVisible: true,
                selectionModel: { mode: 'single' },
                editable: false,
                colModel: colM,
                scrollModel: { horizontal: false },
                //title: "Contact Details",
                columnBorders: true
            };
            if ( colM != null ) {
                var $grid = $("#grid_crud-remote").pqGridCrud(newObj);
            } else {
                $('#grid_crud-remote').html("colM not defined");
            }
        });
    </script>    
  </head>
  <body>
    <div id="grid_crud-remote"></div>
  </body>
</html>
