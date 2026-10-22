-- 由 knplayer/kntl 从作品自动生成，请勿手改
-- 作品：k3t V2   version=0.27.3
local M = {}
local V = require("rt.values") -- 值层：JS 真值语义（if 条件用 V.bool）
local f -- 运行期原语表，register 里赋值，过程体共用
local __CONST = {
  { PARAMS0 = nil, PARAMS1 = nil, name = "T", names = { "T", "N" } },
  { TEXT = "T" },
  { TEXT = "N" },
  { variable = "d93bd865-3cdc-4875-a945-09a58c510593" },
  { TEXT = "index" },
  { method = "increase", value = 3, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"index\"}" },
  { variable = "73fb6ae3-b812-44a1-ae63-3a2b057bb0f0" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, name = "a", names = { "a", "b", "c" } },
  { TEXT = "a" },
  { TEXT = "c" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "v", names = { "v", "tranfrom" } },
  { TEXT = "v" },
  { TEXT = "tranfrom" },
  { PARAMS0 = nil, name = "a" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "a", names = { "a", "b" } },
  { variable = "d00c0961-13f1-4bd2-9da3-878218f8f86f" },
  { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 1 },
  { TEXT = "b" },
  { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 2 },
  { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 3 },
  { item = "all", list = "05780ef1-4861-47e9-bb26-3f5ace27939e" },
  { PARAMS0 = nil, PARAMS1 = nil, name = "dx", names = { "dx", "dy" } },
  { TEXT = "dx" },
  { TEXT = "dy" },
  { variable = "2fc93804-ce83-4ac0-a215-f5155714708a" },
  { variable = "c42a513f-272a-4056-bf96-95513b923068" },
  { variable = "3e3b74b0-9e61-478f-85ac-15a7f6c101ea" },
  { variable = "505397b6-252b-4d12-b0a4-6794f4e84d57" },
  { variable = "eff2f806-0093-4c70-914b-e2fbf090bccd" },
  { variable = "09fb0e59-33a9-4451-962c-99c31629aed6" },
  { variable = "0647b32f-df58-4eed-8fa4-1ae2ecd20ba1" },
  { value = 0.5, variable = "2af408db-9054-4750-b86e-63e22e562649" },
  { variable = "2af408db-9054-4750-b86e-63e22e562649" },
  { variable = "3266e7ef-ca6c-46dc-bc38-0aebfca0b8f2" },
  { variable = "6eee7660-ab97-467f-9f1d-fd126c721df1" },
  { variable = "ced11fa8-04b5-41b6-bb60-81a891b29e7f" },
  { variable = "28f99bee-4a87-4523-9352-aeecb495ae18" },
  { method = "increase", value = 1, variable = "18f0690a-82d5-421e-bcf0-b3b1266bf202" },
  { variable = "65e34b24-e5c6-4851-b0c1-aa7e680c1ae5" },
  { variable = "3c392a6f-25fc-4c05-af9b-7da1567646c2" },
  { variable = "88e605f6-6f5a-47f1-94dd-3b926b5febd7" },
  { variable = "6f30cf55-883c-4bb1-ad95-ddb9ffe9a9e0" },
  { variable = "ca595afb-231b-4fcc-9018-9a62f871ad30" },
  { variable = "51399ca3-e9e1-4435-a062-ed46fd069ed7" },
  { value = 0, variable = "d9d927d4-5b41-4dfc-b6ac-825a9181c90a" },
  { value = 100, variable = "7c677497-1062-4b55-820f-4dd24ed90bf4" },
  { variable = "d9d927d4-5b41-4dfc-b6ac-825a9181c90a" },
  { variable = "7c677497-1062-4b55-820f-4dd24ed90bf4" },
  { variable = "d0a5b40e-c61a-48c6-8e1a-1b2d71c86be8" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS10 = nil, PARAMS11 = nil, PARAMS12 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, PARAMS7 = nil, PARAMS8 = nil, PARAMS9 = nil, name = "hx", names = { "hx", "hy", "hpoint", "ang1", "ang2", "deff", "temp", "tanA", "tanB", "tanC", "ha", "hb", "hc" } },
  { TEXT = "hpoint" },
  { TEXT = "hx" },
  { TEXT = "hy" },
  { TEXT = "tanA" },
  { TEXT = "ang2" },
  { TEXT = "ang1" },
  { TEXT = "deff" },
  { TEXT = "ha" },
  { TEXT = "tanB" },
  { TEXT = "hb" },
  { TEXT = "tanC" },
  { TEXT = "hc" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, name = "TempVertex", names = { "TempVertex", "V", "Center", "PlayerToFace", "N", "TV", "D" } },
  { SPLIT_TEXT = "", TEXT_TO_SPLIT = "" },
  { TEXT = "V" },
  { TEXT = "TempVertex" },
  { item = "any", list = "6b50b874-ddbe-4ce1-bd3f-74ec1fda9105", list_index = 2 },
  { item = "any", list = "6b50b874-ddbe-4ce1-bd3f-74ec1fda9105", list_index = 1 },
  { TEXT = "Center" },
  { TEXT = "PlayerToFace" },
  { item = "any", list = "6b50b874-ddbe-4ce1-bd3f-74ec1fda9105", list_index = 3 },
  { TEXT = "TV" },
  { TEXT = "D" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, name = "V", names = { "V", "Forward", "left", "UP", "poS", "roT", "scalE" } },
  { TEXT = "left" },
  { TEXT = "UP" },
  { TEXT = "Forward" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, PARAMS7 = nil, PARAMS8 = nil, PARAMS9 = nil, name = "a", names = { "a", "b", "c", "d", "e", "f", "g", "h", "i", "j" } },
  { TEXT = "d" },
  { TEXT = "e" },
  { value = 0, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"j\"}" },
  { value = 0, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"i\"}" },
  { value = 0, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"f\"}" },
  { value = 0, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"g\"}" },
  { TEXT = "f" },
  { TEXT = "g" },
  { TEXT = "j" },
  { TEXT = "h" },
  { TEXT = "i" },
  { method = "increase", value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"g\"}" },
  { method = "increase", value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"j\"}" },
  { method = "increase", value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"f\"}" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, PARAMS7 = nil, name = "a", names = { "a", "b", "c", "d", "e", "f", "g", "h" } },
  { value = 0, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, PARAMS5 = nil, PARAMS6 = nil, name = "Face", names = { "Face", "FileData", "VertexData", "i", "NormalsData", "TempData", "Model" } },
  { item = "all", list = "90722e9b-8041-445d-a7ab-f8779112f5be" },
  { item = "all", list = "83b72b06-11ed-4ac1-9242-3aff5c906ad1" },
  { value = 0, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"Model\"}" },
  { value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"i\"}" },
  { list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2" },
  { TEXT = "FileData" },
  { TEXT = "Model" },
  { TEXT = "TempData" },
  { variable = "f8d600f4-76d0-48c9-968a-2a99f6cc1a91" },
  { item = "last", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2" },
  { method = "increase", value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"Model\"}" },
  { method = "increase", value = 1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"i\"}" },
  { TEXT = "VertexData" },
  { method = "increase", value = 3, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"i\"}" },
  { TEXT = "NormalsData" },
  { PARAMS0 = nil, name = "V" },
  { SPLIT_TEXT = ",", TEXT_TO_SPLIT = "a,b,c,d,c,c" },
  { PARAMS0 = nil, PARAMS1 = nil, PARAMS2 = nil, PARAMS3 = nil, PARAMS4 = nil, name = "ux", names = { "ux", "uy", "vx", "vy", "t" } },
  { TEXT = "ux" },
  { TEXT = "vx" },
  { TEXT = "uy" },
  { TEXT = "vy" },
  { TEXT = "t" },
  { message = "Load OBJ" },
  { message = "Player" },
  { message = "aa" },
  { message = "render" },
  { message = "Tirangle" },
  { message = "Vertex" },
  { time = 0.1 },
  { value = 0, variable = "18f0690a-82d5-421e-bcf0-b3b1266bf202" },
  { list = "04385cbb-f792-4b08-b241-119237712080" },
  { item = "any", list = "0af8cae4-5992-44c2-8b69-7233ca3bec60", list_index = 1 },
  { item = "any", list = "0af8cae4-5992-44c2-8b69-7233ca3bec60", list_index = 2 },
  { variable = "ad1ef0f4-e46e-4492-b4c0-ebfb2f5a74d2" },
  { item = "any", list = "0af8cae4-5992-44c2-8b69-7233ca3bec60", list_index = 3 },
  { key = "38", type = "down" },
  { key = "40", type = "down" },
  { key = "39", type = "down" },
  { key = "37", type = "down" },
  { key = "87", type = "down" },
  { key = "83", type = "down" },
  { key = "68", type = "down" },
  { key = "65", type = "down" },
  { key = "32", type = "down" },
  { key = "67", type = "down" },
  { time = "second" },
  { variable = "25871aa6-5966-4243-baed-8a27e065947b" },
  { method = "increase", value = 1, variable = "23b75969-8369-4fb7-a609-42cf79e8a152" },
  { variable = "23b75969-8369-4fb7-a609-42cf79e8a152" },
  { value = 0, variable = "23b75969-8369-4fb7-a609-42cf79e8a152" },
  { item = "all", list = "77c087a7-d013-436a-97dd-e3c7fec94e42" },
  { list = "77c087a7-d013-436a-97dd-e3c7fec94e42", target_list = "04385cbb-f792-4b08-b241-119237712080" },
  { list = "75252e77-1193-4409-885c-ae4e74b8d706", target_list = "94e83d69-d7cc-428d-8e88-887e214d95d3" },
}

-- ===== 自定义积木（过程）=====
local proc_007f6379_a304_4134_bb41_27ed4b237544, proc_085bf835_7dcb_4577_9245_0f97d19e0db4, proc_12b6ec43_876e_47d2_bd8d_fd7b2dcf29f7, proc_13168c38_70dd_4aba_9887_a9e97a422947, proc_19425881_cb03_458f_a034_bffcb21918fc, proc_1ba5ad1c_6040_4517_a10d_b3d7bfe79d63, proc_25eb1a3c_1143_4810_8b9b_8b70b66623f0, proc_2df5146b_7e3f_485f_87d9_ce5c709bd9fd, proc_323b89af_4955_4747_b2a7_121710a35c21, proc_39724f16_b2c7_4602_ac79_bb54591d8512, proc_3c9c20b2_d769_4078_a1ad_17c22dc12398, proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, proc_4979555a_1da0_47ca_8f4f_1aca5714d854, proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, proc_5da275ed_e91e_42fa_8ff4_4ee6fc5cc737, proc_5eca0231_7d51_492a_9375_bcca4bbd00e7, proc_600a1ec6_d86c_447c_b61c_2edbced387cf, proc_60df8f80_309e_4488_a5b8_71c7625ff26b, proc_64382a10_6625_43e7_b4f3_3015645a2ac3, proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, proc_6a75a9c5_a3d6_408b_8014_c752e9e6fdc9, proc_74d5d8c1_7388_459f_ba8a_648a96ad0021, proc_7a1bf8a6_b5bf_4770_96f4_7c2f75400f51, proc_87a5d78f_b426_4a7a_99a5_bf629a1835b8, proc_9a2e870d_2f28_4733_b1c0_6674045360d2, proc_9b910ab5_89ee_4abc_82e3_58aa8f16ae0b, proc_a42a95c2_5f51_4ef7_8a12_9e8485d7c3a1, proc_a46aca3a_6fdb_4f2c_ad23_5a0f0cbf31d1, proc_b5b4895e_8503_4e5c_9d81_3be099bcaaa3, proc_bfd30caf_86be_455d_804e_e640f4d19b22, proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314, proc_c2df4a0c_8c09_4534_8937_87f85a716c67, proc_c97a9d91_e7f5_446c_aae1_850e4984162a, proc_cebf04d3_6819_4d68_9e40_2fe721fe12c1, proc_d1c574d8_6c6a_4b21_a732_1feb6c2695f4, proc_d90f4280_efc2_4020_a06d_32d5e70f46a9, proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, proc_e51153fc_c41f_4e03_8975_119bc01c026f, proc_eade72c3_56a6_4a3f_954e_e790fbd1efbe, proc_f280440d_6a36_4d3c_b1ad_84932e6bdb6f, proc_f973718d_379f_4fb6_be87_8a62e4e57a1d, proc_ff44a914_6440_4aa4_8de8_94816b1cb99b

proc_007f6379_a304_4134_bb41_27ed4b237544 = function(th, self, p_i, p_m)
  -- 过程「6fe7c9de-909c-4997-9bb9-d4ad7d10a167」 id=007f6379-a304-4134-bb41-27ed4b237544
  if V.bool(f["logic_compare"](self, { A = p_i, B = p_m, OP = "GTE" }, th)) then
    return nil
  end
  f["script_variables"](self, __CONST[1], th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"T\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 4, type = "add" }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"N\"}" }, th)
  th:call_proc(proc_9a2e870d_2f28_4733_b1c0_6674045360d2, self, 0, f["list_length"](self, { list = f["script_variables_value"](self, __CONST[2], th) }, th), f["script_variables_value"](self, __CONST[2], th), f["script_variables_value"](self, __CONST[3], th), nil, nil, nil, nil, nil, nil, nil)
  th:call_proc(proc_007f6379_a304_4134_bb41_27ed4b237544, self, f["math_arithmetic"](self, { A = p_i, B = 4, type = "add" }, th), p_m, nil, nil)
end

proc_085bf835_7dcb_4577_9245_0f97d19e0db4 = function(th, self, p_x, p_y, p_______)
  -- 过程「78980486-0c5c-4632-8fcc-04db57c0abd6」 id=085bf835-7dcb-4577-9245-0f97d19e0db4
  return f["temporary_list"](self, { ITEM0 = p_x, ITEM1 = p_y, ITEM2 = f["text_split"](self, { SPLIT_TEXT = "/", TEXT_TO_SPLIT = p_______ }, th) }, th)
end

proc_12b6ec43_876e_47d2_bd8d_fd7b2dcf29f7 = function(th, self, p_i, p_m)
  -- 过程「58dbff0f-4013-45b5-bfd3-637acda06c1e」 id=12b6ec43-876e-47d2-bd8d-fd7b2dcf29f7
  if V.bool(f["logic_compare"](self, { A = p_i, B = p_m, OP = "GT" }, th)) then
    return nil
  end
  th:call_proc(proc_e51153fc_c41f_4e03_8975_119bc01c026f, self, f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[5], th), B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[5], th), B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[5], th), B = 3, type = "add" }, th) }, th), "2rt", nil)
  f["change_variables"](self, __CONST[6], th)
  th:call_proc(proc_12b6ec43_876e_47d2_bd8d_fd7b2dcf29f7, self, f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th), p_m)
end

proc_13168c38_70dd_4aba_9887_a9e97a422947 = function(th, self, p_x, p_y, p_z, p_w)
  -- 过程「8cf8826d-58a0-4e40-8c9a-f12b35a4c637」 id=13168c38-70dd-4aba-9887-a9e97a422947
  return f["temporary_list"](self, { ITEM0 = p_x, ITEM1 = p_y, ITEM2 = p_z, ITEM3 = p_w }, th)
