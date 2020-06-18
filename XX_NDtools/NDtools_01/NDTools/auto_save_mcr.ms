macroScript save_auto_name
category:"MAX Script Tools"
tooltip:"另保存"
buttonText:"保存"
icon:#("Sample",1)
(
    filein (getdir #maxroot+"scripts\\NDTools\\1_保存_Save File Path.ms")
)

-----------------------------
try (cui.loadConfig (getdir #maxroot+"scripts\\NDTools\\Nd_toot_2_v01.cuix"))catch()
colorman.reInitIcons()