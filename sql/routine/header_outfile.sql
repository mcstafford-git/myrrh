DROP PROCEDURE IF EXISTS header_outfile;

delimiter //

CREATE DEFINER = myrrh@localhost procedure header_outfile (
  in p_schema varchar(64)
, in p_table  varchar(64)
, in p_where  varchar(2048)
, in p_folder varchar(64)
)
/* inspired by lifeboysays http://goo.gl/ehCeJF */
LANGUAGE SQL
NOT DETERMINISTIC
CONTAINS SQL
SQL SECURITY DEFINER
COMMENT 'export table content with headers'
BEGIN 

declare l_file_name char(128); 

declare l_quote char(1)  default char(39);

if p_where is not null and p_where != '' then
  set p_where := concat( ' where ' ,p_where);
else
  set p_where := '';
end if;

set l_file_name := concat(
    p_folder
  , date_format(utc_timestamp(),'%Y%m%d-%H%i%s')
  , '_' ,@@hostname
  , '_' ,p_schema
  , '.' ,p_table
  , '.csv'
);

if l_file_name is not null then

  select concat(
    'select group_concat( c.column_name )'
    ,' into @header_names'
    ,' from information_schema.columns c'
    ,' where c.table_schema = ?'
    ,' and c.table_name = ?'
    ,' and c.column_name not in( ''id'' , ''ts'' )'
    ,' order by c.ordinal_position'
  )
  , p_schema
  , p_table
  into
    @columns, @p_schema, @p_table
  ;
 -- select @columns;

  if @columns is not null then

    prepare stmt from @columns;
    execute stmt using @p_schema, @p_table;
    drop prepare stmt;

    set @data := concat(
      'select ',@header_names
      ,' from ' ,p_schema ,'.' ,p_table ,p_where
      ,' into outfile ' , l_quote , l_file_name , l_quote 
      ,' character set latin1'
    );
    -- select @data;

    if @data is not null then

      set @header_names := concat(
        l_quote
      , replace( @header_names , ',' , concat( l_quote , ',' , l_quote ))
      , l_quote
      );
      set @headers_and_data := concat( 'select ' , @header_names , ' union ' , @data );
      -- select @headers_and_data;

      if @headers_and_data is not null then

        prepare stmt from @headers_and_data;
        execute stmt;
        drop prepare stmt;

        select concat( @@hostname ,':' ,l_file_name ) output_location;

      end if;

    end if; /* @data  */

  end if; /* @columns */

end if; /* l_file_name */

select
  null, null, null
, null, null, null
into
  @columns, @p_schema, @p_table
, @data, @header_names, @headers_and_data
;

end;

//

delimiter ;

