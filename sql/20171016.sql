alter table qingdan add status integer default 0 not null;
comment on column qingdan.status is '0:使用中,1已停用';

create table kp_check_item
(
  id INTEGER primary key not null,
  qd_id INTEGER not null,
  qd VARCHAR(100) default '' not null,
  kpnr VARCHAR(1000) default '' not null,
  kpfs INTEGER default 0 not null,
  pfbm VARCHAR(1000) not null,
  jd integer not null,
  status integer default 0 not null,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

create index kp_check_item_qd_id on kp_check_item(qd_id asc);

create sequence kp_check_item_id
start with 1
increment by 1
nomaxvalue
nocycle;

create or replace trigger kp_check_item_id_trigger
before insert on kp_check_item
for each row
begin
select kp_check_item_id.nextval into :new.id from dual;
end;

create table kp_check_item_detail
(
  id integer primary key not null,
  item_id integer not null,
  pfbz varchar(1000) default '' not null,
  fs number(4,2) default 0 not null,
  jd integer not null,
  status integer default 0 not null,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

create index kp_check_item_detail_item_id on kp_check_item_detail(item_id asc);

create sequence kp_check_item_detail_id
start with 1
increment by 1
nomaxvalue
nocycle;

create or replace trigger kp_check_item_d_id_trigger
before insert on kp_check_item_detail
for each row
begin
select kp_check_item_detail_id.nextval into :new.id from dual;
end;

create table kp_check_item_pub (
  id INTEGER primary key not null,
  item_id integer not null,
  qd_id INTEGER not null,
  qd VARCHAR(100) default '' not null,
  kpnr VARCHAR(1000) default '' not null,
  kpfs INTEGER default 0 not null,
  pfbm VARCHAR(1000) not null,
  jd integer not null,
  status integer default 0 not null,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

create index item_pub_item_id on kp_check_item_pub(item_id asc);
create index item_pub_qd_id on kp_check_item_pub(qd_id asc);

create sequence kp_check_item_pub_id
start with 1
increment by 1
nomaxvalue
nocycle;

create or replace trigger kp_check_item_pub_id_trigger
before insert on kp_check_item_pub
for each row
begin
select kp_check_item_pub_id.nextval into :new.id from dual;
end;

create table kp_check_item_detail_pub
(
  id integer primary key not null,
  item_id integer not null,
  item_detail_id integer not null,
  pfbz varchar(1000) default '' not null,
  fs number(4,2) default 0 not null,
  jd integer not null,
  status integer default 0 not null,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

create index item_d_pub_item_id on kp_check_item_detail_pub(item_id asc);
create index item_d_pub_item_detail_id on kp_check_item_detail_pub(item_detail_id asc);

create sequence kp_check_item_detail_pub_id
start with 1
increment by 1
nomaxvalue
nocycle;

create or replace trigger kp_check_item_d_pub_id_trigger
before insert on kp_check_item_detail_pub
for each row
begin
select kp_check_item_detail_pub_id.nextval into :new.id from dual;
end;

create table kp_check_item_pub_pf
(
  id integer primary key not null,
  pub_id integer not null,
  org_id integer not null,
  status integer default 0 not null,
  pfsm varchar(2000) default '' not null,
  kp_time date ,
  jd integer not null,
  type integer default 0 not null,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

create index pf_pub_id on kp_check_item_pub_pf(pub_id asc);
create index pf_org_id on kp_check_item_pub_pf(org_id asc);

create sequence kp_check_item_pub_pf_id
start with 1
increment by 1
nomaxvalue
nocycle;

create or replace trigger kp_c_i_pub_pf_id_trigger
before insert on kp_check_item_pub_pf
for each row
begin
select kp_check_item_pub_pf_id.nextval into :new.id from dual;
end;

create table kp_check_item_detail_pub_pf
(
  id integer primary key not null,
  pub_id integer not null,
  pub_detail_id integer not null,
  org_id integer not null,
  status integer default 0 not null,
  pf number(4,2) default 0 not null,
  type integer default 0 not null,
  kp_time date ,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

create index pf_detail_pub_id on kp_check_item_detail_pub_pf(pub_id asc);
create index pf_detail_org_id on kp_check_item_detail_pub_pf(org_id asc);
create index pf_detail_pub_detail_id on kp_check_item_detail_pub_pf(pub_detail_id asc);

create sequence kp_check_item_d_pub_pf_id
start with 1
increment by 1
nomaxvalue
nocycle;

create or replace trigger kp_c_i_d_pub_pf_id_trigger
before insert on kp_check_item_detail_pub_pf
for each row
begin
select kp_check_item_d_pub_pf_id.nextval into :new.id from dual;
end;

