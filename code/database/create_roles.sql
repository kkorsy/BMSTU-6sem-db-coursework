create user "guest";
create user "reg_user";
create user "admin";

alter role "admin" superuser;

grant select on table Serials to "guest";

grant select on table Serials to "reg_user";
grant select on table Comments to "reg_user";
grant insert on table Comments to "reg_user";
grant delete on table Comments to "reg_user";
grant alter on table Comments to "reg_user";
grant select on table Favourites to "reg_user";
grant insert on table Favourites to "reg_user";
grant delete on table Favourites to "reg_user";