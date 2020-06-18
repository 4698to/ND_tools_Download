--E-mail:738746223@qq.com
--UTF8
try(DestroyDialog mzpBuilder_Tools)catch()
rollout mzpBuilder_Tools "mzpBuilder"
(
    group "项目路径" (
        edittext en_folder ""
    )
    group "" (
    dotNetControl lv "System.Windows.Forms.ListView" width:600 height:300

    dropdownlist list_comm "" across:4 Width:86 align:#right offset:[99,0]
    dropdownlist list_dest_path "" Width:96 align:#right offset:[53,0]
    edittext en_dest_folder "" fieldWidth:220 height:22 align:#right offset:[130,0]
    button btn_do_ed_text "OK" width:20 height:22 align:#right offset:[7,0]

    --dotNetControl lv_rundrop "System.Windows.Forms.ListView" width:600 height:120


        combobox rundrop_comb "Run - Drop 语句" width:600 height:6 items:#("run","drop") offset:[0,-10]
    )
    --button btn_add_folder "添加文件夹"
    group "mzpBuilderZipList.tmp - mzp.run"
    (
        dotNetControl tmp_run_Path "System.Windows.Forms.ListView" width:600 height:65
        --edittext edtOutput_tmpPath "" fieldWidth:590 height:22 --across:2
    )
    group "" (
        edittext ed_pack_name "包名:" fieldWidth:320 across:2
        spinner ed_pack_ver "版本号:" range:[0,99,1]
        -- Group body.
    )
    group "mzp 输出" (
        edittext edtOutputFilePath "" fieldWidth:565 height:22 across:2
        button btn_open_out_path "..." width:20 height:22 align:#right
        button btnExportOutputFile "Export .mzp" width:595 height:32 enabled:false
        -- Group body.
    )
    local comm_text = #("copy","treeCopy")
    local dest_folder =#("$max","$scripts","$ui","$macroScripts","$plugins","$plugcfg")
    local Directorie = dotnetclass "System.IO.Directory";
    local file_info = dotnetclass "System.IO.File";
    local run_drop_command = #()
    local mzp_packname = "mzpBuilderName"
    local mzp_description = "Description"
    local mzp_version = 1.0
    --list_nodeClass = dotNetClass "System.Windows.Forms.ListViewItem"
    local sourcerootpath = undefined
    --@"C:\Users\Administrator\max_script\anim-layer-tools\animtaion_layer_toos\anim_layer_tools"
    local save_path_sour = undefined
    local arrSource_folder = #()
    fn set_en_folder str=
    (
        sourcerootpath = str ;en_folder.text = sourcerootpath
    )
    fn set_mzp_pack str =
    (
        mzp_packname = str
        ed_pack_name.text = mzp_packname
    )
    fn set_mzp_version str =
    (
        mzp_version = str ; ed_pack_ver.value = str as float
    )
    fn set_edtOutputFilePath str =
    (
        edtOutputFilePath.text = str
    )
    fn set_rundrop_comb str_arr =
    (
        run_drop_command = str_arr
        rundrop_comb.items = run_drop_command
        --try (rundrop_comb.selection = run_drop_command.count )catch()
    )
    fn setip_tmp_run_Path_listview =
    (
        tmp_run_Path.clear()
        tmp_run_Path.View = (dotNetClass "System.Windows.Forms.View").Details
        tmp_run_Path.fullRowSelect = true
        tmp_run_Path.gridLines = true
        tmp_run_Path.HideSelection=false
        tmp_run_Path.BorderStyle = lv.BorderStyle.FixedSingle
        tmp_run_Path.HeaderStyle=lv.HeaderStyle.Nonclickable
        tmp_run_Path.backColor=lv.backColor.FromArgb 225 225 225
        tmp_run_Path.Columns.add ".tem .run " 600

    )
    fn setupListView =
    (
        lv.clear()
        lv.View = (dotNetClass "System.Windows.Forms.View").Details
        lv.fullRowSelect = true
        lv.gridLines = true
        lv.HideSelection=false
        lv.BorderStyle = lv.BorderStyle.FixedSingle
        lv.HeaderStyle=lv.HeaderStyle.Nonclickable
        lv.backColor=lv.backColor.FromArgb 225 225 225

        lv.allowDrop = true

        lv.Columns.add "文件夹" 160
        lv.Columns.add "命令" 90
        lv.Columns.add "目标路径" 100
        lv.Columns.add "附加路径" 250
        --lv.Columns.add "Run drop" 40
        --lv.BeginUpdate()
        --lv.EndUpdate()

    )
    fn add_tmp_run =
    (

        tmp_run_Path.items.clear()
        tmp_run_Path.BeginUpdate()
        temp_file_run = #("mzpBuilderZipList.tmp","mzp.run") ;theRange = #()
        for i in temp_file_run do
        (
            if not (doesFileExist (sourcerootpath +"\\" + i )) do (Continue)
            li = dotNetObject "System.Windows.Forms.ListViewItem" (sourcerootpath +"\\" + i )
            li.BackColor = lv.backColor.FromArgb 229 166 215
            append theRange li
        )
        tmp_run_Path.Items.AddRange theRange
        tmp_run_Path.EndUpdate()

    )
    fn add_folder_lv_item arr_folder arr_files =
    (
        lv.items.clear()
        theRange = #()
        lv.BeginUpdate()
        for i in arr_folder do
        (
            --local flt04 = filterstring i "\\"
            local dirName =getFilenameFile i -- flt04[flt04.count]
            --parent_path_info = Directorie.GetParent i
            li = dotNetObject "System.Windows.Forms.ListViewItem" (dirName)
            li.BackColor = lv.backColor.FromArgb 225 198 87--(dotNetClass "System.Drawing.Color").yellow
            li.ToolTipText = i
            li.name = dirName --
            li.ImageKey = "folder"
            li.subitems.add "treeCopy"
            li.subitems.add "$max"
            li.subitems.add ""

            append theRange li
        )
        lv.Items.AddRange theRange
        theRange = #()
        for i in arr_files do
        (
            local fileName = getFilenameFile i
            local filetype = getFilenameType i
            if (filetype == ".run") or (filetype == ".mzp") or ( filetype == ".tmp")do Continue ;

            li = dotNetObject "System.Windows.Forms.ListViewItem" (fileName + filetype)
            li.BackColor = lv.backColor.FromArgb 153 228 214 -- (dotNetClass "System.Drawing.Color").DarkRed
            li.ToolTipText = i
            li.ImageKey = "files"
            li.name = (fileName + filetype)
            li.subitems.add "Copy"
            li.subitems.add "$max"
            li.subitems.add "scripts"
            append theRange li
        )
        lv.Items.AddRange theRange
        lv.EndUpdate()
    )
    fn new_lv_item arr_a arr_b arr_c arr_d =
    (
        lv.items.clear()
        theRange = #()
        lv.BeginUpdate()
        for i=1 to arr_a.count do
        (
            li = dotNetObject "System.Windows.Forms.ListViewItem" (arr_a[i])
            li.ToolTipText = sourcerootpath +"\\"+ (arr_a[i])
            if (getFilenameType (arr_a[i])) == "" then (
                li.BackColor = lv.backColor.FromArgb 225 198 87
                --li.name = arr_a[i]
                li.ImageKey =  "folder"
            )else(
                li.BackColor = lv.backColor.FromArgb 153 228 214
                --li.name = arr_a[i]
                li.ImageKey = "files"
            )
            li.name = arr_a[i]
            --dotNetObject "System.Object" "folder"
            li.subitems.add arr_b[i]
            li.subitems.add arr_c[i]
            li.subitems.add arr_d[i]
            append theRange li
        )
        lv.Items.AddRange theRange
        lv.EndUpdate()
        add_tmp_run()
    )
    fn remove_lv_select_item =
    (
        local selectedItems = lv.SelectedItems
        lv.BeginUpdate()
        if selectedItems.count > 0 do (
            for i = selectedItems.count - 1 to 0 by -1 do
            (
                try (
                local temp = selectedItems.item[i]
                if temp != undefined do ( temp.remove())
                )catch()
                --lv.Items.Remove(temp)
                --print temp.name
               -- append theRange temp.name
            )
        )

        lv.EndUpdate()
    )
    fn set_lv_item_comm_text lv_items str ind_ex =
    (
        for i=1 to lv_items.count do
        (
            local temp = i - 1
            local lvitem = lv_items.item[temp]

            local subitem =(lvitem.SubItems).item[ind_ex].text = str
            --subitem.text = str
        )
    )
    fn get_lv_item_comm_text =
    (
        local item_file = #()
        for i=1 to lv.Items.count do
        (
            local temp = i - 1
            local lvitem = lv.Items.item[temp]
            local item_str = #()
            for o = 0 to 3 do (
                local sub_item = lvitem.SubItems
                append item_str (sub_item.item[o].text)
            )
            append item_file item_str
            --subitem.text = str
        )
        return item_file
    )
    fn get_folder_and_files =
    (
        if sourcerootpath == undefined do (return false)
        arrSource_folder = Directorie.GetDirectories sourcerootpath
        all_dir = (dotnetclass "System.IO.SearchOption")
        arrSource_files  = Directorie.GetFiles sourcerootpath --"*" all_dir.AllDirectories
        add_folder_lv_item arrSource_folder arrSource_files
        add_tmp_run()
    )
    fn get_lv_item_files =
    (
        local temp_files = #()
        all_dir = (dotnetclass "System.IO.SearchOption")
        for i=1 to lv.Items.count do
        (

            local itemNode = lv.Items.item[(i - 1)]
            if itemNode.ImageKey == "folder" then (
            --if itemNode.name == "folder" then (

                local Source_files = Directorie.GetFiles itemNode.ToolTipText "*" all_dir.AllDirectories
                join temp_files Source_files
            )else(
                append temp_files itemNode.ToolTipText

            )

        )
        return temp_files
    )

    fn fn_writeRunFile  =
    (
        local arrSource = get_lv_item_comm_text()
        if arrSource.count == 0 do (return false)
        if sourcerootpath == undefined do (return false)
        local theRunFilePath = sourcerootpath +"\\" + "mzp.run"

        if doesFileExist theRunFilePath then (deleteFile theRunFilePath )else (makeDir (getFilenamePath  theRunFilePath))
        --delete old run file if it exists or create the targetdirectory

        local theRunFile = undefined
        try (theRunFile = createFile theRunFilePath)
        catch ((print "File: " + theRunFilePath + "cannot be created"); return false)

        --format the content to the file
        --THE HEADER

        format "name \"%\"\ndescription \"%\"\nversion %\n\n" mzp_packname mzp_description mzp_version to:theRunFile
        --ALL COPY-OPERATIONS
        for i = 1 to arrSource.count do (
            local arr_node = arrSource[i]
            format "% \"%\" to \"%\"\n" arr_node[2] arr_node[1]  (arr_node[3]+"\\"+arr_node[4]) to:theRunFile
        )
        format "\n" to:theRunFile
        --ALL DROP-OPERATIONS

        for i =1 to run_drop_command.count do
        (
            format "%\n" (run_drop_command[i]) to:theRunFile
        )
        /*
        for i in mzpBuilderStruct.dropIndices do
        (   --mzpBuilderStruct.arrDestination[i]
            format "run %\n" ( mzpBuilderStruct.arrDestination[i] + (filenameFromPath  mzpBuilderStruct.arrSource[i])) to:theRunFile
        )
        format "\n" to:theRunFile
        --ALL RUN-OPERATIONS
        for i in mzpBuilderStruct.runIndices do (
        format "drop %\n" (mzpBuilderStruct.arrDestination[i]+(filenameFromPath  mzpBuilderStruct.arrSource[i])) to:theRunFile
        )*/
        --CLEANING UP
        format "\nclear temp" to:theRunFile

        flush theRunFile
        close theRunFile
        print theRunFilePath
        --return the path to the listfile
        add_tmp_run()
        theRunFilePath
    )
    fn fn_makeZipList =
    (
        local arrPath = get_lv_item_files()
        if arrPath.count < 1 do (return false)
        if sourcerootpath == undefined do (return false)
        local theZipListPath = sourcerootpath +"\\"+ "mzpBuilderZipList.tmp" -- targetPath --need a path without any spaces!!
        if doesFileExist theZipListPath then deleteFile theZipListPath else makeDir (getFilenamePath  theZipListPath)-- delete old tmp file if it exists or create the folder

        local theZipList =undefined ;
        try (theZipList = createFile theZipListPath)
        catch (
            print ("File: " + theZipListPath + "cannot be created"); return false
        )
        for i in arrPath do
        (
            format "%\n" i to:theZipList
        )
        format "%\n" (sourcerootpath +"\\"+ "mzp.run") to:theZipList
        flush theZipList
        close theZipList
        add_tmp_run()
        --return the path to the listfile
        theZipListPath ;
    )
    fn fn_dateStamp =
    (

        local arrTime = getLocalTime()
        local theTime = "" as StringStream
        format "%-%-%" arrTime[1] (formattedprint arrTime[2] format:"02d") (formattedprint arrTime[4] format:"02d") to:theTime
        theTime as string
    )
    fn fn_zipFiles =
    (

        local theTempFilePath = sourcerootpath +"\\"+ "mzpBuilderZipList.tmp"
        if not (doesFileExist theTempFilePath )do (return false)

        local zipUtil = (getDir #maxRoot) + "maxzip.exe"

        local zipFilePath = sourcerootpath +"\\" +mzp_packname+ "_"+fn_dateStamp()+"_"+(mzp_version as string)+ ".mzp"
        if doesFileExist zipFilePath do (deleteFile zipFilePath )

        local cmd = "" as stringStream
        format "\"%\" \"%\" @%" zipUtil zipFilePath theTempFilePath to:cmd
         -- thanks to ofer_z--zipFile needs to be a mapped drive?

        local curDir = sysInfo.currentDir -- store current system dir
        sysInfo.currentDir = sourcerootpath-- set system folder (zip tree begins here)
        (hiddendosCommand cmd exitcode:&exitcode) --EXECUTE THE ZIPPING
        sysInfo.currentDir = curDir -- restore old system dir

        --output the code returned by maxzip. For a list of possible codes, check here: http://www.info-zip.org/mans/zip.html#DIAGNOSTICS
        if exitcode == 0 then exitcode = "normal"
        format "zip-status: % \n" exitcode

        --edtOutputFilePath.text =
        set_edtOutputFilePath zipFilePath
        zipFilePath --return the path of the zipfile
    )
    fn select_foleropen =
    (
        local select_foler = dotNetObject "System.Windows.Forms.FolderBrowserDialog"
        select_foler.RootFolder = (DotnetClass  "Environment+SpecialFolder").MyComputer
        select_foler.Description = " 请选择打包项目文件夹 ! "
        select_foler.ShowDialog()
        return select_foler.SelectedPath ;free select_foler ;
    )
    fn select_openfile pa_th =
    (
        if pa_th != undefined then (
            local temp_file = getOpenFileName caption:"打开 mzpBuilder 项目" filename:pa_th types:"ini file (*.ini)|*.ini"
        )else(
            local temp_file = getOpenFileName caption:"打开 mzpBuilder 项目" filename:"" types:"ini file (*.ini)|*.ini"
        )
        return temp_file
    )
    fn select_SaveFile pa_th =
    (
        if pa_th == undefined do (return undefined)
        local temp_file = getSaveFileName caption:"保存mzpBuilder 项目" filename:pa_th types:"ini file (*.ini)|*.ini"
        return temp_file
    )
    fn open_Project file_name =
    (
        if doesFileExist file_name do (
            local settingfile = file_name
            set_en_folder (getINISetting settingfile "config" "sourcerootpath")
            set_mzp_pack (getINISetting settingfile "config" "buildfilename")
            set_mzp_version (getINISetting settingfile "Header" "version" )
            --sourcerootpath = getINISetting settingfile "config" "buildfilepath"
            local arrSource = for n in (GetINISetting settingfile "Source") collect GetINISetting settingfile "Source" n
            local arrcommand = for n in (GetINISetting settingfile "Command") collect GetINISetting settingfile "Command" n
            local arrmaxpath = for n in (GetINISetting settingfile "Recognized_max") collect GetINISetting settingfile "Recognized_max" n
            local arr_enc = for n in (GetINISetting settingfile "Enclosure") collect GetINISetting settingfile "Enclosure" n
            local arrrundrop = for n in (GetINISetting settingfile "RunDrop") collect GetINISetting settingfile "RunDrop" n
            set_rundrop_comb arrrundrop
            if (arrSource.count == arrcommand.count) and (arrmaxpath.count == arr_enc.count) then (
                new_lv_item arrSource arrcommand arrmaxpath arr_enc
            )else(
                messageBox "该 .ini 不是 MzpBuilder 保存的项目配置文件..." title:"打开项目失败！"
            )
        )
    )
    fn save_Project file_name=
    (
        local settingfile = file_name --sourcerootpath + "\\" + "mzpBuilder_dome.ini"
        if doesFileExist settingfile do (try(deleteFile settingfile)catch())
        setINISetting settingfile "config" "sourcerootpath" sourcerootpath
        setINISetting settingfile "config" "buildfilename" mzp_packname
        setINISetting settingfile "config" "buildfilepath" sourcerootpath
        setINISetting settingfile "Header" "version" (mzp_version as string)
        local arrSource = get_lv_item_comm_text()
        for i=1 to arrSource.count do (
            local arr_node = arrSource[i]
            setINISetting settingfile "Source" (i as string ) arr_node[1]
            setINISetting settingfile "Destination" (i as string ) (arr_node[3]+"\\"+arr_node[4])
            setINISetting settingfile "Command" (i as string ) arr_node[2]
            setINISetting settingfile "Recognized_max" (i as string ) arr_node[3]
            setINISetting settingfile "Enclosure" (i as string ) arr_node[4]
        )
        for i=1 to run_drop_command.count do
        (
            setINISetting settingfile "RunDrop" (i as string) run_drop_command[i]
        )
    )
    fn set_select_lv_item_rundrop type =
    (
        local selectedItems = lv.SelectedItems
        if selectedItems.count > 0 do (
            local temp = selectedItems.item[0]
            if temp.ImageKey == "folder" do (return false)
            local item_str = #()
            for o = 0 to 3 do (
                local sub_item = temp.SubItems
                append item_str (sub_item.item[o].text)
            )
            local type_command = "run "
            if type == 2 do (type_command = "drop " )
            temp_run = type_command + item_str[3]+"\\"+item_str[4] + "\\" +item_str[1]
            append run_drop_command temp_run
            set_rundrop_comb run_drop_command
        )

    )
    fn remove_rundrop =
    (
        if run_drop_command.count > 0  do
        (
            deleteItem run_drop_command mzpBuilder_Tools.rundrop_comb.selection
            set_rundrop_comb run_drop_command

        )
    )
    on rundrop_comb entered arg do
    (
        run_drop_command[(rundrop_comb.selection)] = arg
        set_rundrop_comb run_drop_command
    )
    on en_folder entered arg do
    (
        if arg != "" do( sourcerootpath = en_folder.text ;print sourcerootpath)

    )

    on mzpBuilder_Tools close do (
        try(
        free mzpBuilder_toolsMenu ;mzpBuilder_toolsMenu = undefined
        free mzpBuilder_Tools;mzpBuilder_Tools = undefined
        )catch()
    )
    on mzpBuilder_Tools open do (
        list_comm.items=comm_text ; list_dest_path.items = dest_folder
        setip_tmp_run_Path_listview()
        setupListView()
        --en_folder.text = @"C:\Users\Administrator\max_script\anim-layer-tools\animtaion_layer_toos\anim_layer_tools"
        --ed_pack_name.text = mzp_packname
    )
    on lv SelectedIndexChanged do (
        --print (lv.SelectedItems.count )
    )
    on ed_pack_name changed arg do
    (
        set_mzp_pack arg
        --mzp_packname = arg
    )
    on ed_pack_ver changed arg do
    (
        set_mzp_version arg
    )
    on list_comm selected arg do
    (
        if lv.SelectedItems.count > 0 do (
            set_lv_item_comm_text lv.SelectedItems (list_comm.selected) 1
        )
    )
    on list_dest_path selected arg do
    (
        if lv.SelectedItems.count > 0 do (
            set_lv_item_comm_text lv.SelectedItems (list_dest_path.selected) 2
        )
    )
    on btn_do_ed_text pressed do
    (
        --if en_dest_folder.text != "" do
        --(
            set_lv_item_comm_text lv.SelectedItems (en_dest_folder.text) 3
        --)
    )
    on btnExportOutputFile pressed do
    (
        if sourcerootpath != undefined do (
            local temp_file = sourcerootpath +"\\"+ "mzpBuilderZipList.tmp"
            local temp_run = sourcerootpath +"\\"+"mzp.run"
            fn_makeZipList() ; fn_writeRunFile()
            if doesFileExist temp_file and doesFileExist temp_run do
            (
                mzpBuilder_Tools.fn_zipFiles()
            )
        )
    )
)
--------------------------------------------------------
    rcmenu mzpBuilder_toolsMenu
    (
        subMenu "项目"
        (
            menuItem miProjectNew "新建..."
            menuItem miProjectOpen "打开..." --enabled:false
            --separator spProject1
            --menuItem miProjectImport "Import..." enabled:false
            separator spProject2
            menuItem miProjectSave "保存"
            menuItem miProjectSaveAs "另保存..." --enabled:false
             --enabled:false

        )
        subMenu "资源"
        (
            menuItem miFilesAddSourceFiles "重新加载资源..."
            menuItem miFilesdeleSourceFiles "移除资源..."
           -- separator spFiles1

        )
        subMenu "Run Drop"
        (
            menuItem miFilesAdd_run "添加 Run 语句"
            menuItem miFilesAdd_drop "添加 Drop 语句"
            separator spProject1
            menuItem miFilesdele_run "移除 Run Drop 语句"
        )
        subMenu "打包"
        (
            menuItem Export_tem_Folder "生成 mzpBuilderZipList.tmp"
            menuItem Export_mzprun_Folder "生成 mzp.run "
            menuItem Export_mzppack_Folder "打包 mzp"
        )
        subMenu "帮助"
        (
            menuItem htmp_mzpbuilder "Help"
        )
        on miProjectNew picked do (
            local select_foler = mzpBuilder_Tools.select_foleropen()
            if select_foler != "" do
            (
                mzpBuilder_Tools.set_en_folder select_foler
                mzpBuilder_Tools.get_folder_and_files()
                mzpBuilder_Tools.set_mzp_pack "mzpBuilderName"
                mzpBuilder_Tools.set_mzp_version 1.0
                mzpBuilder_Tools.set_edtOutputFilePath ""
                mzpBuilder_Tools.set_rundrop_comb #()
            )
            --free select_foler;
        )
        on miFilesAddSourceFiles picked do ( mzpBuilder_Tools.get_folder_and_files())
        on miFilesdeleSourceFiles picked do
        (
            mzpBuilder_Tools.remove_lv_select_item()
        )
        on Export_tem_Folder picked do (
            mzpBuilder_Tools.fn_makeZipList()
        )
        on Export_mzprun_Folder picked do
        (
            mzpBuilder_Tools.fn_writeRunFile()
        )
        on Export_mzppack_Folder picked do
        (
            mzpBuilder_Tools.fn_zipFiles()
        )
        on miFilesAdd_run picked do (
            mzpBuilder_Tools.set_select_lv_item_rundrop 1
        )
        on miFilesAdd_drop picked do (
            mzpBuilder_Tools.set_select_lv_item_rundrop 2
        )
        on miFilesdele_run picked do
        (
            mzpBuilder_Tools.remove_rundrop()
        )
        on miProjectOpen picked do
        (
            --open_Project
            local temp_ini = mzpBuilder_Tools.select_openfile mzpBuilder_Tools.save_path_sour
            if temp_ini != undefined do (
                mzpBuilder_Tools.open_Project temp_ini

                mzpBuilder_Tools.save_path_sour = temp_ini
            )
        )
        on miProjectSave picked do
        (
            if mzpBuilder_Tools.save_path_sour != undefined  then
            (
                mzpBuilder_Tools.save_Project mzpBuilder_Tools.save_path_sour
                mzpBuilder_Tools.title = "mzpBuilder"+" => "+ mzpBuilder_Tools.save_path_sour
            )else(
                if mzpBuilder_Tools.sourcerootpath != undefined do (
                local temp_ini = mzpBuilder_Tools.select_SaveFile (mzpBuilder_Tools.sourcerootpath +"\\"+ "NewMzpBuillder.ini")
                if temp_ini != undefined do ( mzpBuilder_Tools.save_Project temp_ini
                    mzpBuilder_Tools.save_path_sour = temp_ini
                    mzpBuilder_Tools.title = "mzpBuilder"+" => "+ temp_ini
                )
                )
            )
        )
        on miProjectSaveAs picked do
        (
            if mzpBuilder_Tools.sourcerootpath != undefined do (
            local temp_ini = mzpBuilder_Tools.select_SaveFile (mzpBuilder_Tools.sourcerootpath +"\\"+ "NewMzpBuillder.ini")
            if temp_ini != undefined do ( mzpBuilder_Tools.save_Project temp_ini
                mzpBuilder_Tools.save_path_sour = temp_ini
                mzpBuilder_Tools.title = "mzpBuilder"+" => "+ temp_ini
            )
            )
        )
    )
CreateDialog mzpBuilder_Tools width:620 height:750 menu:mzpBuilder_toolsMenu