end

proc_19425881_cb03_458f_a034_bffcb21918fc = function(th, self, p_point)
  -- 过程「759469c9-65a6-4305-9a19-beb89dde5d69」 id=19425881-cb03-458f-a034-bffcb21918fc
  f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "x")), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[7], th), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "z")), type = "divide" }, th), type = "multiply" }, th), y = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "y")), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[7], th), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "z")), type = "divide" }, th), type = "multiply" }, th) }, th)
end

proc_1ba5ad1c_6040_4517_a10d_b3d7bfe79d63 = function(th, self)
  -- 过程「58f80fe6-8591-4f58-853d-2a135001b552」 id=1ba5ad1c-6040-4517-a10d-b3d7bfe79d63
  return 3.1415926535877
end

proc_25eb1a3c_1143_4810_8b9b_8b70b66623f0 = function(th, self, p_______, p_x, p_y)
  -- 过程「1c487799-2f07-4b4d-8b31-1d64c606a000」 id=25eb1a3c-1143-4810-8b9b-8b70b66623f0
  f["script_variables"](self, __CONST[8], th)
  f["variables_set"](self, { value = p_______, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 2 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
  return f["list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 3 }, th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[10], th), B = p_y, type = "multiply" }, th), B = p_x, type = "add" }, th), B = 1, type = "add" }, th) }, th)
end

proc_2df5146b_7e3f_485f_87d9_ce5c709bd9fd = function(th, self, p_i, p_m, p_v, p_tranfrom)
  -- 过程「de4365ba-71f1-44df-8506-5984f9794317」 id=2df5146b-7e3f-485f-87d9-ce5c709bd9fd
  if V.bool(f["logic_compare"](self, { A = p_i, B = p_m, OP = "GTE" }, th)) then
    return nil
  end
  f["script_variables"](self, __CONST[11], th)
  f["variables_set"](self, { value = p_v, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"v\"}" }, th)
  f["variables_set"](self, { value = p_tranfrom, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tranfrom\"}" }, th)
  f["list_append"](self, { list = "05780ef1-4861-47e9-bb26-3f5ace27939e", list_item_value = (th:call_proc(proc_a42a95c2_5f51_4ef7_8a12_9e8485d7c3a1, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[12], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 3 }, th), nil, nil, nil, nil, nil, nil, nil)) }, th)
  f["list_append"](self, { list = "05780ef1-4861-47e9-bb26-3f5ace27939e", list_item_value = (th:call_proc(proc_a42a95c2_5f51_4ef7_8a12_9e8485d7c3a1, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[12], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 3 }, th), nil, nil, nil, nil, nil, nil, nil)) }, th)
  f["list_append"](self, { list = "05780ef1-4861-47e9-bb26-3f5ace27939e", list_item_value = (th:call_proc(proc_a42a95c2_5f51_4ef7_8a12_9e8485d7c3a1, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[12], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 1 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 2 }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[13], th), list_index = 3 }, th), nil, nil, nil, nil, nil, nil, nil)) }, th)
  th:call_proc(proc_2df5146b_7e3f_485f_87d9_ce5c709bd9fd, self, f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th), p_m, p_v, p_tranfrom, nil, nil)
end

proc_323b89af_4955_4747_b2a7_121710a35c21 = function(th, self, p_Q, p_a)
  -- 过程「2256c0d1-6851-4d11-b752-2cec7552a0f5」 id=323b89af-4955-4747-b2a7-121710a35c21
  f["script_variables"](self, __CONST[14], th)
  f["variables_set"](self, { value = p_Q, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = p_a, B = "x", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 1 }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_a, B = "y", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 2 }, th)
  elseif V.bool(f["logic_compare"](self, { A = p_a, B = "z", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 3 }, th)
  else
    return f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 4 }, th)
  end
end

proc_39724f16_b2c7_4602_ac79_bb54591d8512 = function(th, self, p_Point)
  -- 过程「585b38f7-bec7-432a-a878-c900cc6cf42a」 id=39724f16-b2c7-4602-ac79-bb54591d8512
  f["script_variables"](self, __CONST[15], th)
  f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, p_Point, "+", f["variables_get"](self, __CONST[16], th))), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, (th:call_proc(proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314, self, f["list_item"](self, __CONST[17], th), f["script_variables_value"](self, __CONST[18], th))), (th:call_proc(proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314, self, f["list_item"](self, __CONST[19], th), f["script_variables_value"](self, __CONST[18], th))), (th:call_proc(proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314, self, f["list_item"](self, __CONST[20], th), f["script_variables_value"](self, __CONST[18], th))))), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
  return f["script_variables_value"](self, __CONST[18], th)
end

proc_3c9c20b2_d769_4078_a1ad_17c22dc12398 = function(th, self, p_vec3, p__________, p_num)
  -- 过程「3a378576-dbdf-4f6c-9e69-b5eb1f5d20d7」 id=3c9c20b2-d769-4078-a1ad-17c22dc12398
  if V.bool(f["logic_compare"](self, { A = p__________, B = "+", OP = "EQ" }, th)) then
    return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "x")), B = p_num, type = "add" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "y")), B = p_num, type = "add" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "z")), B = p_num, type = "add" }, th)))
  elseif V.bool(f["logic_compare"](self, { A = p__________, B = "-", OP = "EQ" }, th)) then
    return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "x")), B = p_num, type = "minus" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "y")), B = p_num, type = "minus" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "z")), B = p_num, type = "minus" }, th)))
  elseif V.bool(f["logic_compare"](self, { A = p__________, B = "×", OP = "EQ" }, th)) then
    return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "x")), B = p_num, type = "multiply" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "y")), B = p_num, type = "multiply" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "z")), B = p_num, type = "multiply" }, th)))
  else
    return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "x")), B = p_num, type = "divide" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "y")), B = p_num, type = "divide" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3, "z")), B = p_num, type = "divide" }, th)))
  end
end

proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4 = function(th, self, p_vec3_1, p__________, p_vec3_2)
  -- 过程「abbb18e9-f05c-4f53-a4b9-d75b9cd21ef7」 id=47cb41eb-a3e9-41ef-b486-14e4d136aad4
  if V.bool(f["logic_compare"](self, { A = p__________, B = "+", OP = "EQ" }, th)) then
    return (th:call_proc(proc_87a5d78f_b426_4a7a_99a5_bf629a1835b8, self, p_vec3_1, "+", p_vec3_2))
  elseif V.bool(f["logic_compare"](self, { A = p__________, B = "-", OP = "EQ" }, th)) then
    return (th:call_proc(proc_87a5d78f_b426_4a7a_99a5_bf629a1835b8, self, p_vec3_1, "-", p_vec3_2))
  elseif V.bool(f["logic_compare"](self, { A = p__________, B = "·", OP = "EQ" }, th)) then
    return (th:call_proc(proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314, self, p_vec3_1, p_vec3_2))
  elseif V.bool(f["logic_compare"](self, { A = p__________, B = "分量相乘", OP = "EQ" }, th)) then
    return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3_1, "x")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3_2, "x")), type = "multiply" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3_1, "y")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3_2, "y")), type = "multiply" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3_1, "z")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_vec3_2, "z")), type = "multiply" }, th)))
  else
    return (th:call_proc(proc_9b910ab5_89ee_4abc_82e3_58aa8f16ae0b, self, p_vec3_1, p_vec3_2))
  end
end

proc_4979555a_1da0_47ca_8f4f_1aca5714d854 = function(th, self, p_i, p_m)
  -- 过程「9686c925-464a-4b24-b506-b1ee1d5bb6c3」 id=4979555a-1da0-47ca-8f4f-1aca5714d854
  if V.bool(f["logic_compare"](self, { A = p_i, B = p_m, OP = "GTE" }, th)) then
    return nil
  end
  f["delete_list_item"](self, __CONST[21], th)
  th:call_proc(proc_2df5146b_7e3f_485f_87d9_ce5c709bd9fd, self, 0, f["list_length"](self, { list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th) }, th), f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th), nil, nil)
  f["list_copy"](self, { list = "05780ef1-4861-47e9-bb26-3f5ace27939e", target_list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th) }, th)
  f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th), list_index = 1, list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 0)) }, th)
  f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th), list_index = 2, list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 0)) }, th)
  f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th), list_index = 3, list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 1, 1, 1)) }, th)
  th:call_proc(proc_4979555a_1da0_47ca_8f4f_1aca5714d854, self, f["math_arithmetic"](self, { A = p_i, B = 4, type = "add" }, th), p_m)
end

proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d = function(th, self, p_xA, p_yA, p_xB, p_yB)
  -- 过程「b3c48ccd-f9d4-4211-8160-e630555d1829」 id=52d8473e-d810-4a74-9fa5-b15b1a3d572d
  f["script_variables"](self, __CONST[22], th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dx\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"dy\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[23], th), B = 0, OP = "LT" }, th)) then
    return f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[24], th), B = f["script_variables_value"](self, __CONST[23], th), type = "divide" }, th), type = "atan" }, th), B = 180, type = "add" }, th)
  elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[23], th), B = 0, OP = "EQ" }, th)) then
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[24], th), B = 0, OP = "GT" }, th)) then
      return 90
    elseif V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[24], th), B = 0, OP = "LT" }, th)) then
      return 270
    else
      return 0
    end
  else
    if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[24], th), B = 0, OP = "GTE" }, th)) then
      return f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[24], th), B = f["script_variables_value"](self, __CONST[23], th), type = "divide" }, th), type = "atan" }, th)
    else
      return f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[24], th), B = f["script_variables_value"](self, __CONST[23], th), type = "divide" }, th), type = "atan" }, th), B = 360, type = "add" }, th)
    end
  end
end

proc_5da275ed_e91e_42fa_8ff4_4ee6fc5cc737 = function(th, self, p_point, p_Rotating_axis, p_Angle)
  -- 过程「5a02ca12-654b-48f1-8b5f-2a56f91f2853」 id=5da275ed-e91e-42fa-8ff4-4ee6fc5cc737
  f["script_variables"](self, __CONST[15], th)
  f["variables_set"](self, { value = (th:call_proc(proc_b5b4895e_8503_4e5c_9d81_3be099bcaaa3, self, p_Rotating_axis, p_Angle)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
  return (th:call_proc(proc_a46aca3a_6fdb_4f2c_ad23_5a0f0cbf31d1, self, (th:call_proc(proc_a46aca3a_6fdb_4f2c_ad23_5a0f0cbf31d1, self, f["script_variables_value"](self, __CONST[18], th), (th:call_proc(proc_13168c38_70dd_4aba_9887_a9e97a422947, self, (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "x")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "y")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "z")), 0)))), (th:call_proc(proc_cebf04d3_6819_4d68_9e40_2fe721fe12c1, self, f["script_variables_value"](self, __CONST[18], th)))))
end

proc_5eca0231_7d51_492a_9375_bcca4bbd00e7 = function(th, self, p_Mat, p_x, p_y, p_New_Data)
  -- 过程「9796f87c-f593-458e-b58b-6f1c8dd07472」 id=5eca0231-7d51-492a-9375-bcca4bbd00e7
  f["script_variables"](self, __CONST[8], th)
  f["variables_set"](self, { value = p_Mat, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 2 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
  f["replace_list_item"](self, { item = "any", list = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 3 }, th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[10], th), B = p_y, type = "multiply" }, th), B = p_x, type = "add" }, th), B = 1, type = "add" }, th), list_item_value = p_New_Data }, th)
  return nil
end

proc_600a1ec6_d86c_447c_b61c_2edbced387cf = function(th, self, p_x1, p_y1, p_x2, p_y2, p_x3, p_y3, p_res)
  -- 过程「46748430-98e4-4fe2-af3e-9fc55b9cacff」 id=600a1ec6-d86c-447c-b61c-2edbced387cf
  th:warp_enter()
  f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x3, B = p_x2, type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y3, B = p_y2, type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th), variable = "2fc93804-ce83-4ac0-a215-f5155714708a" }, th)
  f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x3, B = p_x1, type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y3, B = p_y1, type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th), variable = "c42a513f-272a-4056-bf96-95513b923068" }, th)
  f["variables_set"](self, { value = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x1, B = p_x2, type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y1, B = p_y2, type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th), variable = "3e3b74b0-9e61-478f-85ac-15a7f6c101ea" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[25], th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[26], th), B = f["variables_get"](self, __CONST[27], th), type = "add" }, th), type = "add" }, th), variable = "505397b6-252b-4d12-b0a4-6794f4e84d57" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[28], th), B = 2, type = "divide" }, th), variable = "eff2f806-0093-4c70-914b-e2fbf090bccd" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 2, B = f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[29], th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[29], th), B = f["variables_get"](self, __CONST[25], th), type = "minus" }, th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[29], th), B = f["variables_get"](self, __CONST[26], th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[29], th), B = f["variables_get"](self, __CONST[27], th), type = "minus" }, th), type = "multiply" }, th), type = "multiply" }, th), type = "0" }, th), type = "multiply" }, th), B = f["variables_get"](self, __CONST[29], th), type = "divide" }, th), variable = "eff2f806-0093-4c70-914b-e2fbf090bccd" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[25], th), B = p_x1, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[26], th), B = p_x2, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[27], th), B = p_x3, type = "multiply" }, th), type = "add" }, th), type = "add" }, th), B = f["variables_get"](self, __CONST[28], th), type = "divide" }, th), variable = "09fb0e59-33a9-4451-962c-99c31629aed6" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[25], th), B = p_y1, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[26], th), B = p_y2, type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[27], th), B = p_y3, type = "multiply" }, th), type = "add" }, th), type = "add" }, th), B = f["variables_get"](self, __CONST[28], th), type = "divide" }, th), variable = "0647b32f-df58-4eed-8fa4-1ae2ecd20ba1" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_x1, B = f["variables_get"](self, __CONST[30], th), type = "minus" }, th), variable = "2fc93804-ce83-4ac0-a215-f5155714708a" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_y1, B = f["variables_get"](self, __CONST[31], th), type = "minus" }, th), variable = "c42a513f-272a-4056-bf96-95513b923068" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_x2, B = f["variables_get"](self, __CONST[30], th), type = "minus" }, th), variable = "3e3b74b0-9e61-478f-85ac-15a7f6c101ea" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_y2, B = f["variables_get"](self, __CONST[31], th), type = "minus" }, th), variable = "505397b6-252b-4d12-b0a4-6794f4e84d57" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_x3, B = f["variables_get"](self, __CONST[30], th), type = "minus" }, th), variable = "3266e7ef-ca6c-46dc-bc38-0aebfca0b8f2" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_y3, B = f["variables_get"](self, __CONST[31], th), type = "minus" }, th), variable = "6eee7660-ab97-467f-9f1d-fd126c721df1" }, th)
  f["variables_set"](self, __CONST[32], th)
  while true do
    if f["logic_compare"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[29], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_res, B = 2, type = "divide" }, th), B = 0.5, type = "add" }, th), OP = "LT" }, th) then break end
    f["self_set_pen_size"](self, { size = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[29], th), type = "multiply" }, th), B = 1, type = "add" }, th) }, th)
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x1, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[25], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y1, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[26], th), type = "multiply" }, th), type = "minus" }, th) }, th)
    f["self_pen_down"](self, {}, th)
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x2, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[27], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y2, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[28], th), type = "multiply" }, th), type = "minus" }, th) }, th)
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x3, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[34], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y3, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[35], th), type = "multiply" }, th), type = "minus" }, th) }, th)
    f["self_move_to"](self, { x = f["math_arithmetic"](self, { A = p_x1, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[25], th), type = "multiply" }, th), type = "minus" }, th), y = f["math_arithmetic"](self, { A = p_y1, B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["variables_get"](self, __CONST[26], th), type = "multiply" }, th), type = "minus" }, th) }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[33], th), B = f["math_arithmetic"](self, { A = 2.7, B = f["variables_get"](self, __CONST[33], th), type = "minus" }, th), type = "divide" }, th), variable = "2af408db-9054-4750-b86e-63e22e562649" }, th)
    if th:iter_w() then break end
  end
  f["self_set_pen_size"](self, { size = f["math_arithmetic"](self, { A = p_res, B = 1, type = "add" }, th) }, th)
  f["self_move_to"](self, { x = p_x1, y = p_y1 }, th)
  f["self_pen_down"](self, {}, th)
  f["self_move_to"](self, { x = p_x2, y = p_y2 }, th)
  f["self_move_to"](self, { x = p_x3, y = p_y3 }, th)
  f["self_move_to"](self, { x = p_x1, y = p_y1 }, th)
  f["self_pen_up"](self, {}, th)
  th:warp_exit()
