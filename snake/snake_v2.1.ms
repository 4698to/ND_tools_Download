--2018/07/14 by:4698to
--QQ :738746223
--https://github.com/4698to/Joetime.linetool.bar/tree/master/snake

rollout test "贪吃蛇v2.0"
(
    global she_box --蛇头
    global she_size = 25
    global she_dir = [0,she_size,0] --前进方向
    global she_body = #()--蛇身体
    global she_count = 1 --蛇长
    global food =#() --食物
    global food_size = 50 --食物大小
    global food_total = 20 --地图上食物量
    global view_camer

    label game_text ""
    button go_time "Go" --across:2 开始游戏
    button reset_game "Reset" --重新开始
    button stop_game "Stop" --停止游戏，不可恢复

    /*
    button go_up "↑"
    button go_r "←" across:2
    button go_l "→"
    button go_down "↓"
    */
    label game_success_0 "得分:" across:2
    label game_success "0"  offset:[0,0,0]--width:50 height:50

    timer clock "testClock" interval:75 active:false--tick once a second
    label test"1"

    dotNetControl dnControl "System.Windows.Forms.Control"
    local dnKeyboard = DotNetClass "System.Windows.Forms.Keys"
    ------------------------------------------------------------------
    fn map_view = --场景相机
    (
        view_camer = freeCamera()
        move view_camer [0,0,10500]
        viewport.setCamera view_camer
        (NitrousGraphicsManager.GetActiveViewportSetting()).VisualStyleMode =  #ConsistentColors
        max tool maximize
    )
    ------------------------------------------------------------------
    fn she_born = --蛇出生
    (
        she_box = box name:"snake"
        she_box.length = she_size
        she_box.width = she_size
        she_box.wirecolor = red
        she_body = #()
    )
    ------------------------------------------------------------------
    fn new_she_box = --蛇身体
    (
        a = copy she_box--box()
        --a.wirecolor = red
        append she_body a
        if she_body.count > she_count do
        (
            delete she_body[1]
            deleteItem she_body 1
        )
    )
    ------------------------------------------------------------------
    fn map_border = --地图
    (
        global life_border = box name:"map" --活动场
        life_border.length = 3600
        life_border.width = 6000
        life_border.boxmode =true
    )
    ------------------------------------------------------------------
    fn she_box_death_border = --检查是否出界
    (
        if (abs(she_box.pos[1]) >= 3000) or (abs(she_box.pos[2]) >= 1800 ) do
        (
            clock.active = false
            game_text.text = "You Death!"
        )
    )
    ------------------------------------------------------------------
    fn eat = --吃掉
    (
        food_count = food.count
        for i=1 to food_count do
        (try
            (
            tem_food = food[i]
            global food_x = sqrt((tem_food.pos[1] - she_box.pos[1])^2 + (tem_food.pos[2] - she_box.pos[2])^2)
            if food_x <= food_size do
            (
                delete tem_food
                she_count +=1 --吃一长一
                deleteItem food i
                --andom_food()
            )
            )catch()
        )

    )
    fn eat_self = --咬到自己
    (
        try
        (
            for i=3 to (she_count-3) do
            (
                global tem_she_body = she_body[i]
                global head_body = sqrt((tem_she_body.pos[1] - she_box.pos[1])^2 + (tem_she_body.pos[2] - she_box.pos[2])^2)
                if head_body < she_size do
                (
                    clock.active = false
                    game_text.text = "You Death!"
                )
            )
        )catch()
    )
    ------------------------------------------------------------------
    fn andom_food = --生成食物
    (
        local new_food = food_total - food.count
        for i=1 to new_food do
        (
            tem_pos = random [-3000,-1800,0]  [3000,1800,0]
            --p = box() --食物大小为默认的 25*25
            p = box length:food_size width:food_size
            p.pos = tem_pos
            append food p
        )
    )
    ------------------------------------------------------------------
    --键盘控制
    on dnControl KeyDown senderArg keyPressEventArgs do
    (
        KeyPressed = keyPressEventArgs.keyCode
        keyPressEventArgs.SuppressKeyPress = true

            if KeyPressed==dnKeyboard.a do
            (
                she_dir = [-she_size,0,0]
            )
            if KeyPressed==dnKeyboard.w do
            (
                she_dir = [0,she_size,0]
            )

            if KeyPressed==dnKeyboard.s do
            (
                she_dir = [0,-she_size,0]
            )
            if KeyPressed==dnKeyboard.d do
            (
                she_dir = [she_size,0,0]
            )
    )
    on dnKeys KeyUp senderArg keyPressEventArgs do
    (
        KeyPressed = undefined
    )
    ------------------------------------------------------------------
    fn success_text = --得分反馈
    (
       game_success.text =  (she_count - 1) as string
       she_size = ((she_count - 1)/10) * 5 + 25 --每得10分升级5点
    )
    ------------------------------------------------------------------
    fn game_start = --开始游戏
    (
        clock.active = true
        she_size = 25
        --dnControl.focus()
        if not (IsValidNode view_camer) do --设置场景相机
        (
            map_view()
        )

        map_border()--创建地图

        she_born()

        andom_food()
    )
    ------------------------------------------------------------------
    fn reset_map = --重置地图
    (
         clock.active = false --停止计时
         delete food;food = #() --食物
         delete she_body;she_body=#();she_count=1 --蛇身
         delete she_box;she_box = undefined --蛇头
         delete life_border;
         game_start()
    )
    ------------------------------------------------------------------
    /*
    on go_r pressed do
    (
        she_dir = [-25,0,0]
    )
    on go_l pressed do
    (
        she_dir = [25,0,0]
    )
    on go_up pressed do
    (
        she_dir = [0,25,0]
    )
    on go_down pressed do
    (
        she_dir = [0,-25,0]
    )
    */
    ------------------------------------------------------------------
    on go_time  pressed do
    (
        /*
        clock.active = true



        map_border()--创建地图

        she_born()

        andom_food()
        */
        game_start()
        --dnControl.focus()

    )
    on stop_game pressed do
    (
        clock.active = false
    )
    on reset_game pressed do
    (
         reset_map() --重新开始游戏
    )
    on clock tick do --游戏进程开始
    (
        dnControl.focus()
        valUp = (test.text as integer)+1
        test.text = valUp as string
        --she_box.pos = [(valUp*1),0,0]
        move she_box she_dir
        new_she_box()
        she_box_death_border()
        eat()
        success_text()
        andom_food()
        eat_self()
    )
)
createDialog test