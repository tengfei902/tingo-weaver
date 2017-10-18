alter table qingdan add status integer default 0 not null;
comment on column qingdan.status is '0:使用中,1已停用';

create table kp_check_item_pub
(
id  INTEGER PRIMARY KEY NOT NULL ,
item_id INTEGER NOT NULL ,
item_detail_id INTEGER NOT NULL ,
qd_id INTEGER NOT NULL ,
kpnr VARCHAR (2000) NOT NULL default '',
tkxz VARCHAR (2000) NOT NULL default '',
kpfs VARCHAR (5) NOT NULL default 'ADD',
fs number(4,2) not null default 0,
pfbz VARCHAR (1000) not null default '',
show_order INTEGER not null default 0,
zpsm VARCHAR (1000) not null default '',
zp_status int (5) not null default 0 ,

create_time DATE not null default sysdate,
update_time DATE  NOT NULL DEFAULT sysdate,
version INTEGER NOT NULL default 1
);

/
create sequence kp_check_item_pub_id
start with 1
increment by 1
nomaxvalue
nocycle
/
create or replace trigger kp_check_item_pub_trigger
before insert on kp_check_item_pub
for each row
begin
select kp_check_item_pub_id.nextval into :new.id from dual;
end;
/

