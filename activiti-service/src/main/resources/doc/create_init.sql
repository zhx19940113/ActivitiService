drop table if exists `act_excute_task`;
create table `act_excute_task` (
  `id` bigint(20) not null comment '主键',
  `batch_id` bigint(20) null default null comment '批次号，验证任务调用时存在',
  `proc_release_id` bigint(20) not null comment '模型版本id',
  `proc_inst_id` varchar(64) character set utf8 collate utf8_bin null default null comment '流程运行实例id',
  `status` varchar(32) character set utf8 collate utf8_bin null default null comment '任务状态，0-待执行，1-启动成功，2-执行完成，3-执行异常',
  `type` varchar(32) character set utf8 collate utf8_bin null default null comment '任务类型，0-验证任务，1-业务系统调用',
  `in_paramter` longtext character set utf8 collate utf8_bin null comment '入参',
  `out_paramter` longtext character set utf8 collate utf8_bin null comment '出参，MQ message内容',
  `spend_time` bigint(20) null default null comment '花费时间',
  `remark` varchar(5000) character set utf8 collate utf8_bin null default null comment '备注',
  `create_time` datetime not null comment '创建时间',
  `create_user` varchar(64) character set utf8 collate utf8_bin null default null comment '创建用户',
  `update_time` datetime null default null comment '结束时间',
  primary key (`id`)
) engine = innodb character set = utf8 collate utf8_bin COMMENT '模型版本记录表';

drop table if exists `act_proc_release`;
create table `act_proc_release` (
  `id` bigint(20) not null comment '主键',
  `model_id` varchar(64) character set utf8 collate utf8_bin not null comment '模型id，与 act_re_model.id_ 关联',
  `model_code` varchar(64) character set utf8 collate utf8_bin not null comment '模型编码，与 act_re_model.key_ 关联',
  `model_procdef_id` varchar(64) character set utf8 collate utf8_bin not null comment '模型定义id，与 act_re_procdef.id_ 关联,act_re_procdef 表中有模型部署id',
  `model_name` varchar(255) character set utf8 collate utf8_bin null default null comment '模型名称',
  `model_version` varchar(64) character set utf8 collate utf8_bin null default null comment '模型版本',
  `model_category` varchar(64) character set utf8 collate utf8_bin null default null comment '模型分类',
  `version_type` varchar(2) character set utf8 collate utf8_bin null default null comment '版本类型，0-测试版，1-正式版',
  `is_bind` char(1) character set utf8 collate utf8_bin not null default '0' comment '是否绑定： 0-未绑定，1-已绑定;',
  `is_validate` char(1) character set utf8 collate utf8_bin not null default '0' comment '是否验证通过： 0-待验证，1-验证通过，2-验证不通过；默认为0;',
  `is_auto_validate` char(1) character set utf8 collate utf8_bin not null default '0' comment '是否自动验证通过： 0-待验证，1-验证通过，2-验证不通过；默认为0;',
  `is_manual_validate` char(1) character set utf8 collate utf8_bin not null default '0' comment '是否手动验证通过： 0-待验证，1-验证通过，2-验证不通过；默认为0;',
  `is_approve` char(1) character set utf8 collate utf8_bin not null default '0' comment '是否审核通过：0-待审核，1-审核通过，2-审核不通过；默认为0;',
  `approve_task_id` bigint(20)  comment '模型验证关联任务Id',
  `is_effect` varchar(2) character set utf8 collate utf8_bin not null default '0' comment '是否生效：0-有效，1-无效',
  `update_time` datetime null default null comment '更新时间',
  `update_user` varchar(64) character set utf8 collate utf8_bin null default null comment '更新用户',
  `create_time` datetime not null comment '创建时间',
  `create_user` varchar(64) character set utf8 collate utf8_bin null default null comment '创建用户',
  primary key (`id`)
) engine = innodb character set = utf8 collate utf8_bin;


drop table if exists `act_model_definition`;
create table act_model_definition(
	id bigint(20) NOT NULL COMMENT '主键',
	model_id varchar(50) not null comment '模型id',
	model_code varchar(200) not null comment '模型编码',
	model_name varchar(200) not null comment '模型名称',
	belong_system varchar(200) not null comment '所属系统',
	business_id varchar(200) not null comment '业务线',
	model_desc varchar(500) comment '模型描述',
	`status`  varchar(10) comment '状态',
	cre_user_id varchar(50) comment '创建人id',
	cre_time datetime not null default now()  comment '创建时间'
) engine = innodb character set = utf8 collate utf8_bin;



	drop table if exists `act_process_audit_his`;
	create table act_process_audit_his(
		id bigint(20) NOT NULL COMMENT '主键',
		task_id varchar(50) not null comment '任务id',
		task_name varchar(50) not null comment '任务名',
		pro_inst_id varchar(50) not null comment '流程实例id',
		pro_define_id varchar(100) not null comment '流程定义id',
		task_define_key varchar(100) not null  comment '任务定义key',
		assignee varchar(100) not null  comment '节点审批人',
		opinion varchar(500) not null  comment '审批意见',
		status varchar(50) comment '状态，completed-完成',
		cre_user_id varchar(50) comment '执行人id',
		cre_time datetime not null default now()  comment '审批时间'
	) engine = innodb character set = utf8 collate utf8_bin comment '流程审批历史';


CREATE TABLE `act_process_jump_his` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `pro_name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '流程名',
  `proc_def_id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '流程定义id',
  `proc_inst_id` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '实例id',
  `source_task_id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '跳转原节点id',
  `source_task_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '跳转原节点Name',
  `target_task_id` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '跳转目标节点id',
  `target_task_name` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '跳转目标节点Name',
  `cre_user_id` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '执行人id',
  `cre_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '跳转时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='流程回退历史';