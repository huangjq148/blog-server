const mysql = require("mysql");
const UUID = require("node-uuid");
const dayjs = require("dayjs");
const config = require("../../config/index");

let pool = mysql.createPool(config.DB_INFO);

// EQ 就是 EQUAL等于
// NE就是 NOT EQUAL不等于
// GT 就是 GREATER THAN大于
// LT 就是 LESS THAN小于
// GE 就是 GREATER THAN OR EQUAL 大于等于
// LE 就是 LESS THAN OR EQUAL 小于等于
export const SEARCH_OPERATOR = {
  eq: "=",
  ne: "!=",
  gt: ">",
  lt: "<",
  ge: ">=",
  le: "<=",
  like: "like",
};

export const SORTABLE = {
  ascending: "asc",
  descending: "desc",
  asc: "asc",
  desc: "desc",
};

/**
 * 替换sql语句中的问号
 * @param sql
 * @param params
 */
const replaceWenHao = (sql: string, params) => {
  let i = 0;
  // let params = ["d818acf06c0a11eaa60bcb95426e4e52","h6u77d",7,"6hgy",7,7,"2020-03-22 15:37:55","d818acf06c0a11eaa60bcb95426e4e52"];
  let result = sql.replace(/\?/g, (item, index, c, d, e) => {
    let arg = params[i++];
    if (isNaN(arg)) {
      arg = `"${arg}"`;
      // arg = '"' + arg + '"';
    }
    return arg;
  });
  return result;
};

/**
 * 生成查询条件语句
 * @param whereMap {name_like: "张三"}
 * @param params
 */
const generateWhereSql = (whereMap, params) => {
  let whereMapSql = "";
  for (let key in whereMap) {
    let op = "=";
    let tmpArr = key.split("_");
    let newKey = key;

    if (tmpArr.length > 1) {
      op = SEARCH_OPERATOR[key.substr(key.indexOf("_") + 1)];
      newKey = tmpArr[0];
    }

    if (whereMap[key]) {
      if (op === "like") {
        whereMapSql += ` and ${newKey} like concat('%',?,'%') `;
      } else {
        whereMapSql += ` and ${newKey} ${op} ?`;
      }
      params.push(whereMap[key]);
    }
  }
  return whereMapSql;
};

/**
 * 执行sql语句，返回查询结果的Promise对象
 * @param sql
 * @param params
 */
export const excQuery = (sql: string, params?: any): Promise<Array<any>> => {
  console.log("sql:" + sql);
  console.log("params:" + params);
  console.log("result---", replaceWenHao(sql, params));

  return new Promise(function (resolve, reject) {
    pool.getConnection(function (err, conn) {
      if (err) {
        reject(err);
      } else {
        conn.query(sql, params, function (qerr, vals, fields) {
          //释放连接
          conn.release();
          //事件驱动回调
          // callback(qerr, vals, fields)
          if (qerr == null) {
            resolve(vals);
          } else {
            console.error(qerr);
            reject(qerr);
          }
        });
      }
    });
  });
};

/**
 * 根据id获取
 * @param tableName 表名
 * @param id
 */
export async function findById(tableName: string, id: string) {
  return queryObj.call(this, tableName, { id });
}

/**
 * 根据条件查询对象
 * @param tableName
 * @param params
 */
export async function queryObj(tableName: string, params) {
  let sql = `select * from ${tableName || this.tableName} where 1=1 `,
    whereMapSql = "",
    queryParams = [];
  for (let key in params) {
    whereMapSql += ` and ${key} = ?`;
    queryParams.push(params[key]);
  }
  return excQuery(sql + whereMapSql, queryParams)
    .then((result: Array<any>) => {
      let responseResult = {};
      if (result.length > 0) {
        responseResult = result[0];
      } else {
        responseResult = Promise.reject("没有符合条件的数据");
      }
      return responseResult;
    })
    .catch((reason) => {
      return reason;
    });
}

/**
 * 插入对象
 * @param tableName
 * @param dataObj
 */
export async function insert(tableName: string, dataObj) {
  let sql = `insert into ${tableName}({{keys}}) values({{values}})`;
  let params = [];
  let keys = [];
  let values = [];

  if (dataObj.id === "" || dataObj.id === undefined) {
    dataObj.id = UUID.v1().replace(/-/g, "");
  }
  if (!dataObj.createTime) {
    dataObj.createTime = dayjs().format("YYYY-MM-DD HH:mm:ss");
  }
  if (this.req.session.curUser) {
    dataObj.createUser = this.req.session.curUser.id;
  }
  for (let key in dataObj) {
    if (dataObj[key] || dataObj[key] === 0) {
      keys.push(key);
      values.push("?");
      params.push(dataObj[key]);
    }
  }
  sql = sql.replace("{{keys}}", keys.join(","));
  sql = sql.replace("{{values}}", values.join(","));
  return excQuery(sql, params).then((res) => ({
    result: res,
    dataObj: dataObj,
  }));
}

