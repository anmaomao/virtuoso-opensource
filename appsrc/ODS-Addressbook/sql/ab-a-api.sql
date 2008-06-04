--
--  $Id$
--
--  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
--  project.
--
--  Copyright (C) 1998-2008 OpenLink Software
--
--  This project is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; only version 2 of the License, dated June 1991.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
--  General Public License for more details.
--
--  You should have received a copy of the GNU General Public License along
--  with this program; if not, write to the Free Software Foundation, Inc.,
--  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
--

use ODS;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.get" (
  in contact_id integer) __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare uname varchar;
  declare inst_id integer;
  declare q, iri varchar;

  inst_id := (select P_DOMAIN_ID from AB.WA.PERSONS where P_ID = contact_id);
  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();
  iri := SIOC..addressbook_contact_iri (inst_id, contact_id);
  q := sprintf ('describe <%s> from <%s>', iri, SIOC..get_graph ());
  exec_sparql (q);
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.new" (
  in inst_id integer,
  in name varchar,
  in category_id integer := null,
  in kind integer := 0,
  in title varchar := null,
  in fName varchar := null,
  in mName varchar := null,
  in lName varchar := null,
  in fullName varchar := null,
  in gender varchar := null,
  in birthday datetime := null,
  in iri varchar := null,
  in foaf varchar := null,
  in mail varchar := null,
  in web varchar := null,
  in icq varchar := null,
  in skype varchar := null,
  in aim varchar := null,
  in yahoo varchar := null,
  in msn varchar := null,
  in hCountry varchar := null,
  in hState varchar := null,
  in hCity varchar := null,
  in hCode varchar := null,
  in hAddress1 varchar := null,
  in hAddress2 varchar := null,
  in hTzone varchar := null,
  in hLat real := null,
  in hLng real := null,
  in hPhone varchar := null,
  in hMobile varchar := null,
  in hFax varchar := null,
  in hMail varchar := null,
  in hWeb varchar := null,
  in bCountry varchar := null,
  in bState varchar := null,
  in bCity varchar := null,
  in bCode varchar := null,
  in bAddress1 varchar := null,
  in bAddress2 varchar := null,
  in bTzone varchar := null,
  in bLat real := null,
  in bLng real := null,
  in bPhone varchar := null,
  in bMobile varchar := null,
  in bFax varchar := null,
  in bIndustry varchar := null,
  in bOrganization varchar := null,
  in bDepartment varchar := null,
  in bJob varchar := null,
  in bMail varchar := null,
  in bWeb varchar := null,
  in tags varchar := null) __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare rc integer;
  declare uname varchar;

  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();

  rc := AB.WA.contact_update (
          -1,
          inst_id,
          category_id,
          kind,
          name,
          title,
          fName,
          mName,
          lName,
          fullName,
          gender,
          birthday,
          iri,
          foaf,
          mail,
          web,
          icq,
          skype,
          aim,
          yahoo,
          msn,
          hCountry,
          hState,
          hCity,
          hCode,
          hAddress1,
          hAddress2,
          hTzone,
          hLat,
          hLng,
          hPhone,
          hMobile,
          hFax,
          hMail,
          hWeb,
          bCountry,
          bState,
          bCity,
          bCode,
          bAddress1,
          bAddress2,
          bTzone,
          bLat,
          bLng,
          bPhone,
          bMobile,
          bFax,
          bIndustry,
          bOrganization,
          bDepartment,
          bJob,
          bMail,
          bWeb,
          tags);

  return ods_serialize_int_res (rc);
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.edit" (
  in contact_id integer,
  in name varchar := null,
  in category_id integer := null,
  in kind integer := null,
  in title varchar := null,
  in fName varchar := null,
  in mName varchar := null,
  in lName varchar := null,
  in fullName varchar := null,
  in gender varchar := null,
  in birthday datetime := null,
  in iri varchar := null,
  in foaf varchar := null,
  in mail varchar := null,
  in web varchar := null,
  in icq varchar := null,
  in skype varchar := null,
  in aim varchar := null,
  in yahoo varchar := null,
  in msn varchar := null,
  in hCountry varchar := null,
  in hState varchar := null,
  in hCity varchar := null,
  in hCode varchar := null,
  in hAddress1 varchar := null,
  in hAddress2 varchar := null,
  in hTzone varchar := null,
  in hLat real := null,
  in hLng real := null,
  in hPhone varchar := null,
  in hMobile varchar := null,
  in hFax varchar := null,
  in hMail varchar := null,
  in hWeb varchar := null,
  in bCountry varchar := null,
  in bState varchar := null,
  in bCity varchar := null,
  in bCode varchar := null,
  in bAddress1 varchar := null,
  in bAddress2 varchar := null,
  in bTzone varchar := null,
  in bLat real := null,
  in bLng real := null,
  in bPhone varchar := null,
  in bMobile varchar := null,
  in bFax varchar := null,
  in bIndustry varchar := null,
  in bOrganization varchar := null,
  in bDepartment varchar := null,
  in bJob varchar := null,
  in bMail varchar := null,
  in bWeb varchar := null,
  in tags varchar := null) __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare rc integer;
  declare uname varchar;
  declare inst_id integer;

  inst_id := (select P_DOMAIN_ID from AB.WA.PERSONS where P_ID = contact_id);
  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();

  rc := AB.WA.contact_update (
          contact_id,
          inst_id,
          category_id,
          kind,
          name,
          title,
          fName,
          mName,
          lName,
          fullName,
          gender,
          birthday,
          iri,
          foaf,
          mail,
          web,
          icq,
          skype,
          aim,
          yahoo,
          msn,
          hCountry,
          hState,
          hCity,
          hCode,
          hAddress1,
          hAddress2,
          hTzone,
          hLat,
          hLng,
          hPhone,
          hMobile,
          hFax,
          hMail,
          hWeb,
          bCountry,
          bState,
          bCity,
          bCode,
          bAddress1,
          bAddress2,
          bTzone,
          bLat,
          bLng,
          bPhone,
          bMobile,
          bFax,
          bIndustry,
          bOrganization,
          bDepartment,
          bJob,
          bMail,
          bWeb,
          tags);

  return ods_serialize_int_res (rc);
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.delete" (
  in contact_id integer) __soap_http 'text/xml'
{
  declare rc integer;
  declare uname varchar;
  declare inst_id integer;

  inst_id := (select P_DOMAIN_ID from AB.WA.PERSONS where P_ID = contact_id);
  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();

  delete from AB.WA.PERSONS where P_ID = contact_id;
  rc := row_count ();

  return ods_serialize_int_res (rc);
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.import" (
  in inst_id integer,
  in source varchar,
  in sourceType varchar := 'url',
  in contentType varchar := 'vcard',
  in tags varchar := '') __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare uname, passwd varchar;
  declare content varchar;
  declare tmp any;

  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();

  if (lcase(sourceType) = 'string')
  {
    content := source;
  }
  else if (lcase(sourceType) = 'webdav')
  {
    passwd := __user_password (uname);
    content := AB.WA.dav_content (AB.WA.host_url () || http_physical_path_resolve (replace (source, ' ', '%20')), uname, passwd);
  }
  else if (lcase(sourceType) = 'url')
  {
    content := source;
  }
  else
  {
	  signal ('AB106', 'The source type must be string, WebDAV or URL.');
  }

  tags := trim (tags);
  AB.WA.test (tags, vector ('name', 'Tags', 'class', 'tags'));
  tmp := AB.WA.tags2vector (tags);
  tmp := AB.WA.vector_unique (tmp);
  tags := AB.WA.vector2tags (tmp);

  -- import content
  if (DB.DBA.is_empty_or_null (content))
    signal ('AB107', 'Bad import source!');

  if (lcase(contentType) = 'vcard')
  {
    AB.WA.import_vcard (inst_id, content, vector ('tags', tags));
  }
  else if (lcase(contentType) = 'foaf')
  {
    AB.WA.import_foaf (inst_id, content, tags, vector (), case when (lcase (sourceType) = 'url') then 1 else 0 end);
  }
  else
  {
  	signal ('AB105', 'The content type must be vCard or FOAF.');
  }
  return ods_serialize_int_res (1);
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.export" (
  in inst_id integer,
  in contentType varchar := 'vcard') __soap_http 'text/plain'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare uname varchar;

  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();

  if (lcase (contentType) = 'vcard')
  {
    http (AB.WA.export_vcard (inst_id));
  }
  else if (lcase (contentType) = 'foaf')
  {
    http (AB.WA.export_foaf (inst_id));
  }
  else if (lcase(contentType) = 'csv')
  {
    -- CSV
    http (AB.WA.export_csv_head ());
    http (AB.WA.export_csv (inst_id));
  }
  else
  {
  	signal ('AB104', 'The content type must be vCard, FOAF or CSV.');
  }
  return '';
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.options.set" (
  in inst_id int, in options any) __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare rc integer;
  declare uname varchar;

  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();

  -- TODO: not implemented
  return ods_serialize_int_res (rc);
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.options.get" (
  in inst_id int) __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare rc integer;
  declare uname varchar;

  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();

  -- TODO: not implemented
  return ods_serialize_int_res (rc);
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.comment.get" (
  in comment_id integer) __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare uname varchar;
  declare inst_id, contact_id integer;
  declare q, iri varchar;

  whenever not found goto _exit;

  select PC_DOMAIN_ID, PC_PERSON_ID into inst_id, contact_id from AB.WA.PERSON_COMMENTS where PC_ID = comment_id;

  if (not ods_check_auth (uname, inst_id, 'reader'))
    return ods_auth_failed ();

  iri := SIOC..addressbook_comment_iri (inst_id, cast (contact_id as integer), comment_id);
  q := sprintf ('describe <%s> from <%s>', iri, SIOC..get_graph ());
  exec_sparql (q);

