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

const logout = async (ctx: Context) => {};
const curUserInfo = async (ctx: Context) => {
  if (ctx.session.curUser) {
    ctx.response.body = ResponseResult.success(ctx.session.curUser);
    // res.json(ResponseResult.success(req.session.curUser))
  } else {
    ctx.response.body = ResponseResult.success({
      name: "Serati Ma",
      avatar:
        "https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png",
      userid: "00000001",
      email: "antdesign@alipay.com",
      signature: "海纳百川，有容乃大",
      title: "交互专家",
      group: "蚂蚁金服－某某某事业群－某某平台部－某某技术部－UED",
      tags: [
        {
          key: "0",
          label: "很有想法的",
        },
        {
          key: "1",
          label: "专注设计",
        },
        {
          key: "2",
          label: "辣~",
        },
        {
          key: "3",
          label: "大长腿",
        },
        {
          key: "4",
          label: "川妹子",
        },
        {
          key: "5",
          label: "海纳百川",
        },
      ],
      notice: [
        {
          id: "xxx1",
          title: "Alipay",
          logo:
            "https://gw.alipayobjects.com/zos/rmsportal/WdGqmHpayyMjiEhcKoVE.png",
          description: "那是一种内在的东西，他们到达不了，也无法触及的",
          updatedAt: new Date(),
          member: "科学搬砖组",
          href: "",
          memberLink: "",
        },
        {
          id: "xxx2",
          title: "Angular",
          logo:
            "https://gw.alipayobjects.com/zos/rmsportal/zOsKZmFRdUtvpqCImOVY.png",
          description: "希望是一个好东西，也许是最好的，好东西是不会消亡的",
          updatedAt: new Date("2017-07-24"),
          member: "全组都是吴彦祖",
          href: "",
          memberLink: "",
        },
      ],
      notifyCount: 12,
      unreadCount: 11,
      country: "China",
      geographic: {
        province: {
          label: "浙江省",
          key: "330000",
        },
        city: {
          label: "杭州市",
          key: "330100",
        },
      },
      address: "西湖区工专路 77 号",
      phone: "0752-268888888",
    });
  }
};
const queryList = async (ctx: Context) => {};
const queryById = async (ctx: Context) => {};
const deleteById = async (ctx: Context) => {};
const add = async (ctx: Context) => {};
const update = async (ctx: Context) => {};
const queryMenuList = async (ctx: Context) => {
  // ctx.response.body = ResponseResult.success(ctx.session.curUser.permissionList);
  ctx.response.body = ResponseResult.success(["100"]);
};

module.exports = {
  "POST /login": login,
  "GET /logout": logout,
  "GET /api/info": curUserInfo,
  "GET /list": queryList,
  "GET /menu": queryMenuList,
  "GET /:id": queryById,
  "DELETE /:id": deleteById,
  "POST /": add,
  "PUT /:id": update,
};
