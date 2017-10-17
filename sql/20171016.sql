alter table qingdan add status integer default 0 not null;
comment on column qingdan.status is '0:使用中,1已停用';