end

proc_60df8f80_309e_4488_a5b8_71c7625ff26b = function(th, self, p_i, p_m)
  -- 过程「ad7e4206-bc01-4a9b-984b-530b29a14eb9」 id=60df8f80-309e-4488-a5b8-71c7625ff26b
  if V.bool(f["logic_compare"](self, { A = p_i, B = p_m, OP = "GTE" }, th)) then
    return nil
  end
  f["script_variables"](self, __CONST[14], th)
  f["variables_set"](self, { value = (th:call_proc(proc_f280440d_6a36_4d3c_b1ad_84932e6bdb6f, self, (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th), "-", f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th) }, th))), "@", (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th), "-", f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th) }, th))))), nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["variables_get"](self, __CONST[36], th), "·", f["script_variables_value"](self, __CONST[9], th))), variable = "28f99bee-4a87-4523-9352-aeecb495ae18" }, th)
  th:call_proc(proc_64382a10_6625_43e7_b4f3_3015645a2ac3, self, f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[37], th), B = 255, type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[37], th), B = 255, type = "multiply" }, th), f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[37], th), B = 255, type = "multiply" }, th))
  th:call_proc(proc_e51153fc_c41f_4e03_8975_119bc01c026f, self, f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[4], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th), "2rt", nil)
  f["change_variables"](self, __CONST[38], th)
  th:call_proc(proc_60df8f80_309e_4488_a5b8_71c7625ff26b, self, f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th), p_m, nil)
end

proc_64382a10_6625_43e7_b4f3_3015645a2ac3 = function(th, self, p_R, p_G, p_B)
  -- 过程「b0cba4d7-3735-4127-be83-5431812a5ecb」 id=64382a10-6625-43e7-b4f3-3015645a2ac3
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_R, B = 255, type = "divide" }, th), variable = "65e34b24-e5c6-4851-b0c1-aa7e680c1ae5" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_G, B = 255, type = "divide" }, th), variable = "3c392a6f-25fc-4c05-af9b-7da1567646c2" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_B, B = 255, type = "divide" }, th), variable = "88e605f6-6f5a-47f1-94dd-3b926b5febd7" }, th)
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[39], th), B = f["variables_get"](self, __CONST[40], th), OP = "GTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[39], th), B = f["variables_get"](self, __CONST[41], th), OP = "GTE" }, th), type = "and" }, th)) then
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[39], th), variable = "6f30cf55-883c-4bb1-ad95-ddb9ffe9a9e0" }, th)
  elseif V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[40], th), B = f["variables_get"](self, __CONST[39], th), OP = "GTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[40], th), B = f["variables_get"](self, __CONST[41], th), OP = "GTE" }, th), type = "and" }, th)) then
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[40], th), variable = "6f30cf55-883c-4bb1-ad95-ddb9ffe9a9e0" }, th)
  else
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[41], th), variable = "6f30cf55-883c-4bb1-ad95-ddb9ffe9a9e0" }, th)
  end
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[39], th), B = f["variables_get"](self, __CONST[40], th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[39], th), B = f["variables_get"](self, __CONST[41], th), OP = "LTE" }, th), type = "and" }, th)) then
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[39], th), variable = "ca595afb-231b-4fcc-9018-9a62f871ad30" }, th)
  elseif V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[40], th), B = f["variables_get"](self, __CONST[39], th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["variables_get"](self, __CONST[40], th), B = f["variables_get"](self, __CONST[41], th), OP = "LTE" }, th), type = "and" }, th)) then
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[40], th), variable = "ca595afb-231b-4fcc-9018-9a62f871ad30" }, th)
  else
    f["variables_set"](self, { value = f["variables_get"](self, __CONST[41], th), variable = "ca595afb-231b-4fcc-9018-9a62f871ad30" }, th)
  end
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[42], th), B = f["variables_get"](self, __CONST[43], th), type = "minus" }, th), variable = "51399ca3-e9e1-4435-a062-ed46fd069ed7" }, th)
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[44], th), B = 0, OP = "EQ" }, th)) then
    f["variables_set"](self, __CONST[45], th)
  elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[42], th), B = f["variables_get"](self, __CONST[39], th), OP = "EQ" }, th)) then
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_modulo"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[40], th), B = f["variables_get"](self, __CONST[41], th), type = "minus" }, th), B = f["variables_get"](self, __CONST[44], th), type = "divide" }, th), B = 6 }, th), B = 60, type = "multiply" }, th), variable = "d9d927d4-5b41-4dfc-b6ac-825a9181c90a" }, th)
  elseif V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[42], th), B = f["variables_get"](self, __CONST[40], th), OP = "EQ" }, th)) then
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[41], th), B = f["variables_get"](self, __CONST[39], th), type = "minus" }, th), B = f["variables_get"](self, __CONST[44], th), type = "divide" }, th), B = 2, type = "add" }, th), B = 60, type = "multiply" }, th), variable = "d9d927d4-5b41-4dfc-b6ac-825a9181c90a" }, th)
  else
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[39], th), B = f["variables_get"](self, __CONST[40], th), type = "minus" }, th), B = f["variables_get"](self, __CONST[44], th), type = "divide" }, th), B = 4, type = "add" }, th), B = 60, type = "multiply" }, th), variable = "d9d927d4-5b41-4dfc-b6ac-825a9181c90a" }, th)
  end
  if V.bool(f["logic_compare"](self, { A = f["variables_get"](self, __CONST[42], th), B = 0, OP = "NEQ" }, th)) then
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[44], th), B = f["variables_get"](self, __CONST[42], th), type = "divide" }, th), B = 100, type = "multiply" }, th), variable = "7c677497-1062-4b55-820f-4dd24ed90bf4" }, th)
  else
    f["variables_set"](self, __CONST[46], th)
  end
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[42], th), B = 100, type = "multiply" }, th), variable = "d0a5b40e-c61a-48c6-8e1a-1b2d71c86be8" }, th)
  f["self_set_pen_color_property"](self, { scope = "hue", val = f["variables_get"](self, __CONST[47], th) }, th)
  f["self_set_pen_color_property"](self, { scope = "saturation", val = f["variables_get"](self, __CONST[48], th) }, th)
  f["self_set_pen_color_property"](self, { scope = "brightness", val = f["math_arithmetic"](self, { A = 10, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[49], th), B = 2, type = "divide" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = f["variables_get"](self, __CONST[48], th), type = "minus" }, th), B = 2, type = "divide" }, th), type = "add" }, th), type = "add" }, th) }, th)
end

proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580 = function(th, self, p_xd, p_yd, p_x1, p_y1, p_x2, p_y2, p_x, p_y, p____, p_______)
  -- 过程「5e8534f2-04f2-4339-a0d1-e2f8b8a1c4bf」 id=66abeca3-de3b-463d-adcc-0c1e7c9c4580
  f["self_set_effect"](self, { scope = "2", value = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[37], th), B = 100, type = "multiply" }, th) }, th)
  f["self_point_towards"](self, { degrees = (th:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, self, p_xd, p_yd, p_x1, p_y1, nil, nil)) }, th)
  f["set_width_height_scale"](self, { type = "width", value = f["math_arithmetic"](self, { A = 2, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = p_______, type = "divide" }, th), B = (th:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, self, p_x1, p_y1, p_xd, p_yd)), type = "multiply" }, th), type = "add" }, th) }, th)
  f["set_width_height_scale"](self, { type = "height", value = f["math_arithmetic"](self, { A = 2, B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = 100, B = p_______, type = "divide" }, th), B = p____, type = "multiply" }, th), type = "add" }, th) }, th)
  f["self_move_to"](self, { x = p_x, y = p_y }, th)
  f["image_stamp"](self, {}, th)
end

proc_6a75a9c5_a3d6_408b_8014_c752e9e6fdc9 = function(th, self, p_point)
  -- 过程「d263608c-3eaf-4b3b-9b32-c4621bddf3e0」 id=6a75a9c5-a3d6-408b-8014-c752e9e6fdc9
  th:call_proc(proc_19425881_cb03_458f_a034_bffcb21918fc, self, (th:call_proc(proc_39724f16_b2c7_4602_ac79_bb54591d8512, self, p_point, nil, nil)))
end

proc_74d5d8c1_7388_459f_ba8a_648a96ad0021 = function(th, self, p_i, p_m)
  -- 过程「1e9887cf-fede-41a8-8ffe-3243a25a601a」 id=74d5d8c1-7388-459f-ba8a-648a96ad0021
  if V.bool(f["logic_compare"](self, { A = p_i, B = 0, OP = "EQ" }, th)) then
    return nil
  end
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = "04385cbb-f792-4b08-b241-119237712080", list_index = p_i }, th), variable = "d93bd865-3cdc-4875-a945-09a58c510593" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = "94e83d69-d7cc-428d-8e88-887e214d95d3", list_index = p_i }, th), variable = "e201d814-aadc-43dc-9f70-3bf7d4edc54b" }, th)
  th:call_proc(proc_60df8f80_309e_4488_a5b8_71c7625ff26b, self, 0, f["list_length"](self, { list = f["variables_get"](self, __CONST[4], th) }, th), nil)
  th:call_proc(proc_74d5d8c1_7388_459f_ba8a_648a96ad0021, self, f["math_arithmetic"](self, { A = p_i, B = 1, type = "minus" }, th), p_m)
end

