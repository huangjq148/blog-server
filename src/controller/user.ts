import { findById, queryPage, insert, removeByIds, updateById } from "@/db";
import { Context } from "koa";
import { ResponseResult } from "@/models";

const TABLE = "t_user";

const queryMemberPage = async (ctx: Context) => {
  ctx.body = ResponseResult.success(await queryPage(TABLE, ctx.request.query));
};

const queryMenuList = async (ctx: Context) => {
  // ctx.response.body = ResponseResult.success(ctx.session.curUser.permissionList);
  ctx.response.body = ResponseResult.success(["100"]);
};

const curUserInfo = async (ctx: Context) => {
  if (ctx.session.curUser) {
    ctx.response.body = ResponseResult.success(ctx.session.curUser);
  } else {
    ctx.response.body = ResponseResult.fail("获取用户信息失败");
    // ctx.response.body = ResponseResult.success({
    //   name: "Serati Ma",
    //   avatar:
    //     "https://gw.alipayobjects.com/zos/antfincdn/XAosXuNZyF/BiazfanxmamNRoxxVxka.png",
    //   userid: "00000001",
    //   email: "antdesign@alipay.com",
    //   signature: "海纳百川，有容乃大",
    //   title: "交互专家",
    //   group: "蚂蚁金服－某某某事业群－某某平台部－某某技术部－UED",
    //   tags: [
    //     {
    //       key: "0",
    //       label: "很有想法的",
    //     },
    //     {
    //       key: "1",
    //       label: "专注设计",
    //     },
    //     {
    //       key: "2",
    //       label: "辣~",
    //     },
    //     {
    //       key: "3",
    //       label: "大长腿",
    //     },
    //     {
    //       key: "4",
    //       label: "川妹子",
    //     },
    //     {
    //       key: "5",
    //       label: "海纳百川",
    //     },
    //   ],
    //   notice: [
    //     {
    //       id: "xxx1",
    //       title: "Alipay",
    //       logo:
    //         "https://gw.alipayobjects.com/zos/rmsportal/WdGqmHpayyMjiEhcKoVE.png",
    //       description: "那是一种内在的东西，他们到达不了，也无法触及的",
    //       updatedAt: new Date(),
    //       member: "科学搬砖组",
    //       href: "",
    //       memberLink: "",
    //     },
    //     {
    //       id: "xxx2",
    //       title: "Angular",
    //       logo:
    //         "https://gw.alipayobjects.com/zos/rmsportal/zOsKZmFRdUtvpqCImOVY.png",
    //       description: "希望是一个好东西，也许是最好的，好东西是不会消亡的",
    //       updatedAt: new Date("2017-07-24"),
    //       member: "全组都是吴彦祖",
    //       href: "",
    //       memberLink: "",
    //     },
    //   ],
    //   notifyCount: 12,
    //   unreadCount: 11,
    //   country: "China",
    //   geographic: {
    //     province: {
    //       label: "浙江省",
    //       key: "330000",
    //     },
    //     city: {
    //       label: "杭州市",
    //       key: "330100",
    //     },
    //   },
    //   address: "西湖区工专路 77 号",
    //   phone: "0752-268888888",
    // });
  }
};

const addUser = async (ctx: Context) => {
  ctx.response.body = ResponseResult.success(
    insert.call(ctx, TABLE, {
      ...ctx.request.body,
      avatar:
        "https://gw.alipayobjects.com/zos/rmsportal/KDpgvguMpGfqaHPjicRK.svg",
    })
  );
};

const removeUser = async (ctx: Context) => {
  ctx.response.body = ResponseResult.success(
    await removeByIds(TABLE, ctx.params.ids)
  );
};

const queryUserById = async (ctx: Context) => {
  ctx.response.body = ResponseResult.success(
    await findById(TABLE, ctx.params.id)
  );
};

const updateUser = async (ctx: Context) => {
  ctx.response.body = ResponseResult.success(
    await updateById(TABLE, ctx.request.body)
  );
};

module.exports = {
  "POST ": addUser,
  "PUT ": updateUser,
  "DELETE /:ids": removeUser,
  "GET /api/info": curUserInfo,
  "GET ": queryMemberPage,
  "GET /menu": queryMenuList,
  "GET /:id": queryUserById,
};
