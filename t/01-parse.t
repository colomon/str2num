use str2num;
use Test;

plan *;

is_deeply str2num-parse("1"), (False, "1", "", ""), "1";
is_deeply str2num-parse("+1"), (False, "1", "", ""), "+1";
is_deeply str2num-parse("-1"), (True, "1", "", ""), "-1";

is_deeply str2num-parse("10"), (False, "10", "", ""), "10";
is_deeply str2num-parse("19"), (False, "19", "", ""), "19";
is_deeply str2num-parse("-23"), (True, "23", "", ""), "-23";
is_deeply str2num-parse("+45"), (False, "45", "", ""), "+45";

is_deeply str2num-parse("10."), (False, "10", "0", ""), "10.";
is_deeply str2num-parse("19."), (False, "19", "0", ""), "19.";
is_deeply str2num-parse("-23."), (True, "23", "0", ""), "-23.";
is_deeply str2num-parse("+45."), (False, "45", "0", ""), "+45.";


done_testing;