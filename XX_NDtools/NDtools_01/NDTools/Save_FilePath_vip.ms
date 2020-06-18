-- E-Mail : 738746223@qq.com
-- 自动添加时间和制作人标记
-- 文件命名规则 ： 以 _# 为分隔。前面的为正常手动命名，后面的为自动添加 后缀名
-- 自动后缀 为 时间标记加 VIP名字
-- 最好保持文件名类如： 110_o_盒子-skin_#2019.1.3_么么哒.max
(
TQ_anim_set = (getdir #maxroot+"scripts\\TQAnimationTool.ini") --本地版本记录文件
--setINISetting TQ_anim_set "VIP_name" "制作人" "么么哒"

temp_time = getLocalTime()
spacer_ = #(".","_","#","@","-")
PC_time = (temp_time[1] as string )+ spacer_[1]  + (temp_time[2] as string ) + spacer_[1]  + (temp_time[4] as string )

/*
try(destroyDialog rolloutName)catch()
rollout set_vip_name "设置制作人" width:210 height: 60
(
    group "阁下尊姓大名：" (
        edittext ed_name "" width:120 across:2 --height:35
        button btn_set "确定" width:50 height:20 offset:[16,-2]
    )
    on btn_set pressed do
    (
        if TQ_anim_set != undefined and ed_name.text != "" do (setINISetting TQ_anim_set "VIP_name" "制作人" ed_name.text)
    )
    on set_vip_name open do
    (
        if TQ_anim_set != undefined do (ed_name.text = getINISetting TQ_anim_set "VIP_name" "制作人" )
    )
)
*/

fn get_vip_name_ =
(
    temp_name = getINISetting TQ_anim_set "VIP_name" "制作人"
    if temp_name == "" then (
        try (
            return "么么哒"
            --fileIn (getdir #maxroot+"scripts\\NDTools\\CustomScript\\设置制作人setini_vip_name.ms")
            --createDialog set_vip_name
        )catch(); --get_vip_name_()
        -- ; -- messagebox "默认 : 么么哒" title:"未设置制作人名字"
    )
    else( return temp_name)
)
fn set_name_ str_name = --在文件名中检查分隔符
(
    find_spacer = findString str_name spacer_[3] --查找分隔符
    if find_spacer != undefined then
    (
        -- 如果分隔符模式符合
        if str_name[find_spacer - 1] == spacer_[2] then
        (
            new_name = substring str_name 1 (find_spacer - 2)
            return new_name
        )
        else
        (
            new_name = substring str_name 1 (find_spacer - 1)
            return new_name
        )
    )
    else(return str_name)
)

fn get_new_name_ = --在保存窗口中去掉时间制作人标记后缀
(
        if maxfilename == "" then
        (
            return _save = getmaxsavefilename filename:(maxfilepath+maxfilename)
        )
        else
        (
            old_name =getFilenameFile maxfilename --文件名
            _type = getFilenameType maxfilename --后缀名

            new_name = set_name_ old_name
            return _save = getmaxsavefilename filename:(maxfilepath + new_name + _type)
        )
)

fn set_auto_tag p_str = --添加时间制作人后缀
(

    _path = (getFilenamePath p_str)
    _old_name = set_name_ (getFilenameFile p_str)
    VIP_name = get_vip_name_()

    _name = _old_name + spacer_[2]+ spacer_[3] + PC_time + spacer_[2] + VIP_name
    _type = (getFilenameType p_str)
    return ( _path + _name + _type )
)

fn try_save_ =
(
    j_save = get_new_name_()
    if j_save!=undefined do
    (
        new_file = set_auto_tag j_save
        if (doesFileExist new_file) then ( messagebox "存在重名文件,不支持覆盖保存. 请重新命名.\r\n " title:"未保存";try_save_() )
        else
        (
            if (MaxVersion())[1] >= 17000 then(
                try (savemaxfile new_file saveAsVersion:2015)catch(savemaxfile new_file ) --保存为2015版本
            )
            else (savemaxfile new_file )
        )
    )
)

try (
    try_save_()
)catch()

)