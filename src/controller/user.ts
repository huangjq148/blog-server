import { findById } from "@/db";
import { Context } from "koa";
import { ResponseResult } from "@/models";

const fn_index = async (ctx: Context) => {
  ctx.response.body = "";
};

const test = async (ctx: Context) => {
  const name = ctx.request.body.name || "",
    password = ctx.request.body.password || "asd";
  const result = await findById.call(ctx, "t_user", "000000");
  ctx.body = ResponseResult.success(result);
};

module.exports = {
  "GET /": test,
};
