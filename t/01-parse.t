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

is_deeply str2num-parse("10.0"), (False, "10", "0", ""), "10.0";
is_deeply str2num-parse("19.0"), (False, "19", "0", ""), "19.0";
is_deeply str2num-parse("-23.0"), (True, "23", "0", ""), "-23.0";
is_deeply str2num-parse("+45.0"), (False, "45", "0", ""), "+45.0";

is_deeply str2num-parse("10.01"), (False, "10", "01", ""), "10.01";
is_deeply str2num-parse("19.01"), (False, "19", "01", ""), "19.01";
is_deeply str2num-parse("-23.01"), (True, "23", "01", ""), "-23.01";
is_deeply str2num-parse("+45.01"), (False, "45", "01", ""), "+45.01";

is_deeply str2num-parse("10.10"), (False, "10", "10", ""), "10.10";
is_deeply str2num-parse("19.10"), (False, "19", "10", ""), "19.10";
is_deeply str2num-parse("-23.10"), (True, "23", "10", ""), "-23.10";
is_deeply str2num-parse("+45.10"), (False, "45", "10", ""), "+45.10";

is_deeply str2num-parse(".10"), (False, "", "10", ""), ".10";
is_deeply str2num-parse(".01"), (False, "", "01", ""), ".01";
is_deeply str2num-parse("-.23"), (True, "", "23", ""), "-.23";
is_deeply str2num-parse("+.45"), (False, "", "45", ""), "+.45";


is_deeply str2num-parse("1e1"), (False, "1", "", "1"), "1e1";
is_deeply str2num-parse("+1e+1"), (False, "1", "", "1"), "+1e+1";
is_deeply str2num-parse("-1e-1"), (True, "1", "", "-1"), "-1e-1";

is_deeply str2num-parse("10e+0"), (False, "10", "", "0"), "10e+0";
is_deeply str2num-parse("19e-0"), (False, "19", "", "-0"), "19e-0";
is_deeply str2num-parse("-23e+04"), (True, "23", "", "04"), "-23e+04";
is_deeply str2num-parse("+45e-04"), (False, "45", "", "-04"), "+45e-04";

is_deeply str2num-parse("10.e10"), (False, "10", "0", "10"), "10.e10";
is_deeply str2num-parse("19.e+10"), (False, "19", "0", "10"), "19.e+10";
is_deeply str2num-parse("-23.e-10"), (True, "23", "0", "-10"), "-23.e-10";
is_deeply str2num-parse("+45.e34"), (False, "45", "0", "34"), "+45.e34";

is_deeply str2num-parse("10.0e+87"), (False, "10", "0", "87"), "10.0e+87";
is_deeply str2num-parse("19.0e-69"), (False, "19", "0", "-69"), "19.0e-69";

is_deeply str2num-parse(".10e321"), (False, "", "10", "321"), ".10e321";
is_deeply str2num-parse(".01e+091"), (False, "", "01", "091"), ".01e+091";
is_deeply str2num-parse("-.23e-666"), (True, "", "23", "-666"), "-.23e-666";
is_deeply str2num-parse("+.45e4"), (False, "", "45", "4"), "+.45e4";


is_deeply str2num-parse("1E1"), (False, "1", "", "1"), "1E1";
is_deeply str2num-parse("+1E+1"), (False, "1", "", "1"), "+1E+1";
is_deeply str2num-parse("-1E-1"), (True, "1", "", "-1"), "-1E-1";

is_deeply str2num-parse("10E+0"), (False, "10", "", "0"), "10E+0";
is_deeply str2num-parse("19E-0"), (False, "19", "", "-0"), "19E-0";
is_deeply str2num-parse("-23E+04"), (True, "23", "", "04"), "-23E+04";
is_deeply str2num-parse("+45E-04"), (False, "45", "", "-04"), "+45E-04";

is_deeply str2num-parse("10.E10"), (False, "10", "0", "10"), "10.E10";
is_deeply str2num-parse("19.E+10"), (False, "19", "0", "10"), "19.E+10";
is_deeply str2num-parse("-23.E-10"), (True, "23", "0", "-10"), "-23.E-10";
is_deeply str2num-parse("+45.E34"), (False, "45", "0", "34"), "+45.E34";

is_deeply str2num-parse("10.0E+87"), (False, "10", "0", "87"), "10.0E+87";
is_deeply str2num-parse("19.0E-69"), (False, "19", "0", "-69"), "19.0E-69";

is_deeply str2num-parse(".10E321"), (False, "", "10", "321"), ".10E321";
is_deeply str2num-parse(".01E+091"), (False, "", "01", "091"), ".01E+091";
is_deeply str2num-parse("-.23E-666"), (True, "", "23", "-666"), "-.23E-666";
is_deeply str2num-parse("+.45E4"), (False, "", "45", "4"), "+.45E4";

done_testing;