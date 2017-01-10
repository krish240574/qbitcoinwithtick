/ Define attributes for reading CSV - timestamp, price, size (PFF)
/ "P" converts a Unix timestamp to a time value
c:`ts`price`size
colStr:"PFF"
/ reading only mt*.csv, since other files are realyl large, too big for the 32-but version
t:system"ls /root/q/tick/data/mt*.csv"
/ the master table, with all the trades. 
master:()
/ this funcion creates the master table, reading each file and adding curr and exchn fields
{dtemp1::();curr:s0[(-3+count s0:("." vs x)[0])+til 3];exchn:s0[til (-3+count s0:("." vs x)[0])];.Q.fs[{`dtemp1 insert flip c!(colStr;",")0:x}]`$x;dtemp1[`curr]:`$curr;dtemp1[`exchn]:`$k[-1 + count k:"/" vs exchn];master::master,dtemp1;dtemp1::();.Q.gc[]}each system"ls /root/q/tick/data/mt*.csv"
master[`curr]:string master[`curr]
master[`exchn]:string master[`exchn]
/ Create partitions based on currency
{kname:`$":/db/",(string x),"/t/";kname set select from master where curr like x}each distinct master[`curr]
/ Sort master in memory, based on time stamps. 
master:`ts xasc master
