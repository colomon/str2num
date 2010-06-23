use str2num;
use Test;

plan *;

is_deeply str2num-parse("1"), (False, "1", "", ""), "1";


done_testing;