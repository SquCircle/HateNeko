"""代码生成（Python 版）：作品 JSON -> Lua 源码。

输出与旧 Lua 编译器逐字节等价（除 assets 扩展名解析修正：先去掉 ?query 再取扩展名）。
约定：f[<块类型>](self, args, th) / rt.on(owner, hat, args, body)
"""
import math
import re

from . import spec as Spec
from . import support

class CompileError(Exception):
    """Raised when the work violates the official block-placement rules."""

# ---------------------------------------------------------------- Lua 字面量工具

def lua_tostring(v):
    """模拟 Lua 的 tostring（数字：%.14g）。"""
    if isinstance(v, bool):
        return "true" if v else "false"
    if isinstance(v, (int, float)):
        if isinstance(v, float) and math.isnan(v):
            return "nan"
        if isinstance(v, float) and math.isinf(v):
            return "inf" if v > 0 else "-inf"
        return "%.14g" % float(v)
    if v is None:
        return "nil"
    return str(v)


def tonumber(v):
    """模拟 Lua 的 tonumber；失败返回 None。"""
    if isinstance(v, bool) or v is None:
        return None
    if isinstance(v, (int, float)):
        return float(v)
    if not isinstance(v, str):
        return None
    s = v.strip()
    if not s:
        return None
    try:
        if s.lower().startswith(("0x", "-0x", "+0x")):
            return float(int(s, 16))
        return float(s)
    except ValueError:
        return None


def q(s):
    """模拟 Lua 的 %q。"""
    out = ['"']
    for ch in str(s):
        if ch == '"':
            out.append('\\"')
        elif ch == '\\':
            out.append('\\\\')
        elif ch == '\n':
            out.append('\\\n')
        elif ch == '\r':
            out.append('\\r')
        elif ch == '\0':
            out.append('\\0')
        else:
            out.append(ch)
    out.append('"')
    return ''.join(out)


def truthy(v):
    """Lua 真值（只有 nil / false 为假）。"""
    return v is not None and v is not False


def ident_ok(k):
    return (isinstance(k, str) and re.match(r'^[A-Za-z_][A-Za-z0-9_]*$', k) is not None
            and not Spec.KEYWORDS.get(k))


def table_str(entries):
    parts = []
    for k in sorted(entries.keys(), key=lambda x: str(x)):
        key = k if ident_ok(k) else ("[" + q(k) + "]")
        parts.append(str(key) + " = " + str(entries[k]))
    return "{ " + ", ".join(parts) + " }"


def num_literal(v):
    low = lua_tostring("" if v is None else v).lower()
    if low in ("nan", "inf", "+inf", "infinity", "-inf", "-infinity"):
        return q(lua_tostring(v))
    n = tonumber(v)
    if n is None:
        return "0"
    if math.isnan(n):
        return "(0/0)"
    return lua_tostring(n)


def _first_field(fields):
    """等价于 Lua 里 pairs 取第一个（这里用排序保证确定性）；优先 TEXT/NUM。"""
    if not isinstance(fields, dict) or not fields:
        return None, None
    if "NUM" in fields:
        return "NUM", fields["NUM"]
    if "TEXT" in fields:
        return "TEXT", fields["TEXT"]
    k = sorted(fields.keys())[0]
    return k, fields[k]


def literal_from(node):
    t = node.get("type")
    f = node.get("fields") or {}
    if Spec.LITERAL_NUMERIC.get(t):
        if f.get("NUM") is not None:
            return num_literal(f["NUM"])
        txt = f.get("TEXT")
        if txt is None:
            txt = f.get("message") or f.get("NAME") or f.get("name")
        if txt is None:
            return "0"
        low = lua_tostring(txt).lower()
        if low in ("nan", "inf", "infinity", "-inf", "-infinity"):
            return num_literal(txt)
        if tonumber(txt) is not None:
            return num_literal(txt)
        return q(lua_tostring(txt))
    if Spec.LITERAL_STRING.get(t):
        if f.get("TEXT") is None and (f.get("message") or f.get("NAME") or f.get("name")):
            return q(lua_tostring(f.get("message") or f.get("NAME") or f.get("name")))
        v = f.get("TEXT")
        if v is None:
            v = f.get("message")
        if v is None:
            v = f.get("list")
        if v is None:
            v = f.get("style_id")
        if v is None:
            v = f.get("audio_id")
        if v is None:
            v = f.get("variable")
        return q(lua_tostring(v) if v is not None else "")
    if t == "logic_empty":
        return "false"
    if t == "logic_boolean":
        s = lua_tostring(f.get("BOOL") or "").upper()
        return "true" if s in ("TRUE", "1") else "false"
    key, val = _first_field(f)
    if val is None:
        sh = node.get("shadows") or {}
        if sh:
            k = sorted(sh.keys())[0]
            key, val = k, sh[k]
    if val is None:
        return "nil"
    n = tonumber(val)
    if n is not None and not isinstance(val, str):
        return lua_tostring(n)
    if isinstance(val, str) and n is not None and re.match(r'^-?\d+\.?\d*$', val) \
            and key in ("NUM", "value"):
        return lua_tostring(n)
    return q(lua_tostring(val))


def _param_id(node):
    m = node.get("mutation")
    if isinstance(m, str):
        mm = re.search(r'\bid="([^"]+)"', m)
        if mm: return mm.group(1)
    f = node.get("fields") or {}
    return f.get("param_id") or f.get("PARAM_ID")


STATIC_READERS = {k: True for k in (
    "self_listen_param", "self_listen_value", "traverse_number_param",
    "traverse_number_value", "script_variables_param", "script_variables_value",
    "procedures_2_parameter", "procedures_2_stable_parameter")}


