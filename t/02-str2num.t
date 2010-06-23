use str2num;
use Test;

plan *;

isa_ok str2num("1"), Int, "1 is an Int";
is str2num("1"), 1, "1 is 1";
isa_ok str2num("+1"), Int, "+1 is an Int";
is str2num("+1"), 1, "+1 is 1";
isa_ok str2num("-1"), Int, "-1 is an Int";
is str2num("-1"), -1, "-1 is -1";
isa_ok str2num("10"), Int, "10 is an Int";
is str2num("10"), 10, "10 is 10";

isa_ok str2num("10."), Rat, "10. is an Rat";
is str2num("10."), 10, "10. is 10";
isa_ok str2num("10.0"), Rat, "10.0 is an Rat";
is str2num("10.0"), 10, "10.0 is 10";
isa_ok str2num("10.1"), Rat, "10.1 is an Rat";
is str2num("10.1"), 10.1, "10.1 is 10.1";
isa_ok str2num("100000000.1"), Rat, "100000000.1 is an Rat";
is str2num("100000000.1"), 100000000.1, "100000000.1 is 100000000.1";


done_testing;