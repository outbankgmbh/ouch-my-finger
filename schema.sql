
--- Case A
--- Now customerAsByContractCustomerAContractAIdAndCustomerAId is visible under contractA as connection
--- contractAsByContractCustomerACustomerAIdAndContractAId is missing in customerA

create table contract_a (
  id serial primary key,
  name text not null
);

create table customer_a (
  id serial primary key,
  name text not null
);

create table contract_customer_a (
  contract_a_id int constraint contract_customer_contract_a_id_fkey references contract_a (id),
  customer_a_id int constraint contract_customer_customer_a_id_fkey references customer_a (id),
  primary key (contract_a_id, customer_a_id)
);

insert into contract_a (id, name) values (1, 'contract1'), (2, 'contract2'), (3, 'contract3'), (4, 'contract4');
insert into customer_a (id, name) values (1, 'customer1'), (2, 'customer2'), (3, 'customer3'), (4, 'customer4');
insert into contract_customer_a (contract_a_id, customer_a_id) values (1, 1), (1, 2), (2, 3), (2, 1), (3, 4), (3,2), (4, 1), (4, 3);

--- Case B
--- Now contractBsByContractCustomerBCustomerBIdAndContractBId is visible under customerB as connection
--- customerBsByContractCustomerBContractBIdAndCustomerBId is missing in contractB

create table contract_b (
  id serial primary key,
  name text not null
);

create table customer_b (
  id serial primary key,
  name text not null
);

create table contract_customer_b (
  customer_b_id int constraint contract_customer_customer_b_id_fkey references customer_b (id),
  contract_b_id int constraint contract_customer_contract_b_id_fkey references contract_b (id),
  primary key (customer_b_id, contract_b_id)
);

insert into contract_b (id, name) values (1, 'contract1'), (2, 'contract2'), (3, 'contract3'), (4, 'contract4');
insert into customer_b (id, name) values (1, 'customer1'), (2, 'customer2'), (3, 'customer3'), (4, 'customer4');
insert into contract_customer_b (customer_b_id, contract_b_id) values (1, 1), (1, 2), (2, 3), (2, 1), (3, 4), (3,2), (4, 1), (4, 3);

--- Case C
--- working both directions

create table contract_c (
  id serial primary key,
  name text not null
);

create table customer_c (
  id serial primary key,
  name text not null
);

create table contract_customer_c (
  contract_c_id int,
  customer_c_id int
);

insert into contract_c (id, name) values (1, 'contract1'), (2, 'contract2'), (3, 'contract3'), (4, 'contract4');
insert into customer_c (id, name) values (1, 'customer1'), (2, 'customer2'), (3, 'customer3'), (4, 'customer4');
insert into contract_customer_c (contract_c_id, customer_c_id) values (1, 1), (1, 2), (2, 3), (2, 1), (3, 4), (3,2), (4, 1), (4, 3);
comment on table contract_customer_c is E'@foreignKey (contract_c_id) references contract_c (id)\n@foreignKey (customer_c_id) references customer_c (id)';


--- Case D
--- working both directions, but via materialized views

create MATERIALIZED view contract_d AS
select id, name from contract_c;
create MATERIALIZED view customer_d AS
select id, name from customer_c;
create MATERIALIZED view contract_customer_d AS
select contract_c_id as contract_d_id, customer_c_id as customer_d_id from contract_customer_c;
comment on MATERIALIZED view contract_customer_d is E'@foreignKey (contract_d_id) references contract_d (id)\n@foreignKey (customer_d_id) references customer_d (id)';

--- Case E
--- working both directions, but via normal views

create  view contract_e AS
select id, name from contract_c;
create  view customer_e AS
select id, name from customer_c;
create  view contract_customer_e AS
select contract_c_id as contract_e_id, customer_c_id as customer_e_id from contract_customer_c;
comment on  view contract_customer_e is E'@foreignKey (contract_e_id) references contract_e (id)\n@foreignKey (customer_e_id) references customer_e (id)';