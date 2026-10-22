# domain 函数对照审计

官方 domain 表：47 个函数；knplayer 原语：158 个

- **MISSING**（官方有、我们没有）：17
- **STUB**（我们有但只是空壳）：1
- **BOTH**（都有，需比对语义）：29

## MISSING

### `math_single`
```js
{return v[t.OP](t)}
```

### `when`
```js
{return t.condition}
```

### `change_variable`
```js
{var r=t.valname,n=t.method||"increase",s=t.n,a=o.runtime_manager.get_variable(r,e,i);
"object"!==typeof a&&("increase"===n?o.runtime_manager.set_variable(r,a+s,e,i):o.runtime_manager.set_variable(r,a-s,e,i))}
```

### `random`
```js
{var r=t.a,n=t.b,s=o.runtime_manager.get_random_number();
return Math.floor(r+s*(n-r+1))}
```

### `destruct`
```js
{o.runtime_manager.destruct_entity(i)}
```

### `get_timer`
```js
{return o.runtime_manager.get_timer_elapsed_s()}
```

### `terminate`
```js
{o.runtime_manager.disable_interpreter_restarts_automatically(),o.runtime_manager.dispose_all()}
```

### `lists_get`
```js
{return o.runtime_manager.lists_get(t.VAR,e,i)}
```

### `lists_append`
```js
{var r=t.VAR;
r.push(t.VALUE),m(0,i,r)}
```

### `lists_delete`
```js
{var r=t.INDEX,n=t.VAR;
0!==r&&("last"===t.TYPE?n.pop():(r=r>0?r-1:r,n.splice(r,1)),m(0,i,n))}
```

### `lists_insert_value`
```js
{var r=t.INDEX,n=t.VAR;
0!==r&&(-1===r?n.push(t.VALUE):(r=r>0?r-1:r+1,n.splice(r,0,t.VALUE)),m(0,i,n))}
```

### `lists_replace`
```js
{var r=t.INDEX,n=t.VAR;
0!==r&&("last"===t.TYPE&&(r=n.length),r=r>0?r-1:r,n.splice(r,1,t.VALUE),m(0,i,n))}
```

### `lists_get_value`
```js
{var r=t.INDEX,n=t.VAR;
if("last"===t.TYPE&&(r=n.length),0!==r){var s=n[r=r>0?r-1:n.length+r];
if(void 0==s&&0==p.get().legacy.lists_get_value_allow_return_undefined)throw u.user.lists_get_value_bad_index({list:n,index:r>0?r:-1,args:t});
return s}if(0==p.get().legacy.lists_get_value_allow_return_undefined)throw u.user.lists_get_value_bad_index({list:n,index:-1,args:t})}
```

### `lists_is_exist`
```js
{var r=t.VALUE.toString(),n=t.VAR;
return a(n,(function(e){return e==t.VALUE||e==r}))}
```

### `lists_index_of`
```js
{var r=t.VALUE,n=t.VAR.indexOf(r);
return"number"===typeof n?n+1:0}
```

### `lists_length`
```js
{return t.VAR.length}
```

### `lists_copy`
```js
{var n=r(t.VALUE),s=t.TARGET;
s.length=0,n=n||[];
for(var a=0;
a<n.length;
a++){var _=n[a];
s.push(_)}m(0,i,s)}
```

## STUB

### `text_implicit`  (aliases.lua)
- 我的：`function M.text_implicit(self, args, th)   -- 隐式转字符串（JS 的 String()）；数组用逗号连接   return V.js_str(args.text or args.value or args.A) end  -- 当前帧数（官方 get_cur_frames） function M.get_cur_frames(self, args, t`
- 官方：
```js
{var r=t.TEXT;
return""===r?"":r==Number(r)?Number(r):r}
```

## BOTH（需人工比对语义）

### `text_indexOf`  (aliases.lua)
- 我的：`function M.text_indexOf(self, args, th)   local a = V.str(args.text or args.A or args.string or "")   local b = V.str(args.text2 or args.B or args.sub or "")   local i = string.find(a, b, 1, true)   r`
- 官方：
```js
{return"FIRST"===t.END?t.VALUE.indexOf(t.FIND)+1:"LAST"===t.END?t.VALUE.lastIndexOf(t.FIND)+1:void 0}
```

### `text_append`  (aliases.lua)
- 我的：`function M.text_append(self, args, th)   return V.str(args.text or args.A or "") .. V.str(args.text2 or args.B or "") end  function M.text_implicit(self, args, th)   -- 隐式转字符串（JS 的 String()）；数组用逗号连接  `
- 官方：
```js
{o.runtime_manager.set_variable(t.VAR,o.runtime_manager.get_variable(t.VAR,e,i)+t.TEXT,e,i)}
```

### `text_join`  (op_sensing.lua)
- 我的：`function M.text_join(self, args)   return join_any(args) end  -- 官方 text_split：先 toString，split 后**把数字片段转成数值**（"0"→0，"a"→"a"） function M.text_split(self, args)   local text = args.TEXT_TO_SPLIT   if t`
- 官方：
```js
{for(var r="",n=0;
;
){var s=t["ADD"+n];
if(void 0===s)break;
r+=""+s,n++}return r}
```