def input_code(node, name, ctx, arg=None):
    inputs = node.get("inputs")
    if inputs and inputs.get(name) is not None:
        return expr(inputs[name], ctx)
    fields = node.get("fields")
    if fields and fields.get(name) is not None:
        v = fields[name]
        n = tonumber(v)
        if n is not None and name in ("NUM", "value", "times", "x", "y", "scale",
                                      "degrees", "A", "B", "n", "time"):
            return lua_tostring(n)
        return q(lua_tostring(v))
    dv = (arg or {}).get("defaultValue")
    if dv and dv.get("fields"):
        return literal_from(dv)
    return None


def nat_key(k):
    """自然序键：PARAMS2 < PARAMS10。"""
    return [int(t) if t.isdigit() else t for t in re.split(r'(\d+)', str(k))]


def parse_script_var(v):
    if not isinstance(v, str):
        return None
    if "NEKO_SCRIPT_VARIABLE_TYPE" not in v:
        return None
    m = re.search(r'"name"\s*:\s*"([^"]+)"', v)
    return m.group(1) if m else None


def collect_args(node, ctx):
    entries = {}
    seen = {}
    sp = Spec.get(node.get("type"))

    if node.get("type") == "script_variables":
        # 按自然序遍历（Lua 的 pairs 是哈希序 → 结果不可复现，这里改成确定性）
        ins = node.get("inputs") or {}
        _names = []
        for k in sorted(ins.keys(), key=nat_key):
            v = ins[k]
            if isinstance(v, dict) and STATIC_READERS.get(v.get("type")):
                fv = v.get("fields") or {}
                nm = fv.get("TEXT") or fv.get("param_name") or fv.get("NAME")
                if nm is not None:
                    _names.append(lua_tostring(nm))
                entries[k] = "nil"
            else:
                entries[k] = expr(v, ctx)
        for k, v in (node.get("fields") or {}).items():
            entries[k] = q(lua_tostring(v))
        # 「定义脚本变量」可能一次声明多个变量名 → 全部定义（官方语义）；
        # name 保留第一个，兼容旧运行时。
        if _names:
            entries["name"] = q(_names[0])
            if len(_names) > 1:
                entries["names"] = "{ " + ", ".join(q(n) for n in _names) + " }"
        return entries

    for a in ((sp or {}).get("args") or []):
        if a.get("name") and a.get("type") != "input_statement":
            seen[a["name"]] = True
            code = input_code(node, a["name"], ctx, a)
            if code is not None:
                entries[a["name"]] = code

    for k, v in (node.get("inputs") or {}).items():
        if not seen.get(k) and isinstance(v, dict):
            entries[k] = expr(v, ctx)

    for k, v in (node.get("fields") or {}).items():
        if not seen.get(k):
            sv = parse_script_var(v)
            if sv is not None:
                entries["script"] = q(sv)
                continue
            low = lua_tostring("" if v is None else v).lower()
            n = tonumber(v)
            is_nan = (n is not None and math.isnan(n)) or low == "nan"
            if n is not None and k not in ("variable", "NAME", "param_name") and not is_nan:
                entries[k] = lua_tostring(n)
            else:
                entries[k] = q(lua_tostring(v))
    return entries


def lua_ident_sanitize(name):
    """按字节模拟 Lua 的 gsub("%W","_")：非 ASCII 字节各替换成一个下划线。
    Lua 5.1 的标识符只能是 [A-Za-z_][A-Za-z0-9_]*，中文名必须清洗。"""
    out = []
    for b in str(name).encode("utf-8"):
        ch = chr(b)
        out.append(ch if (b < 128 and (ch.isalnum() or ch == "_")) else "_")
    return "".join(out)


def proc_local_name(pid):
    return "proc_" + lua_ident_sanitize(pid)


SKIP_PARAM = {"Label": True, "Icon": True}


def real_params(proc):
    out = []
    for p in (proc or {}).get("params") or []:
        if not SKIP_PARAM.get(p.get("type")):
            out.append(p)

    def scan(node):
        while isinstance(node, dict):
            if node.get("type") == "script_variables":
                _ins = node.get("inputs") or {}
                for k in sorted(_ins.keys(), key=nat_key):
                    v = _ins[k]
                    if isinstance(v, dict) and v.get("type") == "script_variables_param":
                        out.append({"id": v.get("id"), "type": "script_variables_param",
                                    "name": (v.get("fields") or {}).get("TEXT")})
            for v in (node.get("inputs") or {}).values():
                scan(v)
            for v in (node.get("statements") or {}).values():
                scan(v)
            node = node.get("next")

    for b in (proc or {}).get("nekoBlockJsonList") or []:
        scan(b)
    return out


def proc_call_code(node, ctx):
    f = node.get("fields") or {}
    pid = f.get("NAME") or f.get("proc_id")
    if not pid:
        ctx["report"]["warn"].append("过程调用块缺少 NAME（procedure id）")
        return "nil"
    proc = (ctx.get("procs") or {}).get(pid)
    args = [ctx["th_name"], ctx["self_name"]]
    if proc:
        for p in real_params(proc):
            code = input_code(node, p.get("id"), ctx, None)
            args.append(code if code is not None else "nil")
    else:
        for v in (node.get("inputs") or {}).values():
            if isinstance(v, dict):
                args.append(expr(v, ctx))
    if ctx.get("trampoline"):
        # th:call_proc(proc, self, params...)
        rest = args[1:]  # args[0] is th
        return ctx["th_name"] + ":call_proc(" + proc_local_name(pid) + ", " + ", ".join(rest) + ")"
    return proc_local_name(pid) + "(" + ", ".join(args) + ")"


