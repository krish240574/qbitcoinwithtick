c:`ts`price`size
colStr:"PFF"
t:system"ls /root/q/tick/data/mt*.csv"
master:()
{dtemp1::();curr:s0[(-3+count s0:("." vs x)[0])+til 3];exchn:s0[til (-3+count s0:("." vs x)[0])];.Q.fs[{`dtemp1 insert flip c!(colStr;",")0:x}]`$x;dtemp1[`curr]:`$curr;dtemp1[`exchn]:`$k[-1 + count k:"/" vs exchn];master::master,dtemp1;dtemp1::();.Q.gc[]}each system"ls /root/q/tick/data/mt*.csv"
master[`curr]:string master[`curr]
master[`exchn]:string master[`exchn]
{kname:`$":/db/",(string x),"/t/";kname set select from master where curr like x}each distinct master[`curr]
master:`ts xasc master