_exit:
  return '';
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.comment.new" (
  in contact_id integer,
  in parent_id integer := null,
  in title varchar,
  in text varchar,
  in name varchar,
  in email varchar,
  in url varchar) __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare rc integer;
  declare uname varchar;
  declare inst_id integer;

  rc := -1;
  inst_id := (select P_DOMAIN_ID from AB.WA.PERSONS where P_ID = contact_id);

  if (not ods_check_auth (uname, inst_id, 'reader'))
    return ods_auth_failed ();

  if (not (AB.WA.discussion_check () and AB.WA.conversation_enable (inst_id)))
    return signal('API01', 'Discussions must be enabled for this instance');

  if (isnull (parent_id))
  {
    -- get root comment;
    parent_id := (select PC_ID from AB.WA.PERSON_COMMENTS where PC_DOMAIN_ID = inst_id and PC_PERSON_ID = contact_id and PC_PARENT_ID is null);
    if (isnull (parent_id))
    {
      AB.WA.nntp_root (inst_id, contact_id);
      parent_id := (select PC_ID from AB.WA.PERSON_COMMENTS where PC_DOMAIN_ID = inst_id and PC_PERSON_ID = contact_id and PC_PARENT_ID is null);
    }
  }

  AB.WA.nntp_update_item (inst_id, contact_id);
  insert into AB.WA.PERSON_COMMENTS (PC_PARENT_ID, PC_DOMAIN_ID, PC_PERSON_ID, PC_TITLE, PC_COMMENT, PC_U_NAME, PC_U_MAIL, PC_U_URL, PC_UPDATED)
    values (parent_id, inst_id, contact_id, title, text, name, email, url, now ());
  rc := row_count ();

  return ods_serialize_int_res (rc);
}
;