proc_7a1bf8a6_b5bf_4770_96f4_7c2f75400f51 = function(th, self, p_______, p_xA, p_yA, p_xB, p_yB, p_xC, p_yC)
  -- 过程「39bc2f18-8bc8-45e0-97b5-32510986d2b5」 id=7a1bf8a6-b5bf-4770-96f4-7c2f75400f51
  f["sync_tell"](self, { sprite = "3561b200-c6c3-44a7-be89-db8d50281861", DO = function(t2, s2)
      f["script_variables"](s2, __CONST[50], t2)
      f["variables_set"](s2, { value = (t2:call_proc(proc_eade72c3_56a6_4a3f_954e_e790fbd1efbe, s2, p_xA, p_yA, p_xB, p_yB, p_xC, p_yC, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hpoint\"}" }, t2)
      f["variables_set"](s2, { value = f["list_item"](s2, { item = "any", list = f["script_variables_value"](s2, __CONST[51], t2), list_index = 1 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hx\"}" }, t2)
      f["variables_set"](s2, { value = f["list_item"](s2, { item = "any", list = f["script_variables_value"](s2, __CONST[51], t2), list_index = 2 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hy\"}" }, t2)
      f["variables_set"](s2, { value = f["list_item"](s2, { item = "any", list = f["script_variables_value"](s2, __CONST[51], t2), list_index = 3 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hpoint\"}" }, t2)
      if V.bool(f["logic_compare"](s2, { A = f["script_variables_value"](s2, __CONST[51], t2), B = 1, OP = "EQ" }, t2)) then
        f["variables_set"](s2, { value = (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ha\"}" }, t2)
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tanA\"}" }, t2)
        f["variables_set"](s2, { value = f["script_variables_value"](s2, __CONST[54], t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, t2)
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, t2)
        f["variables_set"](s2, { value = f["math_modulo"](s2, { A = f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[55], t2), B = f["script_variables_value"](s2, __CONST[56], t2), type = "minus" }, t2), B = 360, type = "add" }, t2), B = 360 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, t2)
        if V.bool(f["logic_compare"](s2, { A = f["math_function"](s2, { num = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[57], t2), B = 90, type = "minus" }, t2), type = "1" }, t2), B = 1, OP = "LT" }, t2)) then
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA, p_xB, p_yB, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xB, B = p_xA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yB, B = p_yA, type = "add" }, t2), B = 2, type = "divide" }, t2), (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB)), p_______)
        else
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB, p_xA, p_yA, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xB, B = p_xA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yB, B = p_yA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["script_variables_value"](s2, __CONST[58], t2), p_______)
        end
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, t2)
        f["variables_set"](s2, { value = f["script_variables_value"](s2, __CONST[54], t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, t2)
        f["variables_set"](s2, { value = f["math_modulo"](s2, { A = f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[55], t2), B = f["script_variables_value"](s2, __CONST[56], t2), type = "minus" }, t2), B = 360, type = "add" }, t2), B = 360 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, t2)
        if V.bool(f["logic_compare"](s2, { A = f["math_function"](s2, { num = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[57], t2), B = 90, type = "minus" }, t2), type = "1" }, t2), B = 1, OP = "LT" }, t2)) then
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC, p_xA, p_yA, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xA, B = p_xC, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yA, B = p_yC, type = "add" }, t2), B = 2, type = "divide" }, t2), f["script_variables_value"](s2, __CONST[58], t2), p_______)
        else
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA, p_xC, p_yC, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xC, B = p_xA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yC, B = p_yA, type = "add" }, t2), B = 2, type = "divide" }, t2), (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC)), p_______)
        end
      elseif V.bool(f["logic_compare"](s2, { A = f["script_variables_value"](s2, __CONST[51], t2), B = 2, OP = "EQ" }, t2)) then
        f["variables_set"](s2, { value = (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hb\"}" }, t2)
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tanB\"}" }, t2)
        f["variables_set"](s2, { value = f["script_variables_value"](s2, __CONST[59], t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, t2)
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, t2)
        f["variables_set"](s2, { value = f["math_modulo"](s2, { A = f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[55], t2), B = f["script_variables_value"](s2, __CONST[56], t2), type = "minus" }, t2), B = 360, type = "add" }, t2), B = 360 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, t2)
        if V.bool(f["logic_compare"](s2, { A = f["math_function"](s2, { num = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[57], t2), B = 90, type = "minus" }, t2), type = "1" }, t2), B = 1, OP = "LT" }, t2)) then
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB, p_xA, p_yA, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xB, B = p_xA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yB, B = p_yA, type = "add" }, t2), B = 2, type = "divide" }, t2), (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA)), p_______)
        else
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA, p_xB, p_yB, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xB, B = p_xA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yB, B = p_yA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["script_variables_value"](s2, __CONST[60], t2), p_______)
        end
        f["variables_set"](s2, { value = f["script_variables_value"](s2, __CONST[59], t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, t2)
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, t2)
        f["variables_set"](s2, { value = f["math_modulo"](s2, { A = f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[55], t2), B = f["script_variables_value"](s2, __CONST[56], t2), type = "minus" }, t2), B = 360, type = "add" }, t2), B = 360 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, t2)
        if V.bool(f["logic_compare"](s2, { A = f["math_function"](s2, { num = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[57], t2), B = 90, type = "minus" }, t2), type = "1" }, t2), B = 1, OP = "LT" }, t2)) then
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB, p_xC, p_yC, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xB, B = p_xC, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yB, B = p_yC, type = "add" }, t2), B = 2, type = "divide" }, t2), (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC)), p_______)
        else
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC, p_xB, p_yB, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xB, B = p_xC, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yB, B = p_yC, type = "add" }, t2), B = 2, type = "divide" }, t2), f["script_variables_value"](s2, __CONST[60], t2), p_______)
        end
      else
        f["variables_set"](s2, { value = (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"hc\"}" }, t2)
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"tanC\"}" }, t2)
        f["variables_set"](s2, { value = f["script_variables_value"](s2, __CONST[61], t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, t2)
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, t2)
        f["variables_set"](s2, { value = f["math_modulo"](s2, { A = f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[55], t2), B = f["script_variables_value"](s2, __CONST[56], t2), type = "minus" }, t2), B = 360, type = "add" }, t2), B = 360 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, t2)
        if V.bool(f["logic_compare"](s2, { A = f["math_function"](s2, { num = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[57], t2), B = 90, type = "minus" }, t2), type = "1" }, t2), B = 1, OP = "LT" }, t2)) then
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC, p_xA, p_yA, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xC, B = p_xA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yC, B = p_yA, type = "add" }, t2), B = 2, type = "divide" }, t2), (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA)), p_______)
        else
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xA, p_yA, p_xC, p_yC, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xC, B = p_xA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yC, B = p_yA, type = "add" }, t2), B = 2, type = "divide" }, t2), f["script_variables_value"](s2, __CONST[62], t2), p_______)
        end
        f["variables_set"](s2, { value = f["script_variables_value"](s2, __CONST[61], t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang1\"}" }, t2)
        f["variables_set"](s2, { value = (t2:call_proc(proc_52d8473e_d810_4a74_9fa5_b15b1a3d572d, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ang2\"}" }, t2)
        f["variables_set"](s2, { value = f["math_modulo"](s2, { A = f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[55], t2), B = f["script_variables_value"](s2, __CONST[56], t2), type = "minus" }, t2), B = 360, type = "add" }, t2), B = 360 }, t2), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"deff\"}" }, t2)
        if V.bool(f["logic_compare"](s2, { A = f["math_function"](s2, { num = f["math_arithmetic"](s2, { A = f["script_variables_value"](s2, __CONST[57], t2), B = 90, type = "minus" }, t2), type = "1" }, t2), B = 1, OP = "LT" }, t2)) then
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xC, p_yC, p_xB, p_yB, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xB, B = p_xC, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yB, B = p_yC, type = "add" }, t2), B = 2, type = "divide" }, t2), (t2:call_proc(proc_ff44a914_6440_4aa4_8de8_94816b1cb99b, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB)), p_______)
        else
          t2:call_proc(proc_66abeca3_de3b_463d_adcc_0c1e7c9c4580, s2, f["script_variables_value"](s2, __CONST[52], t2), f["script_variables_value"](s2, __CONST[53], t2), p_xB, p_yB, p_xC, p_yC, f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_xB, B = p_xC, type = "add" }, t2), B = 2, type = "divide" }, t2), f["math_arithmetic"](s2, { A = f["math_arithmetic"](s2, { A = p_yB, B = p_yC, type = "add" }, t2), B = 2, type = "divide" }, t2), f["script_variables_value"](s2, __CONST[62], t2), p_______)
        end
      end
  end }, th)
end

proc_87a5d78f_b426_4a7a_99a5_bf629a1835b8 = function(th, self, p_______1, p__________, p_______2)
  -- 过程「ce9b4d79-e7bb-4454-ac40-4f589ac632dd」 id=87a5d78f-b426-4a7a-99a5-bf629a1835b8
  if V.bool(f["logic_compare"](self, { A = p__________, B = "+", OP = "EQ" }, th)) then
    return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "x")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "x")), type = "add" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "y")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "y")), type = "add" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "z")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "z")), type = "add" }, th)))
  else
    return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "x")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "x")), type = "minus" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "y")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "y")), type = "minus" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "z")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "z")), type = "minus" }, th)))
  end
end

proc_9a2e870d_2f28_4733_b1c0_6674045360d2 = function(th, self, p_i, p_m, p_v, p_n)
  -- 过程「ecdf1aa9-abef-4835-ac97-b5f3495e57f7」 id=9a2e870d-2f28-4733-b1c0-6674045360d2
  if V.bool(f["logic_compare"](self, { A = p_i, B = p_m, OP = "GTE" }, th)) then
    return nil
  end
  f["script_variables"](self, __CONST[63], th)
  f["variables_set"](self, { value = p_v, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"V\"}" }, th)
  f["variables_set"](self, { value = p_n, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"N\"}" }, th)
  f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TempVertex\"}" }, th)
  f["list_append"](self, { list = f["script_variables_value"](self, __CONST[66], th), list_item_value = (th:call_proc(proc_39724f16_b2c7_4602_ac79_bb54591d8512, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th) }, th), nil, nil)) }, th)
  f["list_append"](self, { list = f["script_variables_value"](self, __CONST[66], th), list_item_value = (th:call_proc(proc_39724f16_b2c7_4602_ac79_bb54591d8512, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th), nil, nil)) }, th)
  f["list_append"](self, { list = f["script_variables_value"](self, __CONST[66], th), list_item_value = (th:call_proc(proc_39724f16_b2c7_4602_ac79_bb54591d8512, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th), nil, nil)) }, th)
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[66], th), list_index = 1 }, th), "z")), B = f["math_arithmetic"](self, { A = 0, B = f["list_item"](self, __CONST[67], th), type = "minus" }, th), OP = "GTE" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[66], th), list_index = 2 }, th), "z")), B = f["math_arithmetic"](self, { A = 0, B = f["list_item"](self, __CONST[67], th), type = "minus" }, th), OP = "GTE" }, th), B = f["logic_compare"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[66], th), list_index = 3 }, th), "z")), B = f["math_arithmetic"](self, { A = 0, B = f["list_item"](self, __CONST[67], th), type = "minus" }, th), OP = "GTE" }, th), type = "and" }, th), type = "and" }, th)) then
    if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[66], th), list_index = 1 }, th), "z")), B = f["list_item"](self, __CONST[68], th), OP = "GT" }, th), B = f["logic_operation"](self, { A = f["logic_compare"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[66], th), list_index = 2 }, th), "z")), B = f["list_item"](self, __CONST[68], th), OP = "GT" }, th), B = f["logic_compare"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[66], th), list_index = 3 }, th), "z")), B = f["list_item"](self, __CONST[68], th), OP = "GT" }, th), type = "and" }, th), type = "and" }, th)) then
      f["variables_set"](self, { value = (th:call_proc(proc_3c9c20b2_d769_4078_a1ad_17c22dc12398, self, (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th), "+", f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th))), "+", f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th) }, th))), "÷", 3)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"Center\"}" }, th)
      f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["variables_get"](self, __CONST[16], th), "+", f["script_variables_value"](self, __CONST[69], th))), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"PlayerToFace\"}" }, th)
      if V.bool(f["logic_compare"](self, { A = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["script_variables_value"](self, __CONST[70], th), "·", f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th))), B = 0, OP = "LT" }, th)) then
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[66], th), list_item_value = (th:call_proc(proc_39724f16_b2c7_4602_ac79_bb54591d8512, self, f["script_variables_value"](self, __CONST[70], th), nil, nil)) }, th)
        f["variables_set"](self, { value = f["math_round"](self, { num = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[66], th), list_index = 4 }, th), "z")), B = f["list_item"](self, __CONST[71], th), type = "divide" }, th), type = "round_up" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TV\"}" }, th)
        if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[72], th), B = 0, OP = "GT" }, th)) then
          f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = "77c087a7-d013-436a-97dd-e3c7fec94e42", list_index = f["script_variables_value"](self, __CONST[72], th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"D\"}" }, th)
          f["list_append"](self, { list = f["script_variables_value"](self, __CONST[73], th), list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th) }, th) }, th)
          f["list_append"](self, { list = f["script_variables_value"](self, __CONST[73], th), list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th) }, th)
          f["list_append"](self, { list = f["script_variables_value"](self, __CONST[73], th), list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th) }, th)
          f["list_copy"](self, { list = f["script_variables_value"](self, __CONST[73], th), target_list = f["list_item"](self, { item = "any", list = "77c087a7-d013-436a-97dd-e3c7fec94e42", list_index = f["script_variables_value"](self, __CONST[72], th) }, th) }, th)
          f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = "75252e77-1193-4409-885c-ae4e74b8d706", list_index = f["script_variables_value"](self, __CONST[72], th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"D\"}" }, th)
          f["list_append"](self, { list = f["script_variables_value"](self, __CONST[73], th), list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 1, type = "add" }, th) }, th) }, th)
          f["list_append"](self, { list = f["script_variables_value"](self, __CONST[73], th), list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 2, type = "add" }, th) }, th) }, th)
          f["list_append"](self, { list = f["script_variables_value"](self, __CONST[73], th), list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[3], th), list_index = f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th) }, th) }, th)
          f["list_copy"](self, { list = f["script_variables_value"](self, __CONST[73], th), target_list = f["list_item"](self, { item = "any", list = "75252e77-1193-4409-885c-ae4e74b8d706", list_index = f["script_variables_value"](self, __CONST[72], th) }, th) }, th)
        end
      end
    end
  end
  th:call_proc(proc_9a2e870d_2f28_4733_b1c0_6674045360d2, self, f["math_arithmetic"](self, { A = p_i, B = 3, type = "add" }, th), p_m, p_v, p_n, nil, nil, nil, nil, nil, nil, nil)
end

proc_9b910ab5_89ee_4abc_82e3_58aa8f16ae0b = function(th, self, p_______1, p_______2)
  -- 过程「79cfef5e-6777-4e2e-b4a9-2c60c7348795」 id=9b910ab5-89ee-4abc-82e3-58aa8f16ae0b
  return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "y")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "z")), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "z")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "y")), type = "multiply" }, th), type = "minus" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "z")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "x")), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "x")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "z")), type = "multiply" }, th), type = "minus" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "x")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "y")), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "y")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "x")), type = "multiply" }, th), type = "minus" }, th)))
end

proc_a42a95c2_5f51_4ef7_8a12_9e8485d7c3a1 = function(th, self, p_point, p_pos, p_rot, p_scale)
  -- 过程「5d027cf1-d75a-4a57-abf1-cfd7343b8820」 id=a42a95c2-5f51-4ef7-8a12-9e8485d7c3a1
  f["script_variables"](self, __CONST[74], th)
  f["variables_set"](self, { value = p_point, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"V\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["script_variables_value"](self, __CONST[65], th), "分量相乘", p_scale)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"V\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 1, 0, 0)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"left\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 1, 0)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"UP\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 1)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"Forward\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["script_variables_value"](self, __CONST[75], th), f["script_variables_value"](self, __CONST[76], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_rot, "y")), nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"left\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["script_variables_value"](self, __CONST[77], th), f["script_variables_value"](self, __CONST[76], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_rot, "y")), nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"Forward\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["script_variables_value"](self, __CONST[76], th), f["script_variables_value"](self, __CONST[75], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_rot, "x")), nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"UP\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["script_variables_value"](self, __CONST[77], th), f["script_variables_value"](self, __CONST[75], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_rot, "x")), nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"Forward\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["script_variables_value"](self, __CONST[76], th), f["script_variables_value"](self, __CONST[77], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_rot, "z")), nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"UP\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["script_variables_value"](self, __CONST[75], th), f["script_variables_value"](self, __CONST[77], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_rot, "z")), nil, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"left\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, (th:call_proc(proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314, self, f["script_variables_value"](self, __CONST[75], th), f["script_variables_value"](self, __CONST[65], th))), (th:call_proc(proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314, self, f["script_variables_value"](self, __CONST[76], th), f["script_variables_value"](self, __CONST[65], th))), (th:call_proc(proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314, self, f["script_variables_value"](self, __CONST[77], th), f["script_variables_value"](self, __CONST[65], th))))), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"V\"}" }, th)
  f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["script_variables_value"](self, __CONST[65], th), "+", p_pos)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"V\"}" }, th)
  f["variables_set"](self, { value = p_pos, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"poS\"}" }, th)
  f["variables_set"](self, { value = p_rot, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"roT\"}" }, th)
  f["variables_set"](self, { value = p_scale, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"scalE\"}" }, th)
  return f["script_variables_value"](self, __CONST[65], th)
end

proc_a46aca3a_6fdb_4f2c_ad23_5a0f0cbf31d1 = function(th, self, p_Quaternion_1, p_Quaternion_2)
  -- 过程「12ef0f77-6e19-4f09-b04b-3aaef4395868」 id=a46aca3a-6fdb-4f2c-ad23-5a0f0cbf31d1
  return (th:call_proc(proc_13168c38_70dd_4aba_9887_a9e97a422947, self, f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "w", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "x", nil)), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "x", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "w", nil)), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "y", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "z", nil)), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "z", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "y", nil)), type = "multiply" }, th), type = "minus" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "w", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "y", nil)), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "x", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "z", nil)), type = "multiply" }, th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "y", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "w", nil)), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "z", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "x", nil)), type = "multiply" }, th), type = "add" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "w", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "z", nil)), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "x", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "y", nil)), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "y", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "x", nil)), type = "multiply" }, th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "z", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "w", nil)), type = "multiply" }, th), type = "add" }, th), f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "w", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "w", nil)), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "x", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "x", nil)), type = "multiply" }, th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "y", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "y", nil)), type = "multiply" }, th), type = "minus" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_1, "z", nil)), B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Quaternion_2, "z", nil)), type = "multiply" }, th), type = "minus" }, th)))
end

