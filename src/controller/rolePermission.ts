/**
 *   @Author huangjq
 *   @createDate 2019/8/12
 */
import { ResponseResult } from "@/models";
import { queryPage, queryObj, insert, update, remove } from "@/db";
import { Context } from "koa";
const TABLE = "t_role_permission_info";

// 查询权限列表
const queryPermissionList = async (ctx: Context) => {
  ctx.body = ResponseResult.success(await queryPage(TABLE, ctx.request.query));
};

// 根据id查询权限
const queryPermissionById = async (ctx: Context) => {
  let result = await queryObj(TABLE, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

// 根据id删除权限
const delPermissionById = async (ctx: Context) => {
  let result = await remove(TABLE, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

// 添加权限
const addPermission = async (ctx: Context) => {
  let result = await insert(TABLE, ctx.request.body);
  ctx.body = ResponseResult.success(result);
};

// 更新权限
const updatePermission = async (ctx: Context) => {
  let result = await update(TABLE, ctx.request.body, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

module.exports = {
  "GET ": queryPermissionList,
  "POST ": addPermission,
  "GET /:id": queryPermissionById,
  "DELETE /:id": delPermissionById,
  "PUT /:id": updatePermission,
};