_CONST_NUM = re.compile(r'^-?\d+(?:\.\d+)?(?:[eE][+-]?\d+)?$')

def _is_const_code(code):
    """参数值是否是纯字面量（可安全做成模块级常量表，避免每次调用分配）。"""
    c = str(code or "").strip()
    if c in ("true", "false", "nil", "(0/0)"):
        return True
    if _CONST_NUM.match(c):
        return True
    if len(c) >= 2 and c[0] == '"' and c[-1] == '"':
        return True
    if c.startswith("{") and c.endswith("}"):
        # 嵌套常量表（例如 names = { "a", "b" }）；只要不含运行期表达式即可
        return not any(x in c for x in ("f[", "th", "self", "proc_", "p_", "("))
    return False


def arg_code(args, ctx):
    """参数表代码：全常量时复用模块级常量表，否则每次构造。"""
    code = table_str(args) if args else "{}"
    if not args:
        return code
    for v in args.values():
        if not _is_const_code(v):
            return code
    pool = ctx.get("const_args")
    if pool is None:
        pool = {}
        ctx["const_args"] = pool
    name = pool.get(code)
    if name is None:
        name = "__CONST[%d]" % (len(pool) + 1)
        pool[code] = name
    return name


# ---------------------------------------------------------------- 表达式

def expr(node, ctx):
    if not isinstance(node, dict):
        return "nil"
    t = node.get("type")
    if t is None:
        return "nil"

    if Spec.is_literal(node):
        ctx["report"]["literals"][t] = ctx["report"]["literals"].get(t, 0) + 1
        return literal_from(node)

    if t in ("traverse_number_param", "traverse_number_value") and ctx.get("param_local"):
        return ctx["param_local"]

    if t in ("procedures_2_parameter", "procedures_2_stable_parameter"):
        f = node.get("fields") or {}
        nm = f.get("param_name") or f.get("NAME")
        # 重名参数（例如 now 的 scale 出现两次）必须按 mutation arg id 解析；
        # 只看 param_name 会被最后一个同名参数覆盖。
        pid = _param_id(node)
        localname = (ctx.get("proc_param_ids") or {}).get(pid) if pid else None
        if not localname and nm:
            localname = (ctx.get("proc_params") or {}).get(nm)
        if localname:
            return localname

    if t == "procedures_2_callreturn":
        return "(" + proc_call_code(node, ctx) + ")"

    args = collect_args(node, ctx)
    ctx["report"]["calls"][t] = ctx["report"]["calls"].get(t, 0) + 1
    if not Spec.has(t):
        ctx["report"]["unknown"][t] = ctx["report"]["unknown"].get(t, 0) + 1
    argcode = arg_code(args, ctx)
    return "f[%s](%s, %s, %s)" % (q(t), ctx["self_name"], argcode, ctx["th_name"])


# ---------------------------------------------------------------- 语句

def tick_call(ctx):
    if ctx.get("in_warp"):
        return ctx["th_name"] + ":iter_w()"
    if ctx.get("in_proc") or ctx.get("in_tell"):
        return ctx["th_name"] + ":iter_d()"
    return ctx["th_name"] + ":iter_n()"


def next_loop_id(ctx):
    n = (ctx.get("_loop_seq") or 0) + 1
    ctx["_loop_seq"] = n
    return n


def loop_ctx(ctx, kind, cleanup=None):
    inner = dict(ctx)
    inner["loop_depth"] = (ctx.get("loop_depth") or 0) + 1
    inner["loop_stack"] = list(ctx.get("loop_stack") or [])
    inner["loop_stack"].append({
        "kind": kind,
        "cleanup": list(cleanup or []),
        "warp_top": len(ctx.get("warp_stack") or []),
    })
    return inner


def break_cleanup(ctx, node):
    """Generate cleanup + native break for the nearest loop, or reject at compile time."""
    stack = ctx.get("loop_stack") or []
    if not stack:
        bid = (node or {}).get("id") or "?"
        raise CompileError("break outside loop (block %s)" % lua_tostring(bid))
    entry = stack[-1]
    lines = []
    # 退出 break 目标循环之后、但仍在本函数内的 warp。
    ws = ctx.get("warp_stack") or []
    for _ in range(len(ws) - (entry.get("warp_top") or 0)):
        lines.append(ctx["th_name"] + ":warp_exit()")
    lines.extend(entry.get("cleanup") or [])
    return lines

def ind(ctx, depth):
    return "  " * depth


def emit_body(out, node, ctx, depth):
    if not node:
        return False
    return stmt_chain(node, ctx, out, depth)


def stmt_chain(node, ctx, out, depth):
    cur = node
    while cur:
        nxt = cur.get("next")
        terminated = stmt(cur, ctx, out, depth)
        if terminated:
            return True
        cur = nxt
    return False


def emit_call_stmt(node, ctx, out, depth):
    t = node.get("type")
    args = collect_args(node, ctx)
    ctx["report"]["calls"][t] = ctx["report"]["calls"].get(t, 0) + 1
    if not Spec.has(t):
        ctx["report"]["unknown"][t] = ctx["report"]["unknown"].get(t, 0) + 1
    argcode = arg_code(args, ctx)
    out.append("%sf[%s](%s, %s, %s)" % (ind(ctx, depth), q(t), ctx["self_name"], argcode, ctx["th_name"]))


