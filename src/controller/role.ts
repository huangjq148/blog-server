/**
 *   @Author huangjq
 *   @createDate 2019/8/12
 */
import { ResponseResult } from "@/models";
import { queryPage, queryObj, insert, update, remove } from "@/db";
import { Context } from "koa";
const TABLE = "t_role";

// 查询角色列表
const queryRoleList = async (ctx: Context) => {
  ctx.body = ResponseResult.success(await queryPage(TABLE, ctx.request.query));
};

// 根据id查询角色
const queryRoleById = async (ctx: Context) => {
  let result = await queryObj(TABLE, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

// 根据id删除角色
const delRoleById = async (ctx: Context) => {
  let result = await remove(TABLE, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

// 添加角色
const addRole = async (ctx: Context) => {
  let result = await insert(TABLE, ctx.request.body);
  ctx.body = ResponseResult.success(result);
};

// 更新角色
const updateRole = async (ctx: Context) => {
  let result = await update(TABLE, ctx.request.body, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

module.exports = {
  "GET ": queryRoleList,
  "POST ": addRole,
  "GET /:id": queryRoleById,
  "DELETE /:id": delRoleById,
  "PUT /:id": updateRole,
};
