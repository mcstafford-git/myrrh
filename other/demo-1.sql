set @user := 'u0';
call create_role( 'r0' )\p;
call create_user( @user , password( 'u0see-insecure' ))\p;
call create_db( 'd0' )\p;
call grant_role( 'r0', @user )\p;
call grant_db( 'r0', 'd0' )\p;
call grant_priv( 'r0', 'select' )\p;

set @user := 'u1';
call create_role( 'r1' )\p;
call create_user( @user , password( 'u1support-insecure' ))\p;
call create_db( 'd1' )\p;
call grant_role( 'r1', @user )\p;
call grant_db( 'r1', 'd1' )\p;
call grant_priv( 'r1', 'select' )\p;

set @user := 'u2';
call create_role( 'r2' )\p;
call create_user( @user , password( 'u2load-insecure' ))\p;
call create_db( 'd2' )\p;
call grant_role( 'r2', @user )\p;
call grant_db( 'r2', 'd2' )\p;
call grant_priv( 'r2', 'select' )\p;

set @user := 'u3';
call create_role( 'r3' )\p;
call create_user( @user , password( 'u3edit-insecure' ))\p;
call create_db( 'd3' )\p;
call grant_role( 'r3', @user )\p;
call grant_db( 'r3', 'd3' )\p;
call grant_priv( 'r3', 'select' )\p;

set @user := 'u4';
call create_role( 'r4' )\p;
call create_user( @user , password( 'u4dev-insecure' ))\p;
call create_db( 'd4' )\p;
call grant_role( 'r4', @user )\p;
call grant_db( 'r4', 'd4' )\p;
call grant_priv( 'r4', 'select' )\p;

set @user := 'u5';
call create_role( 'r5' )\p;
call create_user( @user , password( 'u5replicate-insecure' ))\p;
call create_db( 'd5' )\p;
call grant_role( 'r5', @user )\p;
call grant_db( 'r5', 'd5' )\p;
call grant_priv( 'r5', 'select' )\p;

set @user := 'u6';
call create_role( 'r6' )\p;
call create_user( @user , password( 'u6admin-insecure' ))\p;
call create_db( 'd6' )\p;
call grant_role( 'r6', @user )\p;
call grant_db( 'r6', 'd6' )\p;
call grant_priv( 'r6', 'select' )\p;

call create_db( '*' );