def stmt(node, ctx, out, depth):
    t = node.get("type")
    pad = ind(ctx, depth)
    stmts = node.get("statements") or {}

    if t == "warp":
        inner = dict(ctx)
        inner["in_warp"] = True
        inner["warp_depth"] = (ctx.get("warp_depth") or 0) + 1
        inner["warp_stack"] = list(ctx.get("warp_stack") or []) + ["warp"]
        out.append(pad + ctx["th_name"] + ":warp_enter()")
        terminated = emit_body(out, stmts.get("DO"), inner, depth)
        if not terminated:
            out.append(pad + ctx["th_name"] + ":warp_exit()")
        return False

    if t == "repeat_forever":
        inner = loop_ctx(ctx, "repeat_forever")
        out.append(pad + "while true do")
        terminated = emit_body(out, stmts.get("DO"), inner, depth + 1)
        if not terminated:
            out.append(pad + "  if " + tick_call(ctx) + " then break end")
        out.append(pad + "end")
        return False

    if t == "repeat_n_times":
        times = input_code(node, "times", ctx, None) or "0"
        n = next_loop_id(ctx)
        var = "_times_n%d" % n
        inner = loop_ctx(ctx, "repeat_n_times")
        out.append(pad + "do")
        out.append(pad + "  local " + var + " = " + times)
        out.append(pad + "  while true do")
        out.append(pad + "    if " + var + " <= 0 then break end")
        out.append(pad + "    " + var + " = " + var + " - 1")
        terminated = emit_body(out, stmts.get("DO"), inner, depth + 2)
        if not terminated:
            out.append(pad + "    if " + tick_call(ctx) + " then break end")
        out.append(pad + "  end")
        out.append(pad + "end")
        return False

    if t == "repeat_forever_until":
        cond = input_code(node, "condition", ctx, None) or "false"
        inner = loop_ctx(ctx, "repeat_forever_until")
        out.append(pad + "while true do")
        out.append(pad + "  if " + cond + " then break end")
        terminated = emit_body(out, stmts.get("DO"), inner, depth + 1)
        if not terminated:
            out.append(pad + "  if " + tick_call(ctx) + " then break end")
        out.append(pad + "end")
        return False

    if t == "wait_until":
        # 官方是 LOOP_BLOCK：条件真→Done，否则 Yield（crc_libs:1 byte 885132）。
        cond = input_code(node, "condition", ctx, None) or "false"
        inner = loop_ctx(ctx, "wait_until")
        out.append(pad + "while not V.bool(" + cond + ") do")
        out.append(pad + "  if " + ctx["th_name"] + ":iter_n() then break end")
        out.append(pad + "end")
        return False

    if t == "traverse_number":
        frm = input_code(node, "from", ctx, None) or "0"
        to = input_code(node, "to", ctx, None) or "0"
        by = input_code(node, "by", ctx, None) or "1"
        n = next_loop_id(ctx)
        inner = loop_ctx(ctx, "traverse_number",
            cleanup=[ctx["th_name"] + ":pop_param()"])
        pv = "_p_n%d" % n
        fv = "_from_n%d" % n
        tv = "_to_n%d" % n
        bv = "_by_n%d" % n
        iv = "_i_n%d" % n
        inner["param_local"] = pv
        out.append(pad + "do")
        out.append(pad + ("  local %s, %s = tonumber(%s), tonumber(%s)" % (fv, tv, frm, to)))
        out.append(pad + "  if %s ~= %s or %s ~= %s then" % (fv, fv, tv, tv))
        out.append(pad + "    -- NaN from/to: official warning; no iterations")
        out.append(pad + "  else")
        out.append(pad + "    if %s <= %s then %s = math.ceil(%s); if %s > %s then %s = %s + 1 end" %
            (fv, tv, fv, fv, fv, tv, fv, tv))
        out.append(pad + "    else %s = math.floor(%s); if %s < %s then %s = %s - 1 end end" %
            (fv, fv, fv, tv, fv, tv))
        out.append(pad + ("    local %s = %s" % (bv, by)))
        out.append(pad + "    if %s == nil then %s = 1 end" % (bv, bv))
        out.append(pad + "    %s = tonumber(%s)" % (bv, bv))
        out.append(pad + "    if %s == nil or %s ~= %s or %s <= 0 then %s = 0 else %s = math.abs(math.floor(%s + 0.5)) end" %
            (bv, bv, bv, bv, bv, bv, bv))
        out.append(pad + "    if %s > 0 then" % bv)
        out.append(pad + "      local %s = %s" % (pv, fv))
        out.append(pad + "      while (%s <= %s and %s <= %s) or (%s > %s and %s >= %s) do" %
            (fv, tv, pv, tv, fv, tv, pv, tv))
        out.append(pad + "        local %s = %s" % (iv, pv))
        out.append(pad + "        " + ctx["th_name"] + ":push_param(" + pv + ")")
        terminated = emit_body(out, stmts.get("DO"), inner, depth + 3)
        if not terminated:
            out.append(pad + "        " + ctx["th_name"] + ":pop_param()")
            out.append(pad + "        %s = %s + %s" % (pv, pv, bv))
            out.append(pad + "        if " + tick_call(ctx) + " then break end")
        out.append(pad + "      end")
        out.append(pad + "    end")
        out.append(pad + "  end")
        out.append(pad + "end")
        return False

    if t in ("controls_if", "controls_if_else"):
        i = 0
        first = True
        inputs = node.get("inputs") or {}
        while inputs.get("IF" + str(i)) is not None:
            cond = expr(inputs["IF" + str(i)], ctx)
            body = stmts.get("DO" + str(i))
            c = "V.bool(" + cond + ")"
            out.append(pad + (("if " + c + " then") if first else ("elseif " + c + " then")))
            emit_body(out, body, ctx, depth + 1)
            first = False
            i += 1
        else_body = stmts.get("ELSE")
        if not first:
            if else_body:
                out.append(pad + "else")
                emit_body(out, else_body, ctx, depth + 1)
            out.append(pad + "end")
        return False

    if t == "break":
        cleanup = break_cleanup(ctx, node)
        for line in cleanup:
            out.append(pad + line)
        out.append(pad + "break")
        return True

    if t == "procedures_2_return_value":
        v = input_code(node, "VALUE", ctx, None) or "nil"
        for _ in range(ctx.get("warp_depth") or 0):
            out.append(pad + ctx["th_name"] + ":warp_exit()")
        out.append(pad + "return " + v)
        return True

    if t == "procedures_2_callnoreturn":
        out.append(pad + proc_call_code(node, ctx))
        return False

    if t in ("tell", "sync_tell"):
        sprite = input_code(node, "sprite", ctx, None) or q("--self")
        inner = dict(ctx)
        inner["self_name"] = "s2"
        inner["th_name"] = "t2"
        inner["in_tell"] = True
        # tell 的闭包仍在外层过程体内，过程参数必须可引用；清空会把参数读成
        # 未实现原语 procedures_2_parameter。
        inner["proc_params"] = ctx.get("proc_params")
        inner["proc_param_ids"] = ctx.get("proc_param_ids")
        inner["loop_stack"] = {}
        inner["loop_depth"] = 0
        inner["warp_stack"] = {}
        inner["in_warp"] = False
        body = []
        emit_body(body, stmts.get("DO"), inner, depth + 2)
        out.append("%sf[%s](%s, { sprite = %s, DO = function(t2, s2)" % (pad, q(t), ctx["self_name"], sprite))
        out.extend(body)
        out.append(pad + "end }, " + ctx["th_name"] + ")")
        return False

    if Spec.is_event(t):
        ctx["report"]["warn"].append("hat 块出现在语句链里: " + lua_tostring(t))
        return False

    emit_call_stmt(node, ctx, out, depth)
    return False