### `text_length`  (op_sensing.lua)
- 我的：`function M.text_length(self, args)   return #V.str(args.text or args.A or args.a) end  function M.convert_type(self, args)   local t = tostring(args.type or "string")   local v = args.text or args.val`
- 官方：
```js
{return isNaN(t.VALUE)?t.VALUE.length:t.VALUE.toString().length}
```

### `text_select`  (op_sensing.lua)
- 我的：`function M.text_select(self, args)   local text = V.str(args.text or args.A or args.a)   local n = math.floor(V.num(args.index or args.B or args.b or 1))   if n < 1 or n > #text then return "" end   r`
- 官方：
```js
{var r=isNaN(t.string)?t.string:t.string.toString(),n=t.char_start_index,s=t.char_end_index-1;
return n<=s?r.substring(n-1,s+1):r.substring(s,n).split("").reverse().join("")}
```

### `text_contain`  (op_sensing.lua)
- 我的：`function M.text_contain(self, args)   local text = V.str(args.text or args.A or args.a)   local sub = V.str(args.substring or args.B or args.b)   return text:find(sub, 1, true) ~= nil end  function M.`
- 官方：
```js
{var r=String(t.TEXT1),n=String(t.TEXT2);
return-1!==r.indexOf(n)}
```

### `logic_operation`  (op_sensing.lua)
- 我的：`function M.logic_operation(self, args)   local t = tostring(args.type or args.operator or "and")   local a, b = V.bool(args.A or args.a), V.bool(args.B or args.b)   if t == "or" or t == "||" then retu`
- 官方：
```js
{return f[t.OP](t)}
```

### `logic_negate`  (op_sensing.lua)
- 我的：`function M.logic_negate(self, args)   local v = args.BOOL   if v == nil then v = args.OPERAND end   if v == nil then v = args.logic end   if v == nil then v = args.value end   return not V.bool(v) end`
- 官方：
```js
{return!t.BOOL}
```

### `logic_boolean`  (op_sensing.lua)
- 我的：`function M.logic_boolean(self, args)   local v = args.BOOL   if v == nil then v = args.value end   if type(v) == "boolean" then return v end   local s = tostring(v):upper()   return s == "TRUE" or s =`
- 官方：
```js
{return f[t.BOOL]}
```

### `logic_compare`  (op_sensing.lua)
- 我的：`function M.logic_compare(self, args)   local op = tostring(args.OP or args.op or "EQ")   local a, b = args.A, b0   if a == nil then a = args.a end   b = args.B   if b == nil then b = args.b end   if o`
- 官方：
```js
{return f[t.OP](t)}
```

### `math_arithmetic`  (op_sensing.lua)
- 我的：`function M.math_arithmetic(self, args)   local f = ARITH[tostring(args.type or args.operator or args.OP or "add")]   if not f then return 0 end   local a = args.A   if a == nil then a = args.a end   l`
- 官方：
```js
{return v[t.OP](t)}
```

### `math_number_property`  (op_sensing.lua)
- 我的：`function M.math_number_property(self, args)   local n = V.num(args.num or args.NUMBER)   local t = tostring(args.type or "even")   if t == "even" then return n % 2 == 0 end   if t == "odd" then return`
- 官方：
```js
{return v[t.PROPERTY](t)}
```

### `divisible_by`  (op_sensing.lua)
- 我的：`function M.divisible_by(self, args)   local a, b = V.num(args.A or args.a), V.num(args.B or args.b)   if b == 0 then return false end   return a % b == 0 end  function M.math_number_property(self, arg`
- 官方：
```js
{return v.DIVISIBLE_BY(t)}
```

### `math_modulo`  (op_sensing.lua)
- 我的：`function M.math_modulo(self, args)   local a, b = V.num(args.A or args.a), V.num(args.B or args.b)   if b == 0 then return 0 end   return a % b end  function M.divisible_by(self, args)   local a, b = `
- 官方：
```js
{return t.DIVIDEND%t.DIVISOR}
```

### `math_trig`  (op_sensing.lua)
- 我的：`function M.math_trig(self, args)   local key = tostring(args.type or args.OP or "sin"):lower()   local f = TRIG[key] or TRIG.sin   return f(V.num(args.num or args.value)) end  -- 官方 math_single/math_f`
- 官方：
```js
{return v[t.OP](t)}
```

### `math_round`  (op_sensing.lua)
- 我的：`function M.math_round(self, args)   local n = V.num(args.num or args.value)   local t = tostring(args.type or "round")   if t == "round_up" then return math.ceil(n) end   if t == "round_down" then ret`
- 官方：
```js
{return v[t.OP](t)}
```

### `get_time`  (op_sensing.lua)
- 我的：`function M.get_time(self, args, th)   return os.time() end  function M.get_stage_info(self, args, th)   local g = game(th)   if tostring(args.type or "width") == "height" then return g.stage_h end   r`
- 官方：
```js
{return h[t.op](t)}
```

