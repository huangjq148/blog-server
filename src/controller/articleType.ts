/**
 *   @Author huangjq
 *   @createDate 2019/8/12
 */
import { ArticleType, ResponseResult } from "@/models";
import { queryPage, findById, insert, update, remove, excQuery } from "@/db";
import { Context } from "koa";
const TABLE = "t_article_type";

const queryAccountPage = async (ctx: Context) => {
  ctx.body = ResponseResult.success(await queryPage(TABLE, ctx.request.query));
};
// const queryArticleTypePage = async (ctx: Context) => {
//   let result = await queryPage(TABLE, {
//     ...ctx.request.body,
//     sort: { key: "sortNo", value: "asc" },
//   });
//   ctx.body = ResponseResult.success(result);
// };

const queryArticleTypeById = async (ctx: Context) => {
  let result = await findById(TABLE, ctx.params.id);
  ctx.body = ResponseResult.success(result);
};

const delArticleTypeById = async (ctx: Context) => {
  let result = await remove(TABLE, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

const addArticleType = async (ctx: Context) => {
  let result = await insert(TABLE, ctx.request.body);
  ctx.body = ResponseResult.success(result);
};

const updateArticleType = async (ctx: Context) => {
  let result = await update(TABLE, ctx.request.body, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

const sortArticleType = async (ctx: Context) => {
  const { id, isUp } = ctx.params;
  const oldObj = await findById(TABLE, id);
  let sortNo = oldObj.sortNo;
  let newSortNo = isUp === "0" ? sortNo + 1 : sortNo - 1;
  console.log("oldSortNo", sortNo, isUp);
  let sql1 = `update t_article_type set sortNo=sortNo${
    isUp === "0" ? "+" : "-"
  }1 where id='${id}'`;
  let sql2 = `update t_article_type set sortNo=sortNo${
    isUp === "0" ? "-" : "+"
  }1 where sortNo=${newSortNo} and id!='${id}'`;
  await excQuery(sql1);
  await excQuery(sql2);
  ctx.body = ResponseResult.success({});
};

module.exports = {
  "GET ": queryAccountPage,
  "GET /:id": queryArticleTypeById,
  "DELETE /:id": delArticleTypeById,
  "POST ": addArticleType,
  "PUT /:id": updateArticleType,
  "PUT /sort/:id/:isUp": sortArticleType,
};