# ---------------------------------------------------------------- hat

def hat_args(node, ctx):
    entries = {}
    sp = Spec.get(node.get("type"))
    for a in ((sp or {}).get("args") or []):
        if a.get("name") and a.get("type") != "input_statement":
            v = (node.get("inputs") or {}).get(a["name"])
            if isinstance(v, dict):
                if STATIC_READERS.get(v.get("type")):
                    fv = v.get("fields") or {}
                    nm = fv.get("TEXT") or fv.get("param_name") or fv.get("NAME")
                    if nm is not None:
                        entries[a["name"]] = q(lua_tostring(nm))
                elif Spec.is_literal(v):
                    entries[a["name"]] = literal_from(v)
            elif (node.get("fields") or {}).get(a["name"]) is not None:
                entries[a["name"]] = q(lua_tostring(node["fields"][a["name"]]))
    return entries


def hat(node, ctx, owner_expr, out):
    t = node.get("type")
    ctx["report"]["hats"][t] = ctx["report"]["hats"].get(t, 0) + 1

    args = hat_args(node, ctx)
    if t == "when":
        cond = input_code(node, "condition", ctx, None) or "false"
        args["cond"] = "function(th, self) return " + cond + " end"
    argcode = table_str(args) if args else "{}"

    body = []
    stmts = node.get("statements") or {}
    body_slot = stmts.get("DO") or stmts.get("STACK") or node.get("next")
    if body_slot:
        stmt_chain(body_slot, ctx, body, 3)

    out.append("  rt.on(%s, %s, %s, function(th, self)" % (owner_expr, q(t), argcode))
    out.extend(body)
    out.append("  end)")


# ---------------------------------------------------------------- 过程

def procedure(proc, ctx, out):
    name = proc_local_name(proc.get("id"))
    params = proc.get("params") or []
    param_names = ["th", "self"]
    mapping = {}
    mapping_ids = {}
    _used = {}
    for i, p in enumerate(params, 1):
        if p.get("type") not in ("Label", "Icon"):
            lname = "p_" + lua_ident_sanitize(p.get("name") or ("arg" + str(i)))
            # ★ 中文参数名按字节清洗后**会撞车**（每个非 ASCII 字节都变 `_`），
            #   例如三个中文参数全部变成 p_______；Lua 里同名形参后者遮蔽前者，
            #   于是表达式里读到的都是最后一个参数的错值（now 的动画秒数被算成 0 → 闪屏）。
            #   这里对同名做去重：第二个起加 _2/_3…，mapping 仍按**原名**索引，引用处不受影响。
            if lname in _used:
                _used[lname] += 1
                lname = lname + "_" + str(_used[lname])
            else:
                _used[lname] = 1
            param_names.append(lname)
            if p.get("name"):
                mapping[p["name"]] = lname
            if p.get("id"):
                mapping_ids[p["id"]] = lname
    inner = dict(ctx)
    inner["in_proc"] = True
    inner["in_warp"] = False
    inner["proc_params"] = mapping
    inner["proc_param_ids"] = mapping_ids
    inner["loop_stack"] = {}
    inner["loop_depth"] = 0
    inner["warp_stack"] = {}

    body = []
    defn = None
    for b in proc.get("nekoBlockJsonList") or []:
        if b.get("type") == "procedures_2_defnoreturn":
            defn = b
    stmts = (defn or {}).get("statements") or {}
    if stmts.get("STACK") or stmts.get("DO"):
        stmt_chain(stmts.get("STACK") or stmts.get("DO"), inner, body, 1)

    ctx["report"]["procedures"] = (ctx["report"].get("procedures") or 0) + 1
    out.append("%s = function(%s)" % (name, ", ".join(param_names)))
    out.append("  -- 过程「%s」 id=%s" % (lua_tostring(proc.get("name")), lua_tostring(proc.get("id"))))
    out.extend(body)
    out.append("end")
    out.append("")