proc_b5b4895e_8503_4e5c_9d81_3be099bcaaa3 = function(th, self, p_Rotating_axis, p_Rotation_angle)
  -- 过程「77769d96-75d5-4f2a-a787-94ee365b7065」 id=b5b4895e-8503-4e5c-9d81-3be099bcaaa3
  return (th:call_proc(proc_13168c38_70dd_4aba_9887_a9e97a422947, self, f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = p_Rotation_angle, B = 0.5, type = "multiply" }, th), type = "sin" }, th), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_Rotating_axis, "x")), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = p_Rotation_angle, B = 0.5, type = "multiply" }, th), type = "sin" }, th), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_Rotating_axis, "y")), type = "multiply" }, th), f["math_arithmetic"](self, { A = f["math_trig"](self, { num = f["math_arithmetic"](self, { A = p_Rotation_angle, B = 0.5, type = "multiply" }, th), type = "sin" }, th), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_Rotating_axis, "z")), type = "multiply" }, th), f["math_trig"](self, { num = f["math_arithmetic"](self, { A = p_Rotation_angle, B = 0.5, type = "multiply" }, th), type = "cos" }, th)))
end

proc_bfd30caf_86be_455d_804e_e640f4d19b22 = function(th, self, p_______1, p__________, p_______2)
  -- 过程「cb1e9cba-1610-4884-aae6-ec7b477a576d」 id=bfd30caf-86be-455d-804e-e640f4d19b22
  f["script_variables"](self, __CONST[78], th)
  f["variables_set"](self, { value = p_______1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 2 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
  f["variables_set"](self, { value = p_______2, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"d\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 2 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"e\"}" }, th)
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[18], th), B = f["script_variables_value"](self, __CONST[79], th), OP = "EQ" }, th), B = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[10], th), B = f["script_variables_value"](self, __CONST[80], th), OP = "EQ" }, th), type = "and" }, th)) then
    f["variables_set"](self, __CONST[81], th)
    f["variables_set"](self, __CONST[82], th)
    f["variables_set"](self, __CONST[83], th)
    th:warp_enter()
    do
      local _times_n1 = f["script_variables_value"](self, __CONST[18], th)
      while true do
        if _times_n1 <= 0 then break end
        _times_n1 = _times_n1 - 1
        f["variables_set"](self, __CONST[84], th)
        do
          local _times_n2 = f["script_variables_value"](self, __CONST[10], th)
          while true do
            if _times_n2 <= 0 then break end
            _times_n2 = _times_n2 - 1
            if V.bool(f["logic_compare"](self, { A = p__________, B = "+", OP = "EQ" }, th)) then
              f["variables_set"](self, { value = f["math_arithmetic"](self, { A = (th:call_proc(proc_25eb1a3c_1143_4810_8b9b_8b70b66623f0, self, p_______1, f["script_variables_value"](self, __CONST[85], th), f["script_variables_value"](self, __CONST[86], th), nil, nil, nil)), B = (th:call_proc(proc_25eb1a3c_1143_4810_8b9b_8b70b66623f0, self, p_______2, f["script_variables_value"](self, __CONST[85], th), f["script_variables_value"](self, __CONST[86], th), nil, nil, nil)), type = "add" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
            else
              f["variables_set"](self, { value = f["math_arithmetic"](self, { A = (th:call_proc(proc_25eb1a3c_1143_4810_8b9b_8b70b66623f0, self, p_______1, f["script_variables_value"](self, __CONST[85], th), f["script_variables_value"](self, __CONST[86], th), nil, nil, nil)), B = (th:call_proc(proc_25eb1a3c_1143_4810_8b9b_8b70b66623f0, self, p_______2, f["script_variables_value"](self, __CONST[85], th), f["script_variables_value"](self, __CONST[86], th), nil, nil, nil)), type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"h\"}" }, th)
            end
            if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[87], th), B = 0, OP = "EQ" }, th)) then
              f["variables_set"](self, { value = f["script_variables_value"](self, __CONST[88], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"i\"}" }, th)
            else
              f["variables_set"](self, { value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, __CONST[89], th), ADD1 = "/", ADD2 = f["script_variables_value"](self, __CONST[88], th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"i\"}" }, th)
            end
            f["change_variables"](self, __CONST[90], th)
            f["change_variables"](self, __CONST[91], th)
            if th:iter_w() then break end
          end
        end
        f["change_variables"](self, __CONST[92], th)
        if th:iter_w() then break end
      end
    end
    th:warp_exit()
    return f["text_split"](self, { SPLIT_TEXT = "/", TEXT_TO_SPLIT = f["text_join"](self, { ADD0 = f["script_variables_value"](self, __CONST[18], th), ADD1 = "/", ADD2 = f["script_variables_value"](self, __CONST[10], th), ADD3 = "/", ADD4 = f["script_variables_value"](self, __CONST[89], th) }, th) }, th)
  else
    return "NULL"
  end
end

proc_c05ef9a4_b3ec_411b_b123_8db1e1c93314 = function(th, self, p_______2, p_______1)
  -- 过程「22ed2f7f-3aec-46fb-8d60-6bbc24a0ac35」 id=c05ef9a4-b3ec-411b-b123-8db1e1c93314
  return f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "x")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "x")), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "y")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "y")), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______2, "z")), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______1, "z")), type = "multiply" }, th), type = "add" }, th), type = "add" }, th)
end

proc_c2df4a0c_8c09_4534_8937_87f85a716c67 = function(th, self, p_point, p_Aixon, p_Angle)
  -- 过程「3966d224-80b1-4049-bef0-8b71f679e5ba」 id=c2df4a0c-8c09-4534-8937-87f85a716c67
  f["script_variables"](self, __CONST[8], th)
  f["variables_set"](self, { value = (th:call_proc(proc_5da275ed_e91e_42fa_8ff4_4ee6fc5cc737, self, p_point, p_Aixon, p_Angle, nil, nil)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
  return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["script_variables_value"](self, __CONST[10], th), "x")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["script_variables_value"](self, __CONST[10], th), "y")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["script_variables_value"](self, __CONST[10], th), "z"))))
end

proc_c97a9d91_e7f5_446c_aae1_850e4984162a = function(th, self, p_______1, p_______2)
  -- 过程「55557d1a-4fc5-4c0a-8324-070d65c52d09」 id=c97a9d91-e7f5-446c-aae1-850e4984162a
  f["script_variables"](self, __CONST[93], th)
  f["variables_set"](self, { value = p_______1, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 1 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"b\"}" }, th)
  f["variables_set"](self, { value = p_______2, variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"c\"}" }, th)
  f["variables_set"](self, { value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[9], th), list_index = 2 }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"d\"}" }, th)
  if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[18], th), B = f["script_variables_value"](self, __CONST[79], th), OP = "EQ" }, th)) then
    f["variables_set"](self, { value = f["text_join"](self, { ADD0 = f["script_variables_value"](self, __CONST[18], th), ADD1 = "/", ADD2 = f["script_variables_value"](self, __CONST[79], th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"e\"}" }, th)
    th:warp_enter()
    do
      local _times_n1 = f["script_variables_value"](self, __CONST[79], th)
      while true do
        if _times_n1 <= 0 then break end
        _times_n1 = _times_n1 - 1
        do
          local _times_n2 = f["script_variables_value"](self, __CONST[18], th)
          while true do
            if _times_n2 <= 0 then break end
            _times_n2 = _times_n2 - 1
            f["variables_set"](self, __CONST[84], th)
            f["variables_set"](self, __CONST[83], th)
            f["variables_set"](self, __CONST[94], th)
            if th:iter_w() then break end
          end
        end
        if th:iter_w() then break end
      end
    end
    th:warp_exit()
    return f["script_variables_value"](self, __CONST[80], th)
  else
    return "NULL"
  end
end

proc_cebf04d3_6819_4d68_9e40_2fe721fe12c1 = function(th, self, p_Q)
  -- 过程「230a5db8-acc6-429b-af9e-88951146f3d1」 id=cebf04d3-6819-4d68-9e40-2fe721fe12c1
  return (th:call_proc(proc_13168c38_70dd_4aba_9887_a9e97a422947, self, f["math_arithmetic"](self, { A = 0, B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Q, "x", nil)), type = "minus" }, th), f["math_arithmetic"](self, { A = 0, B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Q, "y", nil)), type = "minus" }, th), f["math_arithmetic"](self, { A = 0, B = (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Q, "z", nil)), type = "minus" }, th), (th:call_proc(proc_323b89af_4955_4747_b2a7_121710a35c21, self, p_Q, "w", nil))))
end

proc_d1c574d8_6c6a_4b21_a732_1feb6c2695f4 = function(th, self, p_______)
  -- 过程「58bfac32-0dd7-42ca-831e-4902b2c1ca49」 id=d1c574d8-6c6a-4b21-a732-1feb6c2695f4
  return f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______, "x")), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______, "y")), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______, "z")), B = 2, type = "power" }, th), type = "add" }, th), type = "add" }, th), type = "0" }, th)
end

proc_d90f4280_efc2_4020_a06d_32d5e70f46a9 = function(th, self, p_data, p_bool, p_use_materials_, p_scale, p_pos, p_rot, p_scale_2)
  -- 过程「5fab4194-f9e7-4c1a-9a08-df2d1aca3139」 id=d90f4280-efc2-4020-a06d-32d5e70f46a9
  f["script_variables"](self, __CONST[95], th)
  th:warp_enter()
  f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = " ", TEXT_TO_SPLIT = p_data }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"FileData\"}" }, th)
  f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"VertexData\"}" }, th)
  f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"NormalsData\"}" }, th)
  f["delete_list_item"](self, __CONST[96], th)
  f["delete_list_item"](self, __CONST[97], th)
  f["variables_set"](self, __CONST[98], th)
  f["variables_set"](self, __CONST[99], th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["list_length"](self, __CONST[100], th), B = 4, type = "divide" }, th), variable = "f8d600f4-76d0-48c9-968a-2a99f6cc1a91" }, th)
  while true do
    if f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = f["list_length"](self, { list = f["script_variables_value"](self, __CONST[101], th) }, th), OP = "GT" }, th) then break end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["script_variables_value"](self, __CONST[89], th) }, th), B = "o", OP = "EQ" }, th)) then
      if V.bool(f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[102], th), B = 0, OP = "GT" }, th)) then
        f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TempData\"}" }, th)
        f["list_copy"](self, { list = "90722e9b-8041-445d-a7ab-f8779112f5be", target_list = f["script_variables_value"](self, __CONST[103], th) }, th)
        f["list_copy"](self, { list = f["script_variables_value"](self, __CONST[103], th), target_list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[102], th), B = f["variables_get"](self, __CONST[104], th), type = "add" }, th), B = 4, type = "multiply" }, th), B = 4, type = "minus" }, th), B = 3, type = "add" }, th) }, th) }, th)
        f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TempData\"}" }, th)
        f["list_copy"](self, { list = "83b72b06-11ed-4ac1-9242-3aff5c906ad1", target_list = f["script_variables_value"](self, __CONST[103], th) }, th)
        f["list_copy"](self, { list = f["script_variables_value"](self, __CONST[103], th), target_list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[102], th), B = f["variables_get"](self, __CONST[104], th), type = "add" }, th), B = 4, type = "multiply" }, th), B = 4, type = "minus" }, th), B = 4, type = "add" }, th) }, th) }, th)
      end
      f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"VertexData\"}" }, th)
      f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"NormalsData\"}" }, th)
      f["delete_list_item"](self, __CONST[96], th)
      f["delete_list_item"](self, __CONST[97], th)
      f["list_append"](self, { list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_item_value = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 1, type = "add" }, th) }, th) }, th)
      f["list_append"](self, { list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_item_value = f["text_split"](self, __CONST[64], th) }, th)
      f["list_append"](self, { list = f["list_item"](self, __CONST[105], th), list_item_value = p_pos }, th)
      f["list_append"](self, { list = f["list_item"](self, __CONST[105], th), list_item_value = p_rot }, th)
      f["list_append"](self, { list = f["list_item"](self, __CONST[105], th), list_item_value = p_scale_2 }, th)
      f["list_append"](self, { list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_item_value = f["text_split"](self, __CONST[64], th) }, th)
      f["list_append"](self, { list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_item_value = f["text_split"](self, __CONST[64], th) }, th)
      f["change_variables"](self, __CONST[106], th)
      f["change_variables"](self, __CONST[107], th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["script_variables_value"](self, __CONST[89], th) }, th), B = "v", OP = "EQ" }, th)) then
      f["list_append"](self, { list = f["script_variables_value"](self, __CONST[108], th), list_item_value = f["math_arithmetic"](self, { A = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 1, type = "add" }, th) }, th), type = "number" }, th), B = p_scale, type = "multiply" }, th) }, th)
      f["list_append"](self, { list = f["script_variables_value"](self, __CONST[108], th), list_item_value = f["math_arithmetic"](self, { A = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 2, type = "add" }, th) }, th), type = "number" }, th), B = p_scale, type = "multiply" }, th) }, th)
      f["list_append"](self, { list = f["script_variables_value"](self, __CONST[108], th), list_item_value = f["math_arithmetic"](self, { A = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 3, type = "add" }, th) }, th), type = "number" }, th), B = p_scale, type = "multiply" }, th) }, th)
      f["change_variables"](self, __CONST[109], th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["script_variables_value"](self, __CONST[89], th) }, th), B = "vn", OP = "EQ" }, th)) then
      if V.bool(f["logic_compare"](self, { A = p_bool, B = "true", OP = "EQ" }, th)) then
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[110], th), list_item_value = f["math_arithmetic"](self, { A = 0, B = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 1, type = "add" }, th) }, th), type = "number" }, th), type = "minus" }, th) }, th)
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[110], th), list_item_value = f["math_arithmetic"](self, { A = 0, B = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 2, type = "add" }, th) }, th), type = "number" }, th), type = "minus" }, th) }, th)
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[110], th), list_item_value = f["math_arithmetic"](self, { A = 0, B = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 3, type = "add" }, th) }, th), type = "number" }, th), type = "minus" }, th) }, th)
      else
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[110], th), list_item_value = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 1, type = "add" }, th) }, th), type = "number" }, th) }, th)
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[110], th), list_item_value = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 2, type = "add" }, th) }, th), type = "number" }, th) }, th)
        f["list_append"](self, { list = f["script_variables_value"](self, __CONST[110], th), list_item_value = f["convert_type"](self, { text = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 3, type = "add" }, th) }, th), type = "number" }, th) }, th)
      end
      f["change_variables"](self, __CONST[109], th)
    end
    if V.bool(f["logic_compare"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["script_variables_value"](self, __CONST[89], th) }, th), B = "f", OP = "EQ" }, th)) then
      f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = "/", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 1, type = "add" }, th) }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TempData\"}" }, th)
      f["list_append"](self, { list = "90722e9b-8041-445d-a7ab-f8779112f5be", list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 3, type = "add" }, th) }, th))) }, th)
      f["list_append"](self, { list = "83b72b06-11ed-4ac1-9242-3aff5c906ad1", list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 3, type = "add" }, th) }, th))) }, th)
      f["change_variables"](self, __CONST[107], th)
      f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = "/", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 1, type = "add" }, th) }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TempData\"}" }, th)
      f["list_append"](self, { list = "90722e9b-8041-445d-a7ab-f8779112f5be", list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 3, type = "add" }, th) }, th))) }, th)
      f["list_append"](self, { list = "83b72b06-11ed-4ac1-9242-3aff5c906ad1", list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 3, type = "add" }, th) }, th))) }, th)
      f["change_variables"](self, __CONST[107], th)
      f["variables_set"](self, { value = f["text_split"](self, { SPLIT_TEXT = "/", TEXT_TO_SPLIT = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[101], th), list_index = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[89], th), B = 1, type = "add" }, th) }, th) }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TempData\"}" }, th)
      f["list_append"](self, { list = "90722e9b-8041-445d-a7ab-f8779112f5be", list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[108], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 1 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 3, type = "add" }, th) }, th))) }, th)
      f["list_append"](self, { list = "83b72b06-11ed-4ac1-9242-3aff5c906ad1", list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 1, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 2, type = "add" }, th) }, th), f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[110], th), list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[103], th), list_index = 3 }, th), B = 3, type = "multiply" }, th), B = 3, type = "minus" }, th), B = 3, type = "add" }, th) }, th))) }, th)
      f["change_variables"](self, __CONST[107], th)
    end
    f["change_variables"](self, __CONST[107], th)
    if th:iter_w() then break end
  end
  f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TempData\"}" }, th)
  f["list_copy"](self, { list = "90722e9b-8041-445d-a7ab-f8779112f5be", target_list = f["script_variables_value"](self, __CONST[103], th) }, th)
  f["list_copy"](self, { list = f["script_variables_value"](self, __CONST[103], th), target_list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[102], th), B = f["variables_get"](self, __CONST[104], th), type = "add" }, th), B = 4, type = "multiply" }, th), B = 4, type = "minus" }, th), B = 3, type = "add" }, th) }, th) }, th)
  f["variables_set"](self, { value = f["text_split"](self, __CONST[64], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"TempData\"}" }, th)
  f["list_copy"](self, { list = "83b72b06-11ed-4ac1-9242-3aff5c906ad1", target_list = f["script_variables_value"](self, __CONST[103], th) }, th)
  f["list_copy"](self, { list = f["script_variables_value"](self, __CONST[103], th), target_list = f["list_item"](self, { item = "any", list = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", list_index = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[102], th), B = f["variables_get"](self, __CONST[104], th), type = "add" }, th), B = 4, type = "multiply" }, th), B = 4, type = "minus" }, th), B = 4, type = "add" }, th) }, th) }, th)
  th:warp_exit()
end

proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38 = function(th, self, p_x, p_y, p_z)
  -- 过程「20ce51b5-0ce8-4404-b5ed-40edf9993158」 id=dd3c272c-ab07-4ce5-a979-0ff74fcbfd38
  return f["temporary_list"](self, { ITEM0 = p_x, ITEM1 = p_y, ITEM2 = p_z }, th)
end

proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c = function(th, self, p_______, p__________)
  -- 过程「4c1ed2fe-5557-4c3a-90db-b7f1e2147eec」 id=e37ab5f8-b825-435b-b8b3-d1df3cf0e96c
  if V.bool(f["logic_compare"](self, { A = p__________, B = "x", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_______, list_index = 1 }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p__________, B = "y", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_______, list_index = 2 }, th)
  end
  if V.bool(f["logic_compare"](self, { A = p__________, B = "z", OP = "EQ" }, th)) then
    return f["list_item"](self, { item = "any", list = p_______, list_index = 3 }, th)
  end
  return "NULL"
end

proc_e51153fc_c41f_4e03_8975_119bc01c026f = function(th, self, p_point, p_point1, p_point2, p__________)
  -- 过程「ccc9be18-5538-4871-bb93-0ce3cc0ac4b7」 id=e51153fc-c41f-4e03-8975-119bc01c026f
  f["script_variables"](self, __CONST[111], th)
  f["variables_set"](self, { value = f["text_split"](self, __CONST[112], th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"V\"}" }, th)
  f["replace_list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 1, list_item_value = (th:call_proc(proc_39724f16_b2c7_4602_ac79_bb54591d8512, self, p_point, nil, nil)) }, th)
  f["replace_list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 2, list_item_value = (th:call_proc(proc_39724f16_b2c7_4602_ac79_bb54591d8512, self, p_point1, nil, nil)) }, th)
  f["replace_list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 3, list_item_value = (th:call_proc(proc_39724f16_b2c7_4602_ac79_bb54591d8512, self, p_point2, nil, nil)) }, th)
  f["replace_list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 4, list_item_value = (th:call_proc(proc_f973718d_379f_4fb6_be87_8a62e4e57a1d, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 1 }, th))) }, th)
  f["replace_list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 5, list_item_value = (th:call_proc(proc_f973718d_379f_4fb6_be87_8a62e4e57a1d, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 2 }, th))) }, th)
  f["replace_list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 6, list_item_value = (th:call_proc(proc_f973718d_379f_4fb6_be87_8a62e4e57a1d, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 3 }, th))) }, th)
  if V.bool(f["logic_compare"](self, { A = p__________, B = "2rt", OP = "EQ" }, th)) then
    th:call_proc(proc_7a1bf8a6_b5bf_4770_96f4_7c2f75400f51, self, 100, (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 4 }, th), "x")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 4 }, th), "y")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 5 }, th), "x")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 5 }, th), "y")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 6 }, th), "x")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 6 }, th), "y")), nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil)
  elseif V.bool(f["logic_compare"](self, { A = p__________, B = "k2t", OP = "EQ" }, th)) then
    th:call_proc(proc_600a1ec6_d86c_447c_b61c_2edbced387cf, self, (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 4 }, th), "x")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 4 }, th), "y")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 5 }, th), "x")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 5 }, th), "y")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 6 }, th), "x")), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 6 }, th), "y")), 0)
  else
    th:call_proc(proc_19425881_cb03_458f_a034_bffcb21918fc, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 1 }, th))
    f["self_pen_down"](self, {}, th)
    th:call_proc(proc_19425881_cb03_458f_a034_bffcb21918fc, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 2 }, th))
    th:call_proc(proc_19425881_cb03_458f_a034_bffcb21918fc, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 3 }, th))
    th:call_proc(proc_19425881_cb03_458f_a034_bffcb21918fc, self, f["list_item"](self, { item = "any", list = f["script_variables_value"](self, __CONST[65], th), list_index = 1 }, th))
    f["self_pen_up"](self, {}, th)
  end
