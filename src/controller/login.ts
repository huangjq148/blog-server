import { findById, queryObj } from "@/db";
import { Context } from "koa";
import { ResponseResult } from "@/models";

const test = async (ctx: Context) => {
  const name = ctx.request.body.name || "",
    password = ctx.request.body.password || "asd";
  const result = await findById.call(ctx, "t_user", "000000");
  ctx.body = ResponseResult.success(result);
};

const login = async (ctx: Context) => {
  let queryParams = {
    username: ctx.request.body.username,
    password: ctx.request.body.password,
  };
  let accountInfo = await queryObj("t_user_account", queryParams);
  if (accountInfo.id) {
    const roles = accountInfo.roles;
    let permissions = new Set();
    let permissionList: any;
    if (roles && typeof roles === "string") {
      const roleList = roles.split(",");
      for (let i = 0; i < roleList.length; i++) {
        const role = await queryObj("t_role", { code: roleList[i] });
        role.permissions &&
          role.permissions.split(",").map((item) => {
            permissions.add(item);
          });
      }
    }
    let userInfo = await queryObj("t_user", { id: accountInfo.userId });
    permissionList = Array.from(permissions) || [];
    ctx.session.curUser = {
      id: accountInfo.id,
      userId: userInfo.id,
      username: accountInfo.username,
      name: userInfo.name,
      sex: userInfo.sex,
      avatar: userInfo.avatar,
      permissionList,
    };
    console.log(ctx.session.curUser);
    ctx.response.body = ResponseResult.success({ message: "登录成功" });
  } else {
    ctx.response.body = ResponseResult.fail(accountInfo, "登录失败");
  }
};

const logout = async (ctx: Context) => {
  ctx.session.curUser = null;
  ctx.response.body = ResponseResult.success("注销成功");
};

module.exports = {
  "POST ": login,
  "GET /logout": logout,
};
