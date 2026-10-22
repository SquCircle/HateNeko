-- 界面块：舞台对话框/气泡状态/输入选择队列/翻译占位
package.path="./?.lua;"..package.path
local rt=require("rt.init"); local H=require("rt.host.headless")
local host=H.new(); rt.set_host(host)
local g=rt.load(assert(loadfile("works/ui_new.lua"))(),host)
local e; for _,x in ipairs(g.entities) do if x.kind=="actor" then e=x break end end
local function chk(d,g_,w) if g_~=w then print("FAIL",d,g_,w); os.exit(1) end print("ok",d,g_) end
local th={sched=g.sched, ask=nil}
rt.impl.create_stage_dialog(e,{text="Hi"},th)
chk("stage dialog", g.stage_dialog and g.stage_dialog.text, "Hi")
rt.impl.self_dialog(e,{type="talk",text="Hi",time=2},th)
chk("bubble talk", g.bubbles[e].type, "talk")
rt.impl.close_self_dialog(e,{},th)
chk("bubble closed", g.bubbles[e], nil)
chk("stage remains until confirm", g.stage_dialog ~= nil, true)
g.stage_dialog = nil
chk("stage confirmed", g.stage_dialog, nil)
local th2={sched=g.sched, ask=nil}
-- 直接创建 ask 数据，不执行协程
g.dialog_queue={}
local lock={stop=function() end}
local d={type="ask",prompt="name",th=th2,lock=lock}; g.dialog_queue[1]=d
chk("ask queue", g.dialog_queue[1].prompt, "name")
rt.impl.self_text_effect_text(e,{text="x"},th) -- 确保其它模块不串
g.translate_dialog = {text="你好", language="en", lock={stop=function() end}}
chk("translate dialog", g.translate_dialog.text, "你好")
rt.impl.confirm_translation(g)
chk("translate confirmed", g.translate_dialog, nil)
chk("translate_result original", rt.impl.translate_result(e,{text="你好"},th), "你好")
print("UI 界面测试通过")
