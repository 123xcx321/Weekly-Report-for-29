-- 约束:使用alter
/*
1.非空约束：not null
2.唯一约束：unique
3.主键约束：primary key：是非空的也是唯一的，可以用on_increment来自增
4.默认约束：default + 默认值
5.检查约束：check()
6.外键约束：foreign key:被关联的表的键必须是主键或者唯一键
*/
create table user(
    id int primary key auto_increment comment '主键',
    name varchar(20) not null unique comment '姓名',
    age int check(age>0 and age<=120) comment '年龄',
    status char(1) default '1' comment '状态',
    gender char(1) comment '性别'
) comment '用户表';

show tables;

insert into user (name, age, status, gender) values ('张三', 20, 1, '男'),('李四', 25, 1, '男');
insert into user (name, age, gender) values ('五五', 18, '女');
insert into user (name, age, status, gender) values('六六', 25, 0, '女'),('七七', 27, 0, '女');
select * from user;


/*
外键的建立：1.创建表时就指定：[constraint] [外键名] foreign key(外键字段名) references 主表(字段名)  
            2.关联两个表：alter table 表名 add constraint 外键名 foreign key (表一字段名) references 主表(字段名)
外键的删除：alter table 表名 drop 外键名
外键的约束：no action, restrict, cascade，set null
*/
-- 建立状态表
create table cur_sta(
    status int comment '状态',
    descr varchar(10) comment '描述'
) comment '状态表';
select * from cur_sta;
insert into cur_sta(status, descr) values (1, '状态满满'), (0, '状态很差');

-- 为cur_sta表的status键添加unique约束
alter table cur_sta add unique (status);

-- 修改user表的status字段的类型
alter table user modify status int;
alter table user add constraint user_constraint foreign key (status) references cur_sta(status);
show create table user;

-- 增加级联约束,先删后修
alter table user drop foreign key user_constraint;

alter table user add constraint user_constraint foreign key (status) references cur_sta(status) on update cascade on delete cascade;

-- 删除cur_sta表的0数据
delete from cur_sta where status = 0;