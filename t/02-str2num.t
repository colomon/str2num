use str2num;
use Test;

plan *;

isa_ok str2num("1"), Int, "1 is an Int";
is str2num("1"), 1, "1 is 1";
isa_ok str2num("+1"), Int, "+1 is an Int";
is str2num("+1"), 1, "+1 is 1";
isa_ok str2num("-1"), Int, "-1 is an Int";
is str2num("-1"), -1, "-1 is 1";

done_testing;