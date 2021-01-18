const config = require("../../config");
import { Code, ResponseResult } from "@/models";
import { queryPage, queryObj, queryList, excQuery, update } from "@/db";
import { Context } from "koa";

const queryDicPage = async function (ctx: Context) {
  let result = await queryPage(ctx.request.body, "t_code_dic");
  ctx.body = ResponseResult.success(result);
};

/**
 * 分页查询表码
 * @param req
 * @param res
 * @param next
 */
const queryPageRecord = async function (cxt: Context) {
  let result = await queryPage("t_code", cxt.request.body);
  cxt.body = ResponseResult.success(result);
};

const code = async (ctx: Context) => {
  const codeId = ctx.params.codeId;
  // const codeId = "SEX";
  const codeInfo = await queryObj("t_code_dic", { codeId });

  if (codeInfo === "not found") {
    ctx.body = codeInfo;
  }
  let result = [];
  if (codeInfo.tableName === "t_code") {
    result = await queryList("t_code", { codeId: codeId });
  } else {
    result = await queryList(codeInfo.tableName, {});
    result = result.map((item) => ({
      code: item[codeInfo.codeName],
      value: item[codeInfo.valueName],
    }));
  }
  ctx.body = ResponseResult.success(codeInfo);
};

const queryDatabaseTables = async function (ctx: Context) {
  const database = config.dbInfo.database;
  const result = await excQuery(
    `select table_name code,table_name value from information_schema.tables where table_schema='${database}'`
  );
  ctx.body = ResponseResult.success(result);
};

const updateDic = async (ctx: Context) => {
  await update("t_code_dic", Code, { codeId: Code.codeId });
  ctx.body = ResponseResult.success("保存成功");
};

module.exports = {
  "GET /TABLES": queryDatabaseTables,
  "GET /": queryPageRecord,
  "GET /dist": queryDicPage,
  "POST /dist": code,
  "PUT /dist": updateDic,
};

// // 表码
// router.get("/code/TABLES",code.queryDatabaseTables)
// router.get("/code/:codeId",code.code)
// router.post("/code",code.queryPage)
// router.post("/code/dist",code.queryDicPage)
// router.put("/code/dist",code.updateDic)
