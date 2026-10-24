-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：我的作品   version=0.27.4
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { increase = "increase", value = 100 },
  { sprite = "--self", text = "Hi" },
  { sprite = "--self", text = "【紧急安全预警】关于 PHP2Shell (CVSS 9.2) 核心级 RCE 漏洞的修复指南\
尊敬的客户：\
您好！针对即将在北京时间 10 月 21 日（周三）22:00 公开的 PHP 核心严重安全漏洞，我们在此向您发布最高级别的安全预警。\
据国际安全机构 Sansec 披露，此次爆发的漏洞被称为 PHP2Shell。目前该漏洞的自动化利用工具截图已在安全社区泄露，预计官方补丁发布后 15 分钟内，全网将出现大规模的无差别扫描与攻击。\
漏洞核心情报\
漏洞代号/编号： PHP2Shell (CVE-2026-109618, CVE-2026-109619)\
危险等级： CVSS 9.2（极度危险）\
漏洞类型： 远程代码执行（RCE），攻击者可直接接管服务器获取 Shell。\
受影响版本： PHP 5.4 及以上所有版本。Magento、Shopware、WooCommerce 等电商系统及各类 CMS 将受严重威胁。\
补丁发布时间： 北京时间 10 月 21 日（周三）22:00（14:00 UTC）\
⚠️ 核心警告：无法在代码层防御\
该漏洞存在于 PHP 的底层架构中。这意味着任何代码级别的修改、面板加固或常规的应用层防护插件都无法拦截此攻击。防御的唯一有效方式是在服务器基础设施层面（环境底层）直接更新 PHP 版本。\
紧急应对与修复建议\
官方将仅为 PHP 8.2、8.3、8.4 和 8.5 发布修复补丁。请您立即采取以下行动：\
1. 正在使用 PHP 8.2 - 8.5 的用户（需今晚紧急操作）：\
随时待命： 请通知您的运维团队在今晚 22:00 前做好准备。\
抢占黄金 15 分钟： 补丁一旦发布，请务必在第一波自动化攻击到来前，通过包管理器（apt/yum）或重新编译升级 PHP，并立刻重启相关服务（Nginx/Apache/PHP-FPM）。\
2. 正在使用 PHP 8.1 及以下旧版本（含 5.6、7.x 等）的用户：\
官方已明确不会为这些版本发布补丁。继续使用这些版本将让您的服务器完全裸露在 PHP2Shell 的攻击火力之下。\
短期缓解： 立即排查并收紧服务器安全组及防火墙（iptables/firewalld）策略，开启高级别 WAF，并在 php.ini 中禁用高风险命令执行函数。\
长期建议： 请即刻安排业务环境迁移，将底层升级至受官方支持的 PHP 8.2+ 版本。\
Update:\
据说在 php.ini 设置 session.upload_progress.enabled = Off 可以缓解 （未正式是否有效）\
Update2:\
漏洞利用工具已经发布" },
  { text = "你的名字" },
  { CHOICE0 = "1", question = "1+1=?" },
  { CHOICE0 = "1", CHOICE1 = "2", CHOICE2 = "3", question = "1+1=?" },
}

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = false
M.uses_timer = false
M.timer_hidden_default = false
M.vars = {  }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 1, styles = { "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "025dd83c-de62-46a3-86bb-2ab6333e16c2", is_global = true, name = "编程猫", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", "106119db-7ea0-4d47-a33c-65f3d2a560e1", "509a0c7c-af8b-460f-b9a5-3c273ea8394e", "70cdaef4-bd83-4797-8aec-e1edddec8765" }, visible = true, x = 0, y = -50 } }
M.assets_dir = "works"
M.assets = { ["106119db-7ea0-4d47-a33c-65f3d2a560e1"] = { adaption = nil, center = nil, file = "assets/106119db-7ea0-4d47-a33c-65f3d2a560e1.png", id = "106119db-7ea0-4d47-a33c-65f3d2a560e1", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/6e4d95aecf7441e6a9885cba405baeaf.png" }, ["509a0c7c-af8b-460f-b9a5-3c273ea8394e"] = { adaption = nil, center = nil, file = "assets/509a0c7c-af8b-460f-b9a5-3c273ea8394e.png", id = "509a0c7c-af8b-460f-b9a5-3c273ea8394e", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/25593adb06d24d988ada59c1d2131de8.png" }, ["5a1f9428-61c8-4ff3-984b-78ff34bdf04d"] = { adaption = nil, center = nil, file = "assets/5a1f9428-61c8-4ff3-984b-78ff34bdf04d.png", id = "5a1f9428-61c8-4ff3-984b-78ff34bdf04d", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/caf8f973dbe240babece35637dcafee8.png" }, ["6d0d6c61-a1df-4076-8c19-83ddfdbbca1c"] = { adaption = nil, center = nil, file = "assets/6d0d6c61-a1df-4076-8c19-83ddfdbbca1c.jpg", id = "6d0d6c61-a1df-4076-8c19-83ddfdbbca1c", name = "沼泽", styleType = 1, url = "https://creation.codemao.cn/396/8bc3a5b92e934d7287e63f1684b61de6.jpg" }, ["70cdaef4-bd83-4797-8aec-e1edddec8765"] = { adaption = nil, center = nil, file = "assets/70cdaef4-bd83-4797-8aec-e1edddec8765.png", id = "70cdaef4-bd83-4797-8aec-e1edddec8765", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/8aa8cbdbe82a442989b0fadb823444d4.png" }, ["e9792a0f-ae14-4489-90c8-dd0fd6edd6d9"] = { adaption = nil, center = nil, file = "assets/e9792a0f-ae14-4489-90c8-dd0fd6edd6d9.png", id = "e9792a0f-ae14-4489-90c8-dd0fd6edd6d9", name = "一阶编程猫跳跳", styleType = nil, url = "https://creation.codemao.cn/396/c364f36a8dcf42d1a6acbe26c7eb6aaa.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_025dd83c_de62_46a3_86bb_2ab6333e16c2 = ents["025dd83c-de62-46a3-86bb-2ab6333e16c2"]
  -- -------- 角色 编程猫 --------
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "sprite_on_tap", { sprite = "--self", type = "mouse_click" }, function(th, self)
      f["self_change_coordinate_x"](self, __CONST[1], th)
  end)
  rt.on(e_025dd83c_de62_46a3_86bb_2ab6333e16c2, "on_running_group_activated", {}, function(th, self)
      f["create_stage_dialog"](self, __CONST[2], th)
      f["create_stage_dialog"](self, __CONST[3], th)
      f["self_ask"](self, __CONST[4], th)
      f["ask_and_choose"](self, __CONST[5], th)
      f["ask_and_choose"](self, __CONST[6], th)
  end)
end

M.requires = {
  "ask_and_choose",
  "create_stage_dialog",
  "self_ask",
  "self_change_coordinate_x",
}
return M
