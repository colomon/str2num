our sub str2num-parse($s) is export {
    my $digit-list = $s.comb;
    my $negate = False;
    
    my $char = $digit-list.shift;
    given $char {
        when '+' { $char = $digit-list.shift; }
        when '-' { $negate = True; $char = $digit-list.shift; }
    }
    
    my $int-part = "";
    while $char.defined {
        if $char ~~ '0'..'9' {
            $int-part ~= $char;
        } else {
            last;
        }
        $char = $digit-list.shift;
    }
    
    my $frac-part = "";
    if ($char eq '.') {
        while ($char = $digit-list.shift).defined {
            if $char ~~ '0'..'9' {
                $frac-part ~= $char;
            } else {
                last;
            }
        }
        if $frac-part eq "" {
            $frac-part = "0";
        }
    }
    
    my $exp-part = "";
    if ($char eq 'e' || $char eq 'E') {
        $char = $digit-list.shift;
        given $char {
            when '+' { $char = $digit-list.shift; }
            when '-' { $exp-part = '-'; $char = $digit-list.shift; }
        }

        while $char.defined {
            if $char ~~ '0'..'9' {
                $exp-part ~= $char;
            } else {
                last;
            }
            $char = $digit-list.shift;
        }
    }
    
    $negate, $int-part, $frac-part, $exp-part;
}

our sub str2num-rat($int-part, $frac-part) {
    $int-part.Int + $frac-part.Int / (10 ** $frac-part.chars);
}

our sub str2num($s) is export {
    my ($negate, $int-part, $frac-part, $exp-part) = str2num-parse($s);
    # say :$int-part.perl;
    # say :$frac-part.perl;
    # say :$exp-part.perl;
    
    my $result;
    if $exp-part.chars > 0 {
        # Num
        $result = str2num-rat($int-part, $frac-part ?? $frac-part !! "0") * exp($exp-part, :base(10));
    } elsif $frac-part.chars > 0 {
        # Rat
        $result = str2num-rat($int-part, $frac-part);
        # say $result.WHAT;
    } else {
        # Int
        $result = $int-part.Int;
    }
    $result = -$result if $negate;
    $result;
}

