alter table qingdan add status integer default 0 not null;
comment on column qingdan.status is '0:使用中,1已停用';

alter table qingdan add jd integer;

create table kp_check_item
(
  id INTEGER primary key not null,
  qd_id INTEGER not null,
  qd VARCHAR(100) default '' not null,
  kpnr VARCHAR(1000) default '' not null,
  kpfs VARCHAR(1000) default '' not null,
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

create table kp_check_item_detail
(
  id integer primary key not null,
  item_id integer not null,
  pfbz varchar(1000) default '' not null,
  fs number(4,2) default 0 not null,
  tkxz varchar(2000) default '' not null,
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

create table kp_check_item_pub (
  id INTEGER primary key not null,
  item_id integer not null,
  qd_id INTEGER not null,
  qd VARCHAR(100) default '' not null,
  kpnr VARCHAR(1000) default '' not null,
  kpfs varchar(10) default 'ADD' not null,
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

create table kp_check_item_zp
(
  id integer primary key not null,
  item_id integer not null,
  org_id integer not null,
  status integer default 0 not null,
  zpsm varchar(2000) default '',
  zp_time date ,
  jd integer not null,
  qd_id integer not null,
  qd varchar(100) default '' not null,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

alter table kp_check_item_zp add constraint unq_zp unique( item_id,org_id);

create sequence kp_check_item_zp_id
start with 1
increment by 1
nomaxvalue
nocycle;

create table kp_check_item_detail_zp
(
  id integer primary key not null,
  item_id integer not null,
  detail_id integer not null,
  zp_id integer not null,
  org_id integer not null,
  pf number(4,2) default 0 not null,
  zp_time date ,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

alter table kp_check_item_detail_zp add constraint unq_zp_detail unique(detail_id,org_id);

create sequence kp_check_item_detail_zp_id
start with 1
increment by 1
nomaxvalue
nocycle;

create table kp_check_item_pf
(
  id integer primary key not null,
  item_id integer not null,
  zp_id integer not null,
  org_id integer not null,
  qd_id integer default 0 not null,
  qd varchar(100) default '' not null,
  to_org_id INTEGER  not null,
  status integer default 0 not null,
  pfsm varchar(2000) default '',
  kp_time date ,
  jd integer not null,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);
alter table kp_check_item_pf add constraint unq_pf unique(item_id,org_id,to_org_id);
create sequence kp_check_item_pf_id
start with 1
increment by 1
nomaxvalue
nocycle;

create table kp_check_item_detail_pf
(
  id integer primary key not null,
  pf_id integer not null,
  item_id integer not null,
  item_detail_id integer not null,
  zp_id integer not null,
  org_id integer not null,
  to_org_id integer not null,
  pf number(4,2) default 0 not null,
  kp_time date ,
  create_time date default sysdate not null,
  update_time date default sysdate not null,
  version integer default 1 not null
);

alter table kp_check_item_detail_pf add constraint unq_pf_detail unique(item_detail_id,org_id,to_org_id);

create sequence kp_check_item_d_pf_id
start with 1
increment by 1
nomaxvalue
nocycle;