end

proc_eade72c3_56a6_4a3f_954e_e790fbd1efbe = function(th, self, p_xA, p_yA, p_xB, p_yB, p_xC, p_yC)
  -- 过程「9992272c-4a0e-46bd-8efd-66f887fa7dab」 id=eade72c3-56a6-4a3f-954e-e790fbd1efbe
  f["script_variables"](self, __CONST[113], th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xC, B = p_xB, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ux\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yC, B = p_yB, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uy\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xA, B = p_xB, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vx\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yA, B = p_yB, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vy\"}" }, th)
  f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[114], th), B = f["script_variables_value"](self, __CONST[115], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[116], th), B = f["script_variables_value"](self, __CONST[117], th), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[114], th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[116], th), B = 2, type = "power" }, th), type = "add" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"t\"}" }, th)
  if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = 0, B = f["script_variables_value"](self, __CONST[118], th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[118], th), B = 1, OP = "LTE" }, th), type = "and" }, th)) then
    return f["temporary_list"](self, { ITEM0 = f["math_arithmetic"](self, { A = p_xB, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[118], th), B = f["script_variables_value"](self, __CONST[114], th), type = "multiply" }, th), type = "add" }, th), ITEM1 = f["math_arithmetic"](self, { A = p_yB, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[118], th), B = f["script_variables_value"](self, __CONST[116], th), type = "multiply" }, th), type = "add" }, th), ITEM2 = 1 }, th)
  else
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xC, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ux\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yC, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uy\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vx\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vy\"}" }, th)
    f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[114], th), B = f["script_variables_value"](self, __CONST[115], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[116], th), B = f["script_variables_value"](self, __CONST[117], th), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[114], th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[116], th), B = 2, type = "power" }, th), type = "add" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"t\"}" }, th)
    if V.bool(f["logic_operation"](self, { A = f["logic_compare"](self, { A = 0, B = f["script_variables_value"](self, __CONST[118], th), OP = "LTE" }, th), B = f["logic_compare"](self, { A = f["script_variables_value"](self, __CONST[118], th), B = 1, OP = "LTE" }, th), type = "and" }, th)) then
      return f["temporary_list"](self, { ITEM0 = f["math_arithmetic"](self, { A = p_xA, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[118], th), B = f["script_variables_value"](self, __CONST[114], th), type = "multiply" }, th), type = "add" }, th), ITEM1 = f["math_arithmetic"](self, { A = p_yA, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[118], th), B = f["script_variables_value"](self, __CONST[116], th), type = "multiply" }, th), type = "add" }, th), ITEM2 = 2 }, th)
    else
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xB, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"ux\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yB, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"uy\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_xC, B = p_xA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vx\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = p_yC, B = p_yA, type = "minus" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"vy\"}" }, th)
      f["variables_set"](self, { value = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[114], th), B = f["script_variables_value"](self, __CONST[115], th), type = "multiply" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[116], th), B = f["script_variables_value"](self, __CONST[117], th), type = "multiply" }, th), type = "add" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[114], th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[116], th), B = 2, type = "power" }, th), type = "add" }, th), type = "divide" }, th), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"t\"}" }, th)
      return f["temporary_list"](self, { ITEM0 = f["math_arithmetic"](self, { A = p_xA, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[118], th), B = f["script_variables_value"](self, __CONST[114], th), type = "multiply" }, th), type = "add" }, th), ITEM1 = f["math_arithmetic"](self, { A = p_yA, B = f["math_arithmetic"](self, { A = f["script_variables_value"](self, __CONST[118], th), B = f["script_variables_value"](self, __CONST[116], th), type = "multiply" }, th), type = "add" }, th), ITEM2 = 3 }, th)
    end
  end
end

proc_f280440d_6a36_4d3c_b1ad_84932e6bdb6f = function(th, self, p_______)
  -- 过程「e23bc4d0-6d81-4863-857f-74998839ec5c」 id=f280440d-6a36-4d3c-b1ad-84932e6bdb6f
  f["script_variables"](self, __CONST[14], th)
  f["variables_set"](self, { value = (th:call_proc(proc_d1c574d8_6c6a_4b21_a732_1feb6c2695f4, self, p_______)), variable = "{\"type\":\"NEKO_SCRIPT_VARIABLE_TYPE-957f2554-87af\",\"name\":\"a\"}" }, th)
  return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______, "x")), B = f["script_variables_value"](self, __CONST[9], th), type = "divide" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______, "y")), B = f["script_variables_value"](self, __CONST[9], th), type = "divide" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_______, "z")), B = f["script_variables_value"](self, __CONST[9], th), type = "divide" }, th)))
end

proc_f973718d_379f_4fb6_be87_8a62e4e57a1d = function(th, self, p_point)
  -- 过程「dfa2d0ee-9bdf-4ce2-90fa-6d956c757fcc」 id=f973718d-379f-4fb6-be87-8a62e4e57a1d
  return (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "x")), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[7], th), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "z")), type = "divide" }, th), type = "multiply" }, th), f["math_arithmetic"](self, { A = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "y")), B = f["math_arithmetic"](self, { A = f["variables_get"](self, __CONST[7], th), B = (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, p_point, "z")), type = "divide" }, th), type = "multiply" }, th), 0))
end

proc_ff44a914_6440_4aa4_8de8_94816b1cb99b = function(th, self, p_x1, p_y1, p_x2, p_y2)
  -- 过程「5447c10a-34a6-468c-97ec-a155197129af」 id=ff44a914-6440-4aa4-8de8-94816b1cb99b
  return f["math_function"](self, { num = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_x1, B = p_x2, type = "minus" }, th), B = 2, type = "power" }, th), B = f["math_arithmetic"](self, { A = f["math_arithmetic"](self, { A = p_y1, B = p_y2, type = "minus" }, th), B = 2, type = "power" }, th), type = "add" }, th), type = "0" }, th)
end

