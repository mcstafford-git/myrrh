-- grant_priv assigns role-specific privileges
call grant_priv( 'r0', 'create temporary tables' )\p;

-- grant_role recursively includes all of a role's privs and dbs to the parent role.
call grant_role( 'r1', 'r0' )\p;
call grant_priv( 'r1', 'lock tables' )\p;
call grant_priv( 'r1', 'process' )\p;
call grant_priv( 'r1', 'reload' )\p;
call grant_priv( 'r1', 'shutdown' )\p;
call grant_priv( 'r1', 'super' )\p;

call grant_priv( 'r2', 'file' )\p;
call grant_priv( 'r2', 'insert' )\p;
call grant_priv( 'r2', 'select' )\p;

call grant_role( 'r3', 'r0' )\p;
call grant_priv( 'r3', 'delete' )\p;
call grant_priv( 'r3', 'insert' )\p;
call grant_priv( 'r3', 'update' )\p;

call grant_role( 'r4', 'r3' )\p;
call grant_priv( 'r4', 'alter routine' )\p;
call grant_priv( 'r4', 'alter' )\p;
call grant_priv( 'r4', 'create routine' )\p;
call grant_priv( 'r4', 'create view' )\p;
call grant_priv( 'r4', 'drop' )\p;
call grant_priv( 'r4', 'event' )\p;
call grant_priv( 'r4', 'index' )\p;
call grant_priv( 'r4', 'references' )\p;
call grant_priv( 'r4', 'show databases' )\p;
call grant_priv( 'r4', 'show view' )\p;
call grant_priv( 'r4', 'trigger' )\p;

call grant_priv( 'r5', 'replication client' )\p;
call grant_priv( 'r5', 'replication slave' )\p;

-- r6 is unique in that it has no direct privs granted, only other roles
call grant_role( 'r6', 'r1' )\p;
call grant_role( 'r6', 'r2' )\p;
call grant_role( 'r6', 'r4' )\p;
call grant_role( 'r6', 'r5' )\p;

