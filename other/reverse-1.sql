-- @suffix is used for multiplicity of similar users
select @suffix := coalesce( @suffix, '' ) suffix;

set @user := concat( 'u0' , @suffix );
call create_user( @user , password( 'u0see-insecure' ))\p;
call grant_role( 'see', @user )\p;

set @user := concat( 'u1' , @suffix );
call create_user( @user , password( 'u1support-insecure' ))\p;
call grant_role( 'support', @user )\p;

set @user := concat( 'u2' , @suffix );
call create_user( @user , password( 'u2load-insecure' ))\p;
call grant_role( 'load', @user )\p;

set @user := concat( 'u3' , @suffix );
call create_user( @user , password( 'u3edit-insecure' ))\p;
call grant_role( 'edit', @user )\p;

set @user := concat( 'u4' , @suffix );
call create_user( @user , password( 'u4dev-insecure' ))\p;
call grant_role( 'dev', @user )\p;

set @user := concat( 'u5' , @suffix );
call create_user( @user , password( 'u5replicate-insecure' ))\p;
call grant_role( 'replicate', @user )\p;

set @user := concat( 'u6' , @suffix );
call create_user( @user , password( 'u6admin-insecure' ))\p;
call grant_role( 'admin', @user )\p;

