﻿select private.create_model(

-- Model name, schema

'project_contact', '', 'xm.contact_info, private.docinfo',

E'{
  "docinfo.id as guid",
  "docinfo.source_id as source",
  "contact_info as contact",
  "docinfo.purpose as purpose"
}',

-- Rules

E'{"

-- insert rules

create or replace rule \\"_CREATE\\" as on insert to xm.project_contact
  do instead

insert into private.docinfo (
  id,
  source_id,
  source_type,
  target_id,
  target_type,
  purpose )
values (
  new.guid,
  new.source,
  \'J\',
  (new.contact).guid,
  \'T\',
  new.purpose );
  
","

-- update rule

create or replace rule \\"_UPDATE\\" as on update to xm.project_contact
  do instead nothing;

","

-- delete rules
  
create or replace rule \\"_DELETE\\" as on delete to xm.project_contact 
  do instead

delete from private.docinfo
where ( id = old.guid );


"}',

-- Conditions, Comment, System, Nested

E'{"contact_info.guid=target_id","docinfo.source_type=\'J\'","docinfo.target_type=\'T\'"}', 'Project Contact Model', true, true, '', '', 'public.docass_docass_id_seq');