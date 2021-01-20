import { findById, queryPage, insert, removeByIds, updateById } from "@/db";
import { Context } from "koa";
import { ResponseResult } from "@/models";

const TABLE = "t_user_account";

const queryAccountPage = async (ctx: Context) => {
  ctx.body = ResponseResult.success(await queryPage(TABLE, ctx.request.query));
};

const addAccount = async (ctx: Context) => {
  ctx.response.body = ResponseResult.success(
    insert.call(ctx, TABLE, ctx.request.body)
  );
};

const removeAccount = async (ctx: Context) => {
  ctx.response.body = ResponseResult.success(
    await removeByIds(TABLE, ctx.params.ids)
  );
};

const queryAccountById = async (ctx: Context) => {
  ctx.response.body = ResponseResult.success(
    await findById(TABLE, ctx.params.id)
  );
};

const updateAccount = async (ctx: Context) => {
  ctx.response.body = ResponseResult.success(
    await updateById(TABLE, ctx.request.body)
  );
};

module.exports = {
  "POST ": addAccount,
  "PUT ": updateAccount,
  "DELETE /:ids": removeAccount,
  "GET ": queryAccountPage,
  "GET /:id": queryAccountById,
};
