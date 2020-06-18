try(destroyDialog rolloutName)catch()
rollout set_vip_name "设置制作人" width:210 height: 60
(

    group "阁下尊姓大名：" (
        edittext ed_name "" width:120 across:2 --height:35
        button btn_set "确定" width:50 height:20 offset:[16,-2]
    )
    local TQ_anim_set = (getdir #maxroot+"scripts\\TQAnimationTool.ini")
    on btn_set pressed do
    (
        if TQ_anim_set != undefined and ed_name.text != "" do (setINISetting TQ_anim_set "VIP_name" "制作人" ed_name.text)
    )
    on set_vip_name open do
    (
        if TQ_anim_set != undefined do (ed_name.text = getINISetting TQ_anim_set "VIP_name" "制作人" )
    )
)
createDialog set_vip_name