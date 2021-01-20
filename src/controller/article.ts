/**
 *   @Author huangjq
 *   @createDate 2019/8/12
 */
import { Article, ResponseResult } from "@/models";
import { queryPage, queryObj, insert, update, remove } from "@/db";
import { Context } from "koa";
const TABLE = "t_article";

// 根据类型查询文章列表
const queryArticleListByType = async (ctx: Context) => {
  let id = ctx.params.id;
  id === "all" && (id = "");
  const { currentPage, pageSize } = ctx.request.body;
  let result = await queryPage(TABLE, {
    whereMap: { type_like: id },
    currentPage,
    pageSize,
  });
  ctx.body = ResponseResult.success(result);
};

// 查询文章列表
const queryArticleList = async (ctx: Context) => {
  ctx.body = ResponseResult.success(await queryPage(TABLE, ctx.request.query));
};

// 根据id查询文章
const queryArticleById = async (ctx: Context) => {
  let result = await queryObj(TABLE, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

// 根据id删除文章
const delArticleById = async (ctx: Context) => {
  let result = await remove(TABLE, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

// 添加文章
const addArticle = async (ctx: Context) => {
  let result = await insert(TABLE, ctx.request.body);
  ctx.body = ResponseResult.success(result);
};

// 更新文章
const updateArticle = async (ctx: Context) => {
  let result = await update(TABLE, Article, { id: ctx.params.id });
  ctx.body = ResponseResult.success(result);
};

// router.post("/", async function (req, res) {
//   Utils.copyValue(Article, req.body);
//   await DbUtils.insert(Article);
//   res.json(ResponseResult.success({}));
// });

// router.put("/:id", async function (req, res) {
//   const id = req.params.id;
//   Utils.copyValue(Article, req.body);
//   await DbUtils.update(Article, { id });
//   res.json(ResponseResult.success({}));
// });

module.exports = {
  "GET ": queryArticleList,
  "POST ": addArticle,
  "GET /list/type/:id": queryArticleListByType,
  "GET /:id": queryArticleById,
  "DELETE /:id": delArticleById,
  "PUT /:id": updateArticle,
};
