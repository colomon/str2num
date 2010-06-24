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
        if $char ~~ '0'..'9' || $char eq '_' {
            $int-part ~= $char;
        } else {
            last;
        }
        $char = $digit-list.shift;
    }
    
    my $frac-part = "";
    if ($char eq '.') {
        while ($char = $digit-list.shift).defined {
            if $char ~~ '0'..'9' || $char eq '_' {
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
            if $char ~~ '0'..'9' || $char eq '_' {
                $exp-part ~= $char;
            } else {
                last;
            }
            $char = $digit-list.shift;
        }
    }
    
    $negate, $int-part, $frac-part, $exp-part;
}

our sub str2num-int($int-part) {
    [+] $int-part.comb(/\d/).reverse.kv.map(-> $i, $d { $d.Int * (10 ** $i) });
}

our sub str2num-rat($int-part, $frac-part is copy) {
    $frac-part.=subst(/(\d)0+$/, { ~$_[0] });
    str2num-int($int-part) + [+] $frac-part.comb(/\d/).kv.map(-> $i, $d { $d.Int / (10 ** ($i + 1)) }); 
}

our sub str2num-parts($negate, $int-part, $frac-part, $exp-part) is export {
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
    } else {
        # Int
        $result = str2num-int($int-part);
    }
    $result = -$result if $negate;
    $result;
}

our sub str2num($s) is export {
    my ($negate, $int-part, $frac-part, $exp-part) = str2num-parse($s);
    str2num-parts($negate, $int-part, $frac-part, $exp-part);
}

