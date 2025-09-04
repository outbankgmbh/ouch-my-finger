
create table contract (
  id serial primary key,
  name text not null
);

create table customer (
  id serial primary key,
  name text not null
);

create table contract_customer (
  contract_id int constraint contract_customer_contract_id_fkey references contract (id),
  customer_id int constraint contract_customer_customer_id_fkey references customer (id),
  primary key (contract_id, customer_id)
);

insert into contract (id, name) values (1, 'contract1'), (2, 'contract2'), (3, 'contract3'), (4, 'contract4');
insert into customer (id, name) values (1, 'customer1'), (2, 'customer2'), (3, 'customer3'), (4, 'customer4');
insert into contract_customer (contract_id, customer_id) values (1, 1), (1, 2), (2, 3), (2, 1), (3, 4), (3,2), (4, 1), (4, 3);
comment on table contract_customer is E'@omit manyToMany';

