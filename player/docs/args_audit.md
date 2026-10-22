# 参数键审计（数据 vs 实现）

数据来源：`tests/fixtures/*.bcmkn` 里每个积木真实的 inputs/fields 键。
实现来源：`rt/impl/*.lua` 里 `args.<key>` 的读取。

## `ask_and_choose`（11 次）
- 数据里有、实现没读：`CHOICE0`, `CHOICE1`, `CHOICE2`, `CHOICE3`

## `get_orientation`（2 次）
- 数据里有、实现没读：`target`

## `list_copy`（15 次）
- 数据里有、实现没读：`target_list`

## `mirror`（25 次）
- 数据里有、实现没读：`target`

## `script_variables`（117 次）
- 数据里有、实现没读：`PARAMS1`, `PARAMS10`, `PARAMS11`, `PARAMS12`, `PARAMS2`, `PARAMS3`, `PARAMS4`, `PARAMS5`, `PARAMS6`, `PARAMS7`, `PARAMS8`, `PARAMS9`

## `show_hide_ranking`（2 次）
- 数据里有、实现没读：`ranking`

## `show_hide_timer`（7 次）
- 数据里有、实现没读：`showHide`

## `stamp`（58 次）
- 数据里有、实现没读：`align`

## `temporary_list`（644 次）
- 数据里有、实现没读：`ITEM0`, `ITEM1`, `ITEM10`, `ITEM11`, `ITEM12`, `ITEM13`, `ITEM14`, `ITEM15`, `ITEM16`, `ITEM2`, `ITEM3`, `ITEM4`, `ITEM5`, `ITEM6`, `ITEM7`, `ITEM8`, `ITEM9`

## `text_join`（226 次）
- 数据里有、实现没读：`ADD0`, `ADD1`, `ADD2`, `ADD3`, `ADD4`, `ADD5`, `ADD6`, `ADD7`, `ADD8`

## `text_select`（8 次）
- 数据里有、实现没读：`end_index`, `start_index`

## `update_ranking`（5 次）
- 数据里有、实现没读：`ranking`

## `user_info_of_th`（24 次）
- 数据里有、实现没读：`order`, `ranking`