-------------------------------------------------------------------------------
--
create procedure ODS.ODS_API."addressbook.comment.delete" (
  in comment_id integer) __soap_http 'text/xml'
{
  declare exit handler for sqlstate '*'
  {
    rollback work;
    return ods_serialize_sql_error (__SQL_STATE, __SQL_MESSAGE);
  };

  declare rc integer;
  declare uname varchar;
  declare inst_id integer;

  rc := -1;
  inst_id := (select PC_DOMAIN_ID from AB.WA.PERSON_COMMENTS where PC_ID = comment_id);
  if (not ods_check_auth (uname, inst_id, 'author'))
    return ods_auth_failed ();

  delete from AB.WA.PERSON_COMMENTS where PC_ID = comment_id;
  rc := row_count ();

  return ods_serialize_int_res (rc);
}
;

grant execute on ODS.ODS_API."addressbook.get" to ODS_API;
grant execute on ODS.ODS_API."addressbook.new" to ODS_API;
grant execute on ODS.ODS_API."addressbook.edit" to ODS_API;
grant execute on ODS.ODS_API."addressbook.delete" to ODS_API;
grant execute on ODS.ODS_API."addressbook.import" to ODS_API;
grant execute on ODS.ODS_API."addressbook.export" to ODS_API;
grant execute on ODS.ODS_API."addressbook.options.get" to ODS_API;
grant execute on ODS.ODS_API."addressbook.options.set" to ODS_API;
grant execute on ODS.ODS_API."addressbook.comment.get" to ODS_API;
grant execute on ODS.ODS_API."addressbook.comment.get" to ODS_API;
grant execute on ODS.ODS_API."addressbook.comment.new" to ODS_API;
grant execute on ODS.ODS_API."addressbook.comment.delete" to ODS_API;

use DB;
