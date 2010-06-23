our sub str2num-parse($s) is export {
    my $digit-list = $s.comb;
    my $negate = False;
    
    my $char = $digit-list.shift;
    given $char {
        when '+' { $char = $digit-list.shift; }
        when '-' { $negate = True; $char = $digit-list.shift; }
    }
    
    my $int-part = "";
    while $char {
        if $char ~~ '0'..'9' {
            $int-part ~= $char;
        } else {
            last;
        }
        $char = $digit-list.shift;
    }
    
    my $frac-part = "";
    if ($char eq '.') {
        while $char = $digit-list.shift {
            if $char ~~ '0'..'9' {
                $frac-part ~= $char;
            } else {
                last;
            }
        }
    }
    
    my $exp-part = "";
    if ($char eq 'e' || $char eq 'E') {
        $char = $digit-list.shift;
        given $char {
            when '+' { $char = $digit-list.shift; }
            when '-' { $exp-part = '-'; $char = $digit-list.shift; }
        }

        while $char = $digit-list.shift {
            if $char ~~ '0'..'9' {
                $exp-part ~= $char;
            } else {
                last;
            }
        }
    }
    
    $negate, $int-part, $frac-part, $exp-part;
}
