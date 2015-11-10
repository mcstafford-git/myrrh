update
  roles
set
  role_name = case role_name
    when 'r0' then 'see'
    when 'r1' then 'support'
    when 'r2' then 'load'
    when 'r3' then 'edit'
    when 'r4' then 'dev'
    when 'r5' then 'replicate'
    when 'r6' then 'admin'
  else role_name end\p;

update
  users
set
  user_name = case user_name
    when 'u0' then 'seer'
    when 'u1' then 'supporter'
    when 'u2' then 'loader'
    when 'u3' then 'editor'
    when 'u4' then 'developer'
    when 'u5' then 'replicator'
    when 'u6' then 'administrator'
  else user_name end\p;

