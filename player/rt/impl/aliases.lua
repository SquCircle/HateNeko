-- 旧版引擎的积木命名别名 + 少量真缺的小原语
-- 依据 tools/audit_domains.py 的对照结果（官方 domain 表 vs 我们的原语）
local V = require("rt.values")

local M = {}
local base                    -- 运行时原语表（register 时注入）

-- 名字别名：旧名 → 我们已有的实现
local ALIAS = {
  -- 列表：旧版用 lists_* 前缀
  lists_get = "list_get",
  lists_append = "list_append",
  lists_delete = "delete_list_item",
  lists_insert_value = "list_insert_value",
  lists_replace = "replace_list_item",
  lists_get_value = "list_item",
  lists_is_exist = "list_is_exist",
  lists_index_of = "list_index_of",
  lists_length = "list_length",
  lists_copy = "list_copy",
  -- 其它改名
  math_single = "math_function",
  random = "random_num",
  change_variable = "change_variables",
  destruct = "dispose_clone",
  terminate = "stop",
  get_timer = "timer",
  get_cur_frames = "current_frames",
  text_join_value = "text_join",
}

M.ALIAS = ALIAS

function M.install(tbl, primitives)
  base = primitives
  for old, new in pairs(ALIAS) do
    if not tbl[old] and base[new] then tbl[old] = base[new] end
  end
end

---------------------------------------------------------------- 真缺的小原语
-- 文本：取索引 / 追加 / 隐式转字符串 / 多行文本
function M.text_indexOf(self, args, th)
  local a = V.str(args.text or args.A or args.string or "")
  local b = V.str(args.text2 or args.B or args.sub or "")
  local i = string.find(a, b, 1, true)
  return i or 0
end

function M.text_append(self, args, th)
  return V.str(args.text or args.A or "") .. V.str(args.text2 or args.B or "")
end

function M.text_implicit(self, args, th)
  -- 隐式转字符串（JS 的 String()）；数组用逗号连接
  return V.js_str(args.text or args.value or args.A)
end

-- 当前帧数（官方 get_cur_frames）
function M.get_cur_frames(self, args, th)
  local g = th and th.sched and th.sched.game
  return g and g.frame or 0
end

function M.multiline_text(self, args, th)
  return V.str(args.text or args.TEXT or args.value or "")
end

---------------------------------------------------------------- 云/用户功能的离线桩
-- 说明：这些是官方依赖服务端的功能。离线时返回"游客"级稳定值，
-- 让依赖它们的作品（比如启动时要读在线榜单的作品）能走完加载流程。
function M.user_id_get(self, args, th) return 0 end
function M.username_get(self, args, th) return "游客" end
function M.user_info_of_th(self, args, th)
  local t = tostring(args.type or "")
  if t == "username" then return "游客" end
  if t == "userId" then return 0 end
  return 0 -- score
end
function M.update_ranking(self, args, th) end
function M.show_hide_ranking(self, args, th) end

return M