-- ===== 作品元数据 =====
M.stage_w, M.stage_h = 900, 562
M.timer_pos = { x = 720, y = 12 }
M.proc_trampoline = true
M.uses_timer = false
M.timer_hidden_default = false
M.vars = { { current_entity_id = "", cv_id = "", entity_name = "", id = "04385cbb-f792-4b08-b241-119237712080", is_global = true, name = "LayerID", order = 34, position = { x = 689, y = 87 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "05780ef1-4861-47e9-bb26-3f5ace27939e", is_global = true, name = "TempModelVexter", order = 42, position = { x = 204, y = 423 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "0647b32f-df58-4eed-8fa4-1ae2ecd20ba1", is_global = true, name = "tir7", order = 18, position = { x = 620, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "09fb0e59-33a9-4451-962c-99c31629aed6", is_global = true, name = "tir6", order = 17, position = { x = 420, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "0af8cae4-5992-44c2-8b69-7233ca3bec60", is_global = true, name = "@PlayerMaxir", order = 8, position = { x = 220, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "18f0690a-82d5-421e-bcf0-b3b1266bf202", is_global = true, name = "T", order = 35, position = { x = 4, y = 458 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "23b75969-8369-4fb7-a609-42cf79e8a152", is_global = true, name = "count", order = 11, position = { x = 420, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "25871aa6-5966-4243-baed-8a27e065947b", is_global = true, name = "t", order = 10, position = { x = 420, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "28f99bee-4a87-4523-9352-aeecb495ae18", is_global = true, name = "diff", order = 38, position = { x = 204, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "2af408db-9054-4750-b86e-63e22e562649", is_global = true, name = "l", order = 21, position = { x = 620, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "2fc93804-ce83-4ac0-a215-f5155714708a", is_global = true, name = "tir1", order = 12, position = { x = 420, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3266e7ef-ca6c-46dc-bc38-0aebfca0b8f2", is_global = true, name = "tir8", order = 19, position = { x = 620, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "33a6da8a-2fb3-4f54-8258-0d3c5ffabe07", is_global = true, name = "fps", order = 9, position = { x = 0, y = 510 }, scale = 1, style = "default", type = "any", value = 0, visible = true }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3c392a6f-25fc-4c05-af9b-7da1567646c2", is_global = true, name = "Gdot", order = 23, position = { x = 581, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "3e3b74b0-9e61-478f-85ac-15a7f6c101ea", is_global = true, name = "tir3", order = 14, position = { x = 420, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "505397b6-252b-4d12-b0a4-6794f4e84d57", is_global = true, name = "tir4", order = 15, position = { x = 420, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "51399ca3-e9e1-4435-a062-ed46fd069ed7", is_global = true, name = "Delta", order = 27, position = { x = 741, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "5bdcdfb8-e0e8-4af8-b3a0-45675ad942e2", is_global = true, name = "~Global OBJ Models Data", order = 0, position = { x = 20, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "65e34b24-e5c6-4851-b0c1-aa7e680c1ae5", is_global = true, name = "Rdot", order = 22, position = { x = 581, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6b50b874-ddbe-4ce1-bd3f-74ec1fda9105", is_global = true, name = "RenderSetting", order = 33, position = { x = 689, y = 20 }, scale = 1, style = "default", type = "list", value = { 0.1, 2000, 10 }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6eee7660-ab97-467f-9f1d-fd126c721df1", is_global = true, name = "tir9", order = 20, position = { x = 620, y = 154 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "6f30cf55-883c-4bb1-ad95-ddb9ffe9a9e0", is_global = true, name = "Cmax", order = 25, position = { x = 741, y = 20 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "73fb6ae3-b812-44a1-ae63-3a2b057bb0f0", is_global = true, name = "@FOV", order = 6, position = { x = 20, y = 423 }, scale = 1, style = "default", type = "any", value = 250, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "75252e77-1193-4409-885c-ae4e74b8d706", is_global = true, name = "TempData", order = 36, position = { x = 204, y = 20 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "77c087a7-d013-436a-97dd-e3c7fec94e42", is_global = true, name = "TempLayerID", order = 32, position = { x = 657, y = 490 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "7c677497-1062-4b55-820f-4dd24ed90bf4", is_global = true, name = "S", order = 29, position = { x = 741, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "83b72b06-11ed-4ac1-9242-3aff5c906ad1", is_global = true, name = "~Global Tirangle Normals Data", order = 3, position = { x = 20, y = 221 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "88e605f6-6f5a-47f1-94dd-3b926b5febd7", is_global = true, name = "Bdot", order = 24, position = { x = 581, y = 490 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "90722e9b-8041-445d-a7ab-f8779112f5be", is_global = true, name = "~Global Triangle Vertex Data", order = 2, position = { x = 20, y = 154 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "94e83d69-d7cc-428d-8e88-887e214d95d3", is_global = true, name = "Data", order = 37, position = { x = 204, y = 87 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ad1ef0f4-e46e-4492-b4c0-ebfb2f5a74d2", is_global = true, name = "@PlayerRotation", order = 5, position = { x = 20, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "114a4455-ec96-46b1-8af5-4f5677ffe332", cv_id = "", entity_name = "LoadOBJ", id = "c00d63a7-1980-4b16-ba9a-9aeb0b912cfc", is_global = false, name = "Face", order = 1, position = { x = 20, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "c42a513f-272a-4056-bf96-95513b923068", is_global = true, name = "tir2", order = 13, position = { x = 420, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ca595afb-231b-4fcc-9018-9a62f871ad30", is_global = true, name = "Cmin", order = 26, position = { x = 741, y = 87 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "ced11fa8-04b5-41b6-bb60-81a891b29e7f", is_global = true, name = "@太阳向量", order = 40, position = { x = 204, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "d00c0961-13f1-4bd2-9da3-878218f8f86f", is_global = true, name = "@PlayerPosition", order = 4, position = { x = 20, y = 288 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "d0a5b40e-c61a-48c6-8e1a-1b2d71c86be8", is_global = true, name = "V", order = 30, position = { x = 741, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "d93bd865-3cdc-4875-a945-09a58c510593", is_global = true, name = "RenderTirangle", order = 31, position = { x = 657, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "d9d927d4-5b41-4dfc-b6ac-825a9181c90a", is_global = true, name = "H", order = 28, position = { x = 741, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "e201d814-aadc-43dc-9f70-3bf7d4edc54b", is_global = true, name = "RenderTirangleNomals", order = 39, position = { x = 204, y = 221 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "e598a57f-6507-4a24-aa41-19f8167a1556", is_global = true, name = "@CameraMaxir", order = 7, position = { x = 20, y = 490 }, scale = 1, style = "default", type = "list", value = {  }, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "eff2f806-0093-4c70-914b-e2fbf090bccd", is_global = true, name = "tir5", order = 16, position = { x = 420, y = 423 }, scale = 1, style = "default", type = "any", value = 0, visible = false }, { current_entity_id = "", cv_id = "", entity_name = "", id = "f8d600f4-76d0-48c9-968a-2a99f6cc1a91", is_global = true, name = "~MODEL", order = 41, position = { x = 204, y = 356 }, scale = 1, style = "default", type = "any", value = 0, visible = false } }
M.screens = { { id = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a", name = "背景", screenName = "屏幕", style_index = 2, styles = { "c61b6d9c-b977-4331-b984-1e6a6344fd6a", "ea7ccdf3-cf80-4452-9f35-76ea8bf58410" }, visible = true } }
M.cur_scene = "700824a5-44a8-4d03-a7e8-aa95d87e9b2a"
M.actors = { { id = "114a4455-ec96-46b1-8af5-4f5677ffe332", is_global = true, name = "LoadOBJ", order = 1, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "ec5443e5-8581-434c-9eac-1f008e6a3944" }, visible = false, x = 0, y = 0 }, { id = "ad90c8b5-9a64-4432-ada4-939d1b8ab341", is_global = true, name = "vec/Max", order = 2, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "16d62393-0852-4660-8b45-6217c18247c0" }, visible = false, x = 0, y = -50 }, { id = "6623fbb3-5c43-4b88-8414-794f8fbdfe69", is_global = true, name = "Main", order = 3, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 2, styles = { "28c0c18c-8ba2-4679-ba7d-0feb27cfd426", "50bafb50-6b99-42d7-8921-1ff9e354e425" }, visible = false, x = 0, y = 0 }, { id = "0c78a0bb-4eca-4908-bdca-f1df70afeb68", is_global = true, name = "Render", order = 4, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "f21028b7-4861-4a77-ac05-c13512fbfd30" }, visible = false, x = 0, y = 0 }, { id = "bd5fb280-1106-49f2-a60f-76aadaaad913", is_global = true, name = "camera", order = 5, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "0aa715fb-e6c4-4d75-bd39-23a5a6753e52" }, visible = false, x = 0, y = 0 }, { id = "3561b200-c6c3-44a7-be89-db8d50281861", is_global = true, name = "Texture Triangle", order = 6, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 2, styles = { "796a7498-e012-4354-8623-5981e646f396", "94cd5eff-333e-4efd-b58d-91c2375ae80a", "429b154a-bb57-4ba1-a935-766b6c3f992e", "0bad4278-d55b-49bc-9f5d-603d141df7da", "ba1587c8-d2f6-498c-82fd-52a69fdc250e" }, visible = false, x = 0, y = 0 }, { id = "9adae53e-c5cb-4d60-aa5d-c80ba5ebde93", is_global = true, name = "三角形处理", order = 7, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "f6685259-31bd-416d-95a4-e92e2aad9163" }, visible = false, x = 0, y = 0 }, { id = "cab6a17e-5744-41f2-9468-1bb6ee7b8f4e", is_global = true, name = "顶点处理", order = 8, rotation = 0, scale_x = 1, scale_y = 1, scenes = { "700824a5-44a8-4d03-a7e8-aa95d87e9b2a" }, style_index = 1, styles = { "ed861641-efb5-40dd-8c97-e710d4d0d4db" }, visible = false, x = 0, y = 0 } }
M.assets_dir = "works"
M.assets = { ["0aa715fb-e6c4-4d75-bd39-23a5a6753e52"] = { adaption = nil, center = nil, file = "assets/0aa715fb-e6c4-4d75-bd39-23a5a6753e52.png", id = "0aa715fb-e6c4-4d75-bd39-23a5a6753e52", name = "", styleType = nil, url = "https://static.codemao.cn/963/ttx/aigc/creation/2026/08/IRj7epyH.png" }, ["0bad4278-d55b-49bc-9f5d-603d141df7da"] = { adaption = nil, center = nil, file = "assets/0bad4278-d55b-49bc-9f5d-603d141df7da.png", id = "0bad4278-d55b-49bc-9f5d-603d141df7da", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fu52WkwFqMDQi_ZtZnLg7w3GlKFf?imageView2/0/format/png" }, ["16d62393-0852-4660-8b45-6217c18247c0"] = { adaption = nil, center = nil, file = "assets/16d62393-0852-4660-8b45-6217c18247c0.png", id = "16d62393-0852-4660-8b45-6217c18247c0", name = "地图", styleType = nil, url = "https://creation.codemao.cn/396/d33fe6a922fd4def816cb501e77b1dee.png" }, ["28c0c18c-8ba2-4679-ba7d-0feb27cfd426"] = { adaption = nil, center = nil, file = "assets/28c0c18c-8ba2-4679-ba7d-0feb27cfd426.png", id = "28c0c18c-8ba2-4679-ba7d-0feb27cfd426", name = "像素编程猫", styleType = nil, url = "https://creation.codemao.cn/396/de5a7ed139bf42419bd0db82d9c85f47.png" }, ["429b154a-bb57-4ba1-a935-766b6c3f992e"] = { adaption = nil, center = nil, file = "assets/429b154a-bb57-4ba1-a935-766b6c3f992e.png", id = "429b154a-bb57-4ba1-a935-766b6c3f992e", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fs2Jznz_V2His7DcrT6rmGs18dct?imageView2/0/format/png" }, ["50bafb50-6b99-42d7-8921-1ff9e354e425"] = { adaption = nil, center = nil, file = "assets/50bafb50-6b99-42d7-8921-1ff9e354e425.png", id = "50bafb50-6b99-42d7-8921-1ff9e354e425", name = "", styleType = nil, url = "https://static.codemao.cn/963/ttx/aigc/creation/2026/08/0ynELPSD.png" }, ["796a7498-e012-4354-8623-5981e646f396"] = { adaption = nil, center = nil, file = "assets/796a7498-e012-4354-8623-5981e646f396.png", id = "796a7498-e012-4354-8623-5981e646f396", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FpOksz2-wBJ_GYaf65baQ4PQQ_pg?imageView2/0/format/png" }, ["94cd5eff-333e-4efd-b58d-91c2375ae80a"] = { adaption = nil, center = nil, file = "assets/94cd5eff-333e-4efd-b58d-91c2375ae80a.png", id = "94cd5eff-333e-4efd-b58d-91c2375ae80a", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/FgZ8ZTWqaqI2W-a9zNKcoB39Kqgl?imageView2/0/format/png" }, ["ba1587c8-d2f6-498c-82fd-52a69fdc250e"] = { adaption = nil, center = nil, file = "assets/ba1587c8-d2f6-498c-82fd-52a69fdc250e.png", id = "ba1587c8-d2f6-498c-82fd-52a69fdc250e", name = "Texture Triangle", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/Fu79B9yLWGJF7PAeOp8Pq7Pk-YQQ?imageView2/0/format/png" }, ["c61b6d9c-b977-4331-b984-1e6a6344fd6a"] = { adaption = nil, center = nil, file = "assets/c61b6d9c-b977-4331-b984-1e6a6344fd6a.png", id = "c61b6d9c-b977-4331-b984-1e6a6344fd6a", name = "背景", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/img_stage_defult_landscape.png" }, ["ea7ccdf3-cf80-4452-9f35-76ea8bf58410"] = { adaption = 0, center = { x = 148.82461463651, y = 150.82461463651 }, file = "assets/ea7ccdf3-cf80-4452-9f35-76ea8bf58410.png", id = "ea7ccdf3-cf80-4452-9f35-76ea8bf58410", name = "", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTM1MTQzNzA2OV8zMjczNTEzOTVfMTc4NzY0MTIwMDAwMF9GZzlwU2NrVUFwTjctcmVreGdSWW1OVlY3d2M0.svg" }, ["ec5443e5-8581-434c-9eac-1f008e6a3944"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/ec5443e5-8581-434c-9eac-1f008e6a3944.png", id = "ec5443e5-8581-434c-9eac-1f008e6a3944", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/922/user-files/d2ViXzIwMDJfMTM1MTQzNzA2OV8zMjczNTEzOTVfMTc4NzYzNDAwMDAwMF9GdGp4RkhfTmw1NXB5amxlY2E1aGpiY1dlQmFM.svg" }, ["ed861641-efb5-40dd-8c97-e710d4d0d4db"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/ed861641-efb5-40dd-8c97-e710d4d0d4db.png", id = "ed861641-efb5-40dd-8c97-e710d4d0d4db", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" }, ["f21028b7-4861-4a77-ac05-c13512fbfd30"] = { adaption = nil, center = nil, file = "assets/f21028b7-4861-4a77-ac05-c13512fbfd30.png", id = "f21028b7-4861-4a77-ac05-c13512fbfd30", name = "", styleType = nil, url = "https://static.codemao.cn/963/ttx/aigc/creation/2026/08/7Cmg5PTB.png" }, ["f6685259-31bd-416d-95a4-e92e2aad9163"] = { adaption = nil, center = { x = 0, y = 0 }, file = "assets/f6685259-31bd-416d-95a4-e92e2aad9163.png", id = "f6685259-31bd-416d-95a4-e92e2aad9163", name = "新角色", styleType = nil, url = "https://creation.bcmcdn.com/neko/assets/image/emptyFrame.png" } }
M.audios = {  }

function M.register(rt, game, ents)
  f = rt.f
  local e_700824a5_44a8_4d03_a7e8_aa95d87e9b2a = ents["700824a5-44a8-4d03-a7e8-aa95d87e9b2a"]
  local e_114a4455_ec96_46b1_8af5_4f5677ffe332 = ents["114a4455-ec96-46b1-8af5-4f5677ffe332"]
  local e_ad90c8b5_9a64_4432_ada4_939d1b8ab341 = ents["ad90c8b5-9a64-4432-ada4-939d1b8ab341"]
  local e_6623fbb3_5c43_4b88_8414_794f8fbdfe69 = ents["6623fbb3-5c43-4b88-8414-794f8fbdfe69"]
  local e_0c78a0bb_4eca_4908_bdca_f1df70afeb68 = ents["0c78a0bb-4eca-4908-bdca-f1df70afeb68"]
  local e_bd5fb280_1106_49f2_a60f_76aadaaad913 = ents["bd5fb280-1106-49f2-a60f-76aadaaad913"]
  local e_3561b200_c6c3_44a7_be89_db8d50281861 = ents["3561b200-c6c3-44a7-be89-db8d50281861"]
  local e_9adae53e_c5cb_4d60_aa5d_c80ba5ebde93 = ents["9adae53e-c5cb-4d60-aa5d-c80ba5ebde93"]
  local e_cab6a17e_5744_41f2_9468_1bb6ee7b8f4e = ents["cab6a17e-5744-41f2-9468-1bb6ee7b8f4e"]
  -- -------- 角色 LoadOBJ --------
  rt.on(e_114a4455_ec96_46b1_8af5_4f5677ffe332, "self_listen", { message = "Load OBJ" }, function(th, self)
      th:call_proc(proc_d90f4280_efc2_4020_a06d_32d5e70f46a9, self, "# Blender 4.0.2 # www.blender.org mtllib Cube.mtl o Cube v 1.000000 1.000000 -1.000000 v 1.000000 -1.000000 -1.000000 v 1.000000 1.000000 1.000000 v 1.000000 -1.000000 1.000000 v -1.000000 1.000000 -1.000000 v -1.000000 -1.000000 -1.000000 v -1.000000 1.000000 1.000000 v -1.000000 -1.000000 1.000000 vn -0.0000 1.0000 -0.0000 vn -0.0000 -0.0000 1.0000 vn -1.0000 -0.0000 -0.0000 vn -0.0000 -1.0000 -0.0000 vn 1.0000 -0.0000 -0.0000 vn -0.0000 -0.0000 -1.0000 vt 0.875000 0.500000 vt 0.625000 0.750000 vt 0.625000 0.500000 vt 0.375000 1.000000 vt 0.375000 0.750000 vt 0.625000 0.000000 vt 0.375000 0.250000 vt 0.375000 0.000000 vt 0.375000 0.500000 vt 0.125000 0.750000 vt 0.125000 0.500000 vt 0.625000 0.250000 vt 0.875000 0.750000 vt 0.625000 1.000000 s 0 usemtl Material f 5/1/1 3/2/1 1/3/1 f 3/2/2 8/4/2 4/5/2 f 7/6/3 6/7/3 8/8/3 f 2/9/4 8/10/4 6/11/4 f 1/3/5 4/5/5 2/9/5 f 5/12/6 2/9/6 6/7/6 f 5/1/1 7/13/1 3/2/1 f 3/2/2 7/14/2 8/4/2 f 7/6/3 5/12/3 6/7/3 f 2/9/4 4/5/4 8/10/4 f 1/3/5 3/2/5 4/5/5 f 5/12/6 1/3/6 2/9/6", "false", "true", 100, (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 300, 0, 0)), (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 0)), (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 1, 1, 1)), nil, nil, nil, nil, nil, nil, nil)
      th:call_proc(proc_d90f4280_efc2_4020_a06d_32d5e70f46a9, self, "# Blender 4.0.2 # www.blender.org mtllib Cube.mtl o Cube v 1.000000 1.000000 -1.000000 v 1.000000 -1.000000 -1.000000 v 1.000000 1.000000 1.000000 v 1.000000 -1.000000 1.000000 v -1.000000 1.000000 -1.000000 v -1.000000 -1.000000 -1.000000 v -1.000000 1.000000 1.000000 v -1.000000 -1.000000 1.000000 vn -0.0000 1.0000 -0.0000 vn -0.0000 -0.0000 1.0000 vn -1.0000 -0.0000 -0.0000 vn -0.0000 -1.0000 -0.0000 vn 1.0000 -0.0000 -0.0000 vn -0.0000 -0.0000 -1.0000 vt 0.875000 0.500000 vt 0.625000 0.750000 vt 0.625000 0.500000 vt 0.375000 1.000000 vt 0.375000 0.750000 vt 0.625000 0.000000 vt 0.375000 0.250000 vt 0.375000 0.000000 vt 0.375000 0.500000 vt 0.125000 0.750000 vt 0.125000 0.500000 vt 0.625000 0.250000 vt 0.875000 0.750000 vt 0.625000 1.000000 s 0 usemtl Material f 5/1/1 3/2/1 1/3/1 f 3/2/2 8/4/2 4/5/2 f 7/6/3 6/7/3 8/8/3 f 2/9/4 8/10/4 6/11/4 f 1/3/5 4/5/5 2/9/5 f 5/12/6 2/9/6 6/7/6 f 5/1/1 7/13/1 3/2/1 f 3/2/2 7/14/2 8/4/2 f 7/6/3 5/12/3 6/7/3 f 2/9/4 4/5/4 8/10/4 f 1/3/5 3/2/5 4/5/5 f 5/12/6 1/3/6 2/9/6", "false", "true", 100, (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 0)), (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 0)), (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 1, 1, 1)), nil, nil, nil, nil, nil, nil, nil)
  end)
  -- -------- 角色 Main --------
  rt.on(e_6623fbb3_5c43_4b88_8414_794f8fbdfe69, "on_running_group_activated", {}, function(th, self)
      f["self_broadcast_and_wait"](self, __CONST[119], th)
      f["variables_set"](self, { value = (th:call_proc(proc_f280440d_6a36_4d3c_b1ad_84932e6bdb6f, self, (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 150, -200)), nil)), variable = "ced11fa8-04b5-41b6-bb60-81a891b29e7f" }, th)
      f["variables_set"](self, { value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 0)), variable = "ad1ef0f4-e46e-4492-b4c0-ebfb2f5a74d2" }, th)
      f["variables_set"](self, { value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 300)), variable = "d00c0961-13f1-4bd2-9da3-878218f8f86f" }, th)
      f["self_broadcast_and_wait"](self, __CONST[120], th)
      f["self_broadcast"](self, __CONST[121], th)
      while true do
        f["self_broadcast"](self, __CONST[120], th)
        f["self_broadcast"](self, __CONST[122], th)
        if th:iter_n() then break end
      end
  end)
  rt.on(e_6623fbb3_5c43_4b88_8414_794f8fbdfe69, "self_listen", { message = "aa" }, function(th, self)
      while true do
        f["self_broadcast"](self, __CONST[123], th)
        f["self_broadcast"](self, __CONST[124], th)
        f["wait"](self, __CONST[125], th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 Render --------
  rt.on(e_0c78a0bb_4eca_4908_bdca_f1df70afeb68, "self_listen", { message = "render" }, function(th, self)
      f["clear_drawing"](self, {}, th)
      f["variables_set"](self, __CONST[126], th)
      th:call_proc(proc_74d5d8c1_7388_459f_ba8a_648a96ad0021, self, f["list_length"](self, __CONST[127], th), 0)
  end)
  -- -------- 角色 camera --------
  rt.on(e_bd5fb280_1106_49f2_a60f_76aadaaad913, "self_listen", { message = "Player" }, function(th, self)
      f["replace_list_item"](self, { item = "any", list = "0af8cae4-5992-44c2-8b69-7233ca3bec60", list_index = 1, list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 1, 0, 0)) }, th)
      f["replace_list_item"](self, { item = "any", list = "0af8cae4-5992-44c2-8b69-7233ca3bec60", list_index = 2, list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 1, 0)) }, th)
      f["replace_list_item"](self, { item = "any", list = "0af8cae4-5992-44c2-8b69-7233ca3bec60", list_index = 3, list_item_value = (th:call_proc(proc_dd3c272c_ab07_4ce5_a979_0ff74fcbfd38, self, 0, 0, 1)) }, th)
      f["replace_list_item"](self, { item = "any", list = "0af8cae4-5992-44c2-8b69-7233ca3bec60", list_index = 1, list_item_value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["list_item"](self, __CONST[128], th), f["list_item"](self, __CONST[129], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["variables_get"](self, __CONST[130], th), "y")), nil, nil, nil)) }, th)
      f["replace_list_item"](self, { item = "any", list = "0af8cae4-5992-44c2-8b69-7233ca3bec60", list_index = 3, list_item_value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["list_item"](self, __CONST[131], th), f["list_item"](self, __CONST[129], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["variables_get"](self, __CONST[130], th), "y")), nil, nil, nil)) }, th)
      if V.bool(f["check_key"](self, __CONST[132], th)) then
        f["replace_list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[130], th), list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[130], th), list_index = 1 }, th), B = 3, type = "minus" }, th) }, th)
      end
      if V.bool(f["check_key"](self, __CONST[133], th)) then
        f["replace_list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[130], th), list_index = 1, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[130], th), list_index = 1 }, th), B = 3, type = "add" }, th) }, th)
      end
      if V.bool(f["check_key"](self, __CONST[134], th)) then
        f["replace_list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[130], th), list_index = 2, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[130], th), list_index = 2 }, th), B = 3, type = "add" }, th) }, th)
      end
      if V.bool(f["check_key"](self, __CONST[135], th)) then
        f["replace_list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[130], th), list_index = 2, list_item_value = f["math_arithmetic"](self, { A = f["list_item"](self, { item = "any", list = f["variables_get"](self, __CONST[130], th), list_index = 2 }, th), B = 3, type = "minus" }, th) }, th)
      end
      if V.bool(f["check_key"](self, __CONST[136], th)) then
        f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["variables_get"](self, __CONST[16], th), "-", (th:call_proc(proc_3c9c20b2_d769_4078_a1ad_17c22dc12398, self, f["list_item"](self, __CONST[131], th), "×", 5)))), variable = "d00c0961-13f1-4bd2-9da3-878218f8f86f" }, th)
      end
      if V.bool(f["check_key"](self, __CONST[137], th)) then
        f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["variables_get"](self, __CONST[16], th), "+", (th:call_proc(proc_3c9c20b2_d769_4078_a1ad_17c22dc12398, self, f["list_item"](self, __CONST[131], th), "×", 5)))), variable = "d00c0961-13f1-4bd2-9da3-878218f8f86f" }, th)
      end
      if V.bool(f["check_key"](self, __CONST[138], th)) then
        f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["variables_get"](self, __CONST[16], th), "-", (th:call_proc(proc_3c9c20b2_d769_4078_a1ad_17c22dc12398, self, f["list_item"](self, __CONST[128], th), "×", 5)))), variable = "d00c0961-13f1-4bd2-9da3-878218f8f86f" }, th)
      end
      if V.bool(f["check_key"](self, __CONST[139], th)) then
        f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["variables_get"](self, __CONST[16], th), "+", (th:call_proc(proc_3c9c20b2_d769_4078_a1ad_17c22dc12398, self, f["list_item"](self, __CONST[128], th), "×", 5)))), variable = "d00c0961-13f1-4bd2-9da3-878218f8f86f" }, th)
      end
      if V.bool(f["check_key"](self, __CONST[140], th)) then
        f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["variables_get"](self, __CONST[16], th), "-", (th:call_proc(proc_3c9c20b2_d769_4078_a1ad_17c22dc12398, self, f["list_item"](self, __CONST[129], th), "×", 5)))), variable = "d00c0961-13f1-4bd2-9da3-878218f8f86f" }, th)
      end
      if V.bool(f["check_key"](self, __CONST[141], th)) then
        f["variables_set"](self, { value = (th:call_proc(proc_47cb41eb_a3e9_41ef_b486_14e4d136aad4, self, f["variables_get"](self, __CONST[16], th), "+", (th:call_proc(proc_3c9c20b2_d769_4078_a1ad_17c22dc12398, self, f["list_item"](self, __CONST[129], th), "×", 5)))), variable = "d00c0961-13f1-4bd2-9da3-878218f8f86f" }, th)
      end
      f["replace_list_item"](self, { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 1, list_item_value = f["list_item"](self, __CONST[128], th) }, th)
      f["replace_list_item"](self, { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 2, list_item_value = f["list_item"](self, __CONST[129], th) }, th)
      f["replace_list_item"](self, { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 3, list_item_value = f["list_item"](self, __CONST[131], th) }, th)
      f["replace_list_item"](self, { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 2, list_item_value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["list_item"](self, __CONST[19], th), f["list_item"](self, __CONST[128], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["variables_get"](self, __CONST[130], th), "x")), nil, nil, nil)) }, th)
      f["replace_list_item"](self, { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 3, list_item_value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["list_item"](self, __CONST[20], th), f["list_item"](self, __CONST[128], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["variables_get"](self, __CONST[130], th), "x")), nil, nil, nil)) }, th)
      f["replace_list_item"](self, { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 2, list_item_value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["list_item"](self, __CONST[19], th), f["list_item"](self, __CONST[131], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["variables_get"](self, __CONST[130], th), "z")), nil, nil, nil)) }, th)
      f["replace_list_item"](self, { item = "any", list = "e598a57f-6507-4a24-aa41-19f8167a1556", list_index = 1, list_item_value = (th:call_proc(proc_c2df4a0c_8c09_4534_8937_87f85a716c67, self, f["list_item"](self, __CONST[17], th), f["list_item"](self, __CONST[131], th), (th:call_proc(proc_e37ab5f8_b825_435b_b8b3_d1df3cf0e96c, self, f["variables_get"](self, __CONST[130], th), "z")), nil, nil, nil)) }, th)
  end)
  -- -------- 角色 Texture Triangle --------
  rt.on(e_3561b200_c6c3_44a7_be89_db8d50281861, "on_running_group_activated", {}, function(th, self)
      while true do
        f["variables_set"](self, { value = f["get_time"](self, __CONST[142], th), variable = "25871aa6-5966-4243-baed-8a27e065947b" }, th)
        while true do
          if f["logic_compare"](self, { A = f["variables_get"](self, __CONST[143], th), B = f["get_time"](self, __CONST[142], th), OP = "NEQ" }, th) then break end
          f["change_variables"](self, __CONST[144], th)
          if th:iter_n() then break end
        end
        f["variables_set"](self, { value = f["variables_get"](self, __CONST[145], th), variable = "33a6da8a-2fb3-4f54-8258-0d3c5ffabe07" }, th)
        f["variables_set"](self, __CONST[146], th)
        if th:iter_n() then break end
      end
  end)
  -- -------- 角色 三角形处理 --------
  rt.on(e_9adae53e_c5cb_4d60_aa5d_c80ba5ebde93, "self_listen", { message = "Tirangle" }, function(th, self)
      th:warp_enter()
      f["delete_list_item"](self, __CONST[147], th)
      do
        local _times_n1 = f["math_arithmetic"](self, { A = f["list_item"](self, __CONST[67], th), B = f["list_item"](self, __CONST[71], th), type = "divide" }, th)
        while true do
          if _times_n1 <= 0 then break end
          _times_n1 = _times_n1 - 1
          f["list_append"](self, { list = "77c087a7-d013-436a-97dd-e3c7fec94e42", list_item_value = f["text_split"](self, __CONST[64], th) }, th)
          f["list_append"](self, { list = "75252e77-1193-4409-885c-ae4e74b8d706", list_item_value = f["text_split"](self, __CONST[64], th) }, th)
          if th:iter_w() then break end
        end
      end
      th:call_proc(proc_007f6379_a304_4134_bb41_27ed4b237544, self, 0, f["list_length"](self, __CONST[100], th), nil, nil)
      f["list_copy"](self, __CONST[148], th)
      f["list_copy"](self, __CONST[149], th)
      th:warp_exit()
  end)
  -- -------- 角色 顶点处理 --------
  rt.on(e_cab6a17e_5744_41f2_9468_1bb6ee7b8f4e, "self_listen", { message = "Vertex" }, function(th, self)
      th:call_proc(proc_4979555a_1da0_47ca_8f4f_1aca5714d854, self, 0, f["list_length"](self, __CONST[100], th))
  end)
end

M.requires = {
  "change_variables",
  "check_key",
  "clear_drawing",
  "convert_type",
  "delete_list_item",
  "get_time",
  "image_stamp",
  "list_append",
  "list_copy",
  "list_item",
  "list_length",
  "logic_compare",
  "logic_operation",
  "math_arithmetic",
  "math_function",
  "math_modulo",
  "math_round",
  "math_trig",
  "replace_list_item",
  "script_variables",
  "script_variables_value",
  "self_broadcast",
  "self_broadcast_and_wait",
  "self_move_to",
  "self_pen_down",
  "self_pen_up",
  "self_point_towards",
  "self_set_effect",
  "self_set_pen_color_property",
  "self_set_pen_size",
  "set_width_height_scale",
  "temporary_list",
  "text_join",
  "text_split",
  "variables_get",
  "variables_set",
  "wait",
}
return M