# ---------------------------------------------------------------- 作品

def _ext_of(url, default):
    """落地扩展名。

    1) 先去查询串（?imageView 等）
    2) **SVG 一律落成 .png**：编译期已按内在尺寸栅格化，运行时只认 .png
       （曾经这里返回 svg → 运行时找 <id>.svg → 素材"全炸"）
    """
    base = str(url or "").split("?")[0].split("#")[0]
    m = re.search(r'\.(\w+)$', base)
    ext = (m.group(1) if m else default).lower()
    if ext == "svg":
        return "png"
    return ext


def _leaf_direct_calls(src):
    """把"自身不调用任何过程"的叶子过程从 trampoline 改为直调。

    trampoline 对每次过程调用都 coroutine.create/yield/resume；k3t V2 的模型访问器
    单帧被调用 3 万次，几乎是纯 list 索引。叶子过程不含 th:call_proc，递归不可能
    发生，直调不改变语义，却省掉每次调用的协程与参数表。

    返回 (新源码, 叶子过程数)。非 trampoline 模式已经是直调，无需处理。
    """
    import re as _re
    lines = src.split("\n")
    leafs = set()
    i = 0
    while i < len(lines):
        m = _re.match(r'^(proc_[0-9A-Za-z_]+) = function\(', lines[i])
        if not m:
            i += 1
            continue
        name = m.group(1)
        j = i + 1
        while j < len(lines) and lines[j] != "end":
            j += 1
        body = "\n".join(lines[i + 1:j])
        if "th:call_proc(" not in body:
            leafs.add(name)
        i = j + 1
    if not leafs:
        return src, 0
    for name in leafs:
        src = src.replace("th:call_proc(%s, " % name, "%s(th, " % name)
    return src, len(leafs)


