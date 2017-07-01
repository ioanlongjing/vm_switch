虛擬機工作 5 小時
工作 5 小時候, 交換虛擬機

（夜晚）
從 19:00 開啟虛擬機
過 900 秒鐘( 15 分鐘) , 開啟另外一台
以此類推，到隔天早上 08:00

由於長時間開啟程式時, 似乎會造成 vm 無回應 (似乎是 crash)
故將 suspend 用 pause 取代, start 用 unpause 取代

新增 vmflag 功能, 讓 script 不會一直去 pause 

PS 1 : vmrun 似乎無法在一隻 script 內同時對兩隻 vm 做控制
PS 2 : 用 windows 內建排程，有時會只開一支程式
PS 3 : 本打算用 windows 的 PsExec 來同時控制兩隻, 不過很多防毒會對 PsExec 跳警告，為避免麻煩.. 故採用其他方式
# PsExec.exe -accepteula -h -i 1 %vmrun% start %vm_loc% >> %log%