/**
 * 修改对象
 * @param tableName 表名
 * @param dataObj 修改后的字段数据
 * @param updateParams 待修改对象需符合的条件
 */
export async function update(
  tableName: string,
  dataObj: any,
  updateParams: Object
) {
  let sql = `update ${tableName} set {{updateSql}} where 1=1 {{whereSql}}`;
  let params = [];
  const updateSql: any = [];
  let whereSql: string = "";

  if (!dataObj.updateTime) {
    dataObj.updateTime = dayjs().format("YYYY-MM-DD HH:mm:ss");
  }
  if (this.curUser) {
    dataObj.createUser = this.curUser.username;
  }
  for (let key in dataObj) {
    if (dataObj[key] || dataObj[key] === 0) {
      updateSql.push(` ${key}=?`);
      params.push(dataObj[key]);
    }
  }
  for (let key in updateParams) {
    if (updateParams[key]) {
      whereSql += ` and ${key}=?`;
      params.push(updateParams[key]);
    }
  }
  sql = sql.replace("{{updateSql}}", updateSql);
  sql = sql.replace("{{whereSql}}", whereSql);
  return excQuery(sql, params);
}

/**
 * 删除数据
 * @param tableName 表名
 * @param paramsObj 待修改对象需符合的条件
 */
export async function doDelete(tableName: string, paramsObj: any) {
  let sql = `delete from ${tableName} where 1=1 `;
  let params = [];
  for (let key in paramsObj) {
    if (paramsObj[key]) {
      sql += ` and ${key}=?`;
      params.push(paramsObj[key]);
    }
  }
  return excQuery(sql, params);
}

/**
 * 查询列表
 * @param tableName 表名
 * @param queryParams 查询条件
 */
export async function queryList(
  tableName: string,
  queryParams: any
): Promise<Array<any>> {
  let whereMap = queryParams.whereMap;
  let params = [];
  let whereMapSql = this.generateWhereSql(whereMap, params);
  let sql = `select * from ${tableName || this.tableName} where 1=1 `;
  sql += whereMapSql;
  return excQuery(sql, params);
}

/**
 * 分页查询
 * @param tableName 表名
 * @param queryParams 查询条件
 */
export async function queryPage(tableName: string, queryParams: any) {
  let whereMap = queryParams.whereMap,
    sort = queryParams.sort,
    params = [],
    currentPage = queryParams.currentPage,
    pageSize = queryParams.pageSize;

  let sql = `select * from ${tableName || this.tableName} where 1=1 `;
  let whereMapSql,
    sortSql = "",
    limitSql = "";

  whereMapSql = generateWhereSql(whereMap, params);

  if (sort && sort.value) {
    sortSql += ` order by ${sort.key} ${SORTABLE[sort.value]}`;
  }
  if (!sortSql) {
    sortSql += ` order by createTime desc  `;
  }

  if (pageSize) {
    let startIndex = (currentPage - 1) * pageSize;
    limitSql = ` limit ${startIndex},${pageSize}`;
  }

  let contentFn = excQuery(sql + whereMapSql + sortSql + limitSql, params);
  let pageFn = excQuery(
    `select count(*) total from (${sql + whereMapSql}) allRecord`,
    params
  );
  return Promise.all([contentFn, pageFn])
    .then((result) => {
      return { content: result[0], totalRecord: result[1][0]["total"] };
    })
    .catch((reason) => {
      return reason;
    });
}

/**
 * 修改数据的数字字段，例如增加访问次数，增加点击次数的场景
 * @param data	需要修改的数据
 * @param whereMap 条件	{prop1: 3}
 * @param tableName	表格名
 */
export async function increase(tableName: string, data: any, whereMap: any) {
  let updateSql = `update ${tableName} set {{update}} where 1=1 `;
  let whereMapSql = "";
  let updateData = [];
  let params = [];
  for (let key in data) {
    updateData.push(` ${key} = ${key} + ?`);
    params.push(data[key]);
  }
  whereMapSql = generateWhereSql(whereMap, params);
  updateSql += whereMapSql;
  updateSql = updateSql.replace("{{update}}", updateData.join(","));
  return excQuery(updateSql, params);
}

export default {
  findById,
  queryObj,
  insert,
  update,
  doDelete,
  queryList,
  queryPage,
  increase,
};
module.exports = {
  findById,
  queryObj,
  insert,
  update,
  doDelete,
  queryList,
  queryPage,
  increase,
};