### `get_cur_frames`  (aliases.lua)
- 我的：`function M.get_cur_frames(self, args, th)   local g = th and th.sched and th.sched.game   return g and g.frame or 0 end  function M.multiline_text(self, args, th)   return V.str(args.text or args.TEXT`
- 官方：
```js
{return o.runtime_manager.get_elapsed_frames()}
```

### `variables_get`  (data.lua)
- 我的：`function M.variables_get(self, args, th)   return game(th):get_var(args.variable or args.valname, self, th) end M.get_variable = M.variables_get  function M.change_variables(self, args, th)   local g `
- 官方：
```js
{return o.runtime_manager.get_variable(t.VAR,e,i)}
```

### `variables_set`  (data.lua)
- 我的：`function M.variables_set(self, args, th)   local key = check_key(args.variable or args.valname, args, th)   if key == nil then return end   game(th):set_var(key, args.value, self, th) end M.set_variab`
- 官方：
```js
{o.runtime_manager.set_variable(t.VAR,t.VALUE,e,i)}
```

### `self_broadcast`  (control.lua)
- 我的：`function M.self_broadcast(self, args, th)   th.sched:broadcast(args.message, nil, self) end  -- 发送广播并携带内容 function M.self_broadcast_with_param(self, args, th)   th.sched:broadcast(args.message, args.p`
- 官方：
```js
{var r=t.message;
o.runtime_manager.broadcaster_sending_message(e,r,!1)}
```

### `self_broadcast_and_wait`  (control.lua)
- 我的：`function M.self_broadcast_and_wait(self, args, th)   local started = th.sched:broadcast(args.message, nil, self)   th:join(started) end  -- 克隆 / 删除本克隆体 function M.mirror(self, args, th)   local target`
- 官方：
```js
{var r=t.message;
o.runtime_manager.broadcaster_sending_message(e,r,!0)}
```

### `wait`  (control.lua)
- 我的：`function M.wait(self, args, th)   local t = V.num(args.time)   if t < 0 then t = 0 end   th:block(t * 1000) end  -- 等待直到（编译期通常内联成 while not cond do th:iter_n() end；这是闭包版） function M.wait_until(self, a`
- 官方：
```js
{var r,n=p.get().nan_to_zero_conversion_blocks,s=t.time;
(null===(r=n)||void 0===r?void 0:r.includes("wait"))&&(s="string"===typeof t.time||isNaN(t.time)?0:t.time),o.runtime_manager.thread_wait(i,e,1e3*s)}
```

### `reset_timer`  (op_sensing.lua)
- 我的：`M.reset_timer = function(self, args, th) game(th).timer = 0 end  function M.get_time(self, args, th)   return os.time() end  function M.get_stage_info(self, args, th)   local g = game(th)   if tostrin`
- 官方：
```js
{o.runtime_manager.reset_timer()}
```

### `restart`  (control.lua)
- 我的：`function M.restart(self, args, th)   error(SIG.RESTART, 0) end  -- 退出循环：置位后由最内层循环的 iter_n/iter_w/iter_d 消费 -- 注意：块类型就叫 `break`（Lua 关键字）→ 必须用下标写法定义，这也是 rt.f["break"] 的由来 M["break"] = function(self, arg`
- 官方：
```js
{o.runtime_manager.restart()}
```

### `stop`  (control.lua)
- 我的：`function M.stop(self, args, th)   local scope = tostring(args.scope or "1")   if scope == "0" then     error(SIG.STOP_ALL, 0)   elseif scope == "2" then     error(SIG.STOP_OTHER, 0)   elseif scope == `
- 官方：
```js
{var r=parseInt(t.scope);
0===r?o.runtime_manager.dispose_all():1===r?o.runtime_manager.dispose_block_group(e):2===r?o.runtime_manager.dispose_other_block_groups_of_entity(i,e):3===r&&o.runtime_manager.dispose_block_groups_of_other_entities(i)}
```

### `text_split`  (op_sensing.lua)
- 我的：`function M.text_split(self, args)   local text = args.TEXT_TO_SPLIT   if text == nil then text = args.text end   text = V.str(text)   local sep = V.str(args.SPLIT_TEXT or args.sep)   local raw = {}   `
- 官方：
```js
{var r=t.TEXT_TO_SPLIT;
return"number"===typeof r&&(r=r.toString()),(r.split(t.SPLIT_TEXT)||[]).map((function(t){var e=t.indexOf(" ")<0&&""!==t?_(t):t;
return s(e)?t:e}))}
```

### `multiline_text`  (aliases.lua)
- 我的：`function M.multiline_text(self, args, th)   return V.str(args.text or args.TEXT or args.value or "") end  return M `
- 官方：
```js
{return t.TEXT}
```

### `default_value`  (op_sensing.lua)
- 我的：`function M.default_value(self, args)   return args.VALUE or args.value or 0 end  ---------------------------------------------------------------- 运算 -- 官方四则运算就是 JS 原生：ADD: t.A + t.B（字符串会拼接）、DIVIDE: t.`
- 官方：
```js
{var r=t.TEXT,n=Number(r);
return s(n)?r:n}
```
