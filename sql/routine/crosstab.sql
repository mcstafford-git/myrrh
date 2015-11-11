-- /var/tmp/some.sql

set group_concat_max_len := 999999;

set @colname   := 'priv_name'
  , @tablename1 := 'privs';
set @content   := concat( ''',quote( ', @colname , ' ),''' );

select
  replace( replace( concat(
    'concat( ''' , 'sum( '
    ,'case COLNAME_PLACEHOLDER when CONTENT_PLACEHOLDER then 1 else 0 end'
    ,' ) CONTENT_PLACEHOLDER'') transposition'
  ) , 'COLNAME_PLACEHOLDER', @colname ) , 'CONTENT_PLACEHOLDER', @content ) col_syntax
, concat( ' from ' , @tablename1 ) table_syntax
into @col_syntax, @table_syntax1
;

select concat( 'select ', @col_syntax , @table_syntax1 ) transposition1
into @transposition1;

select concat( 'select group_concat( transposition ) transpositions into @transposition3 from ( ' , @transposition1 , ' ) d' )
into @transposition2;

prepare stmt from @transposition2;
execute stmt;
drop prepare stmt;

select concat( 'select role_name, ' , @transposition3 , ' from role_privs group by 1' )
into @transposition4;

prepare stmt from @transposition4;
execute stmt;
drop prepare stmt;