def compile_work(work, opts=None):
    opts = opts or {}
    report = {"calls": {}, "literals": {}, "hats": {}, "unknown": {}, "warn": [], "skipped": {}}
    procs = (work.get("procedures") or {}).get("proceduresDict") or {}

    out = []
    out.append("-- 由 knplayer/kntl 从作品自动生成，请勿手改")
    out.append("-- 作品：%s   version=%s" % (lua_tostring(work.get("projectName")), lua_tostring(work.get("version"))))
    out.append("local M = {}")
    out.append('local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）')
    out.append("local f -- 运行期原语表，register 里赋值，过程体共用")
    out.append("")

    ctx0 = {"report": report, "self_name": "self", "th_name": "th", "procs": procs,
            "trampoline": bool(opts.get("trampoline")), "const_args": {}}

    # 过程
    proc_ids = sorted(procs.keys())
    if proc_ids:
        out.append("-- ===== 自定义积木（过程）=====")
        out.append("local " + ", ".join(proc_local_name(i) for i in proc_ids))
        out.append("")
        for pid in proc_ids:
            procedure(procs[pid], ctx0, out)

    # 计时器积木是否存在：没有这些块时，计时器必须默认隐藏且不推进。
    timer_types = {"set_timer_state", "show_hide_timer", "timer", "get_timer", "reset_timer"}
    def _has_timer(node):
        if isinstance(node, dict):
            if node.get("type") in timer_types: return True
            for v in node.values():
                if _has_timer(v): return True
        elif isinstance(node, list):
            for v in node:
                if _has_timer(v): return True
        return False
    uses_timer = False
    for _a in ((work.get("actors") or {}).get("actorsDict") or {}).values():
        if _has_timer(_a.get("nekoBlockJsonList") or []):
            uses_timer = True; break
    if not uses_timer:
        for _s in ((work.get("scenes") or {}).get("scenesDict") or {}).values():
            if _has_timer(_s.get("nekoBlockJsonList") or []):
                uses_timer = True; break
    hidden_timer_types = {"get_timer", "reset_timer"}
    def _has_hidden_timer(node):
        if isinstance(node, dict):
            if node.get("type") in hidden_timer_types: return True
            for v in node.values():
                if _has_hidden_timer(v): return True
        elif isinstance(node, list):
            for v in node:
                if _has_hidden_timer(v): return True
        return False
    hidden_timer_default = False
    for _a in ((work.get("actors") or {}).get("actorsDict") or {}).values():
        if _has_hidden_timer(_a.get("nekoBlockJsonList") or []):
            hidden_timer_default = True; break
    if not hidden_timer_default:
        for _s in ((work.get("scenes") or {}).get("scenesDict") or {}).values():
            if _has_hidden_timer(_s.get("nekoBlockJsonList") or []):
                hidden_timer_default = True; break

    # 元数据
    out.append("-- ===== 作品元数据 =====")
    stage = work.get("stageSize") or {}
    out.append("M.stage_w, M.stage_h = %d, %d" % (
        int(tonumber(stage.get("width")) or 562), int(tonumber(stage.get("height")) or 900)))
    tp = work.get("timerPosition") or {}
    try:
        tx = int(tonumber(tp.get("x")) or 720)
        ty = int(tonumber(tp.get("y")) or 12)
    except Exception:
        tx, ty = 720, 12
    out.append("M.timer_pos = { x = %d, y = %d }" % (tx, ty))
    out.append("M.proc_trampoline = %s" % ("true" if opts.get("trampoline") else "false"))
    out.append("M.uses_timer = %s" % ("true" if uses_timer else "false"))
    out.append("M.timer_hidden_default = %s" % ("true" if hidden_timer_default else "false"))

    # 说明：列表目前仍和变量一起写进 M.vars（值为字符串形式），
    # 拆成 M.lists 的改造已验证会让 now 的某个列表循环死锁，暂缓（见 docs/args_audit.md 附注）。
    var_lines, list_lines = [], []
    actor_names = {}
    for aid, a in ((work.get("actors") or {}).get("actorsDict") or {}).items():
        actor_names[aid] = a.get("name") or aid
    vdict = (work.get("variables") or {}).get("variablesDict") or {}
    # JSON 插入顺序：列表查看页的左右切换必须按 bcmkn 中列表顺序，不按 id/位置排序。
    json_order = {vid: i for i, vid in enumerate(vdict.keys())}
    for vid in sorted(vdict.keys()):
        v = vdict[vid]
        raw = v.get("value")
        typ = str(v.get("type") or "")
        name = lua_tostring(v.get("name") or vid)
        if isinstance(raw, list):
            # 列表（array 类型）**就是变量的值**：直接输出 Lua 表。
            # 之前输出成字符串 "[200, 135, …]" → 列表操作拿到非表 → 一律当空表，
            # 作品读 列表_bpm 永远为空（变量_bpm 因此恒 0 → 60/0 → inf）。
            vals = []
            for it in raw:
                n = tonumber(it)
                vals.append(lua_tostring(n) if n is not None else q(lua_tostring(it)))
            value = "{ " + ", ".join(vals) + " }"
        else:
            num = tonumber(raw)
            value = lua_tostring(num) if num is not None else q(lua_tostring(0 if raw is None else raw))
        pos = v.get("position") or {}
        try:
            px = int(tonumber(pos.get("x")) or 0)
            py = int(tonumber(pos.get("y")) or 0)
        except Exception:
            px, py = 0, 0
        meta = {
            "id": q(vid),
            "name": q(name),
            "value": value,
            "type": q(str(v.get("type") or "variable")),
            "style": q(str(v.get("style") or "default")),
            "scale": lua_tostring(tonumber(v.get("scale")) or 1),
            "visible": "true" if v.get("visible", True) else "false",
            "position": "{ x = %d, y = %d }" % (px, py),
            "is_global": "true" if v.get("isGlobal", False) else "false",
            "current_entity_id": q(str(v.get("currentEntityId") or "")),
            "entity_name": q(str(actor_names.get(v.get("currentEntityId")) or "")),
            "cv_id": q(str(v.get("cvId") or "")),
            "order": str(json_order.get(vid, 0)),
        }
        var_lines.append(table_str(meta))
    out.append("M.vars = { " + ", ".join(var_lines) + " }")

    # 屏幕
    screen_lines = []
    sdict = (work.get("scenes") or {}).get("scenesDict") or {}
    sids = list(sdict.keys())
    for sid in sids:
        s = sdict[sid]
        styles = [q(st) for st in (s.get("styles") or [])]
        style_index = 1
        for i, st in enumerate(s.get("styles") or [], 1):
            if st == s.get("currentStyleId"):
                style_index = i
        screen_lines.append(table_str({
            "id": q(sid), "name": q(lua_tostring(s.get("name") or "")),
            "screenName": q(lua_tostring(s.get("screenName") or "")),
            "style_index": str(style_index),
            "styles": "{ " + ", ".join(styles) + " }",
            # 背景 screen 也可 visible=false（paint 的沼泽背景就是隐藏，露出官方 #FFFFFF 底）
            "visible": "true" if s.get("visible") is not False else "false",
        }))
    out.append("M.screens = { " + ", ".join(screen_lines) + " }")

    # 初始屏幕 = 场景排序第一屏（官方 sceneSortList[0]）
    scene_sort = (work.get("scenes") or {}).get("sortList") or []
    first_scene = scene_sort[0] if scene_sort else ((work.get("scenes") or {}).get("currentSceneId") or "")
    out.append("M.cur_scene = %s" % q(lua_tostring(first_scene)))

    actor_scenes, actor_order, scene_total = {}, {}, 0
    for sid2, sdef in (work.get("scenes") or {}).get("scenesDict", {}).items():
        scene_total += 1
        ids = sdef.get("actorIds") or []
        # 真机确认 actorIds 是自上而下；官方 actor children 是自下而上
        # （get_actor_ids byte 1141200 / set_z_index byte 1162523 / peak byte 1609639）。
        # 因此把索引反置成 order：第一个 actor 最大，最后一个最小。
        n = len(ids)
        for idx2, aid2 in enumerate(ids, 1):
            lst = actor_scenes.setdefault(aid2, [])
            lst.append(sid2)
            z = n - idx2 + 1
            if aid2 not in actor_order or z < actor_order[aid2]:
                actor_order[aid2] = z

    actor_lines = []
    adict = (work.get("actors") or {}).get("actorsDict") or {}
    aids = list(adict.keys())
    for aid in aids:
        a = adict[aid]
        styles = [q(st) for st in (a.get("styles") or [])]
        style_index = 1
        for i, st in enumerate(a.get("styles") or [], 1):
            if st == a.get("currentStyleId"):
                style_index = i
        pos = a.get("position") or {}
        lst = actor_scenes.get(aid) or []
        actor_lines.append(table_str({
            "id": q(aid),
            "name": q(lua_tostring(a.get("name") or "")),
            "x": lua_tostring(tonumber(pos.get("x")) or 0),
            "y": lua_tostring(tonumber(pos.get("y")) or 0),
            "rotation": lua_tostring(tonumber(a.get("rotation")) or 0),
            # 大小只输出两轴倍数（1.0 = 原尺寸）；运行时不再有 scale 字段
            "scale_x": lua_tostring((tonumber(a.get("scale")) or 100) / 100),
            "scale_y": lua_tostring((tonumber(a.get("scale")) or 100) / 100),
            # KN 数据里 visible 缺省 = 隐藏（曾经缺省 true → monitoring 这类"初始隐藏"的角色一开始就露出来）
            "visible": "true" if a.get("visible") is True else "false",
            "scenes": "{ " + ", ".join(q(x) for x in lst) + " }",
            "is_global": "true" if (lst and len(lst) >= scene_total) else "false",
            "order": lua_tostring(actor_order.get(aid) or 0),
            "styles": "{ " + ", ".join(styles) + " }",
            "style_index": str(style_index),
        }))
    out.append("M.actors = { " + ", ".join(actor_lines) + " }")

    # 资源清单
    out.append('M.assets_dir = "works"')
    style_entries = []
    sdict2 = (work.get("styles") or {}).get("stylesDict") or {}
    for sid in sorted(sdict2.keys()):
        st = sdict2[sid]
        url = lua_tostring(st.get("url") or "")
        ext = _ext_of(url, "png")
        center = "nil"
        cp = st.get("centerPoint")
        if cp:
            center = table_str({"x": lua_tostring(tonumber(cp.get("x")) or 0),
                                "y": lua_tostring(tonumber(cp.get("y")) or 0)})
        style_entries.append("[%s] = %s" % (q(sid), table_str({
            "id": q(sid), "url": q(url), "file": q("assets/" + sid + "." + ext),
            "name": q(lua_tostring(st.get("name") or "")), "center": center,
            "styleType": lua_tostring(tonumber(st.get("styleType")) or 0) if st.get("styleType") is not None else "nil",
            "adaption": lua_tostring(tonumber(st.get("adaption")) or 0) if st.get("adaption") is not None else "nil",
        })))
    out.append("M.assets = { " + ", ".join(style_entries) + " }")

    audio_entries = []
    adict2 = (work.get("audios") or {}).get("audiosDict") or {}
    for aid in sorted(adict2.keys()):
        au = adict2[aid]
        url = lua_tostring(au.get("url") or "")
        ext = _ext_of(url, "mp3")
        audio_entries.append("[%s] = %s" % (q(aid), table_str({
            "id": q(aid), "url": q(url), "file": q("assets/" + aid + "." + ext),
            "name": q(lua_tostring(au.get("name") or "")),
        })))
    out.append("M.audios = { " + ", ".join(audio_entries) + " }")
    out.append("")

    # 脚本注册
    out.append("function M.register(rt, game, ents)")
    out.append("  f = rt.f")
    for sid in sids:
        out.append("  local e_%s = ents[%s]" % (lua_ident_sanitize(sid), q(sid)))
    for aid in aids:
        out.append("  local e_%s = ents[%s]" % (lua_ident_sanitize(aid), q(aid)))

    def emit_entity_scripts(entity, owner_expr, label):
        blocks = entity.get("nekoBlockJsonList") or []
        hats = []
        for b in blocks:
            if Spec.is_event(b.get("type")):
                hats.append(b)
            else:
                report["loose"] = (report.get("loose") or 0) + 1
                report.setdefault("loose_types", {})
                report["loose_types"][b.get("type")] = report["loose_types"].get(b.get("type"), 0) + 1
        if not hats:
            return
        out.append("  -- -------- %s --------" % label)
        for b in hats:
            hat(b, ctx0, owner_expr, out)

    for sid in sids:
        emit_entity_scripts(sdict[sid], "e_" + lua_ident_sanitize(sid),
                            "屏幕 %s" % lua_tostring(sdict[sid].get("name")))
    for aid in aids:
        emit_entity_scripts(adict[aid], "e_" + lua_ident_sanitize(aid),
                            "角色 %s" % lua_tostring(adict[aid].get("name")))
    out.append("end")
    out.append("")

    unsupported = support.unsupported_types_in_work(work)
    report["unsupported"] = unsupported
    if unsupported:
        out.append("-- 离线不支持块（编译期分类；运行期仍是 no-op/0，不要静默当成已实现）")
        out.append("M.unsupported_blocks = {")
        for t in sorted(unsupported):
            out.append("  [%s] = %s," % (q(t), q(unsupported[t])))
        out.append("}")

    names = sorted(report["calls"].keys())
    out.append("M.requires = {")
    for n in names:
        out.append("  %s," % q(n))
    out.append("}")
    out.append("return M")

    pool = ctx0.get("const_args") or {}
    if pool:
        # 不能每个常量用一个 local：Lua 5.1 单函数上限 200 个 local，
        # now 有 140+ 个常量会直接编译失败。用一张模块级表 __CONST[i]。
        decl = ["local __CONST = {"]
        for code in pool:
            decl.append("  %s," % code)
        decl.append("}")
        pos = 0
        for k, line in enumerate(out):
            if line.startswith("local f"):
                pos = k + 1
                break
        out[pos:pos] = decl
    src = "\n".join(out) + "\n"
    if ctx0.get("trampoline") and opts.get("leaf_procs"):
        src, leaf_n = _leaf_direct_calls(src)
        report["leaf_procs"] = leaf_n
    return src, report
