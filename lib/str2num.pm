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

our sub str2num-int($src) {
    upgrade_to_num_if_needed(Q:PIR {
        .local pmc src
        .local string src_s
        src = find_lex '$src'
        src_s = src
        .local int pos, eos
        .local num result
        pos = 0
        eos = length src_s
        result = 0
      str_loop:
        unless pos < eos goto str_done
        .local string char
        char = substr src_s, pos, 1
        if char == '_' goto str_next
        .local int digitval
        digitval = index "00112233445566778899", char
        if digitval < 0 goto err_base
        digitval >>= 1
        if digitval >= 10 goto err_base
        result *= 10
        result += digitval
      str_next:
        inc pos
        goto str_loop
      err_base:
	src.'panic'('Invalid radix conversion of "', char, '"')
      str_done:
        %r = box result
    });
}

our sub str2num-base($src) {
    upgrade_to_num_if_needed(Q:PIR {
        .local pmc src
        .local string src_s
        src = find_lex '$src'
        src_s = src
        .local int pos, eos
        .local num result
        pos = 0
        eos = length src_s
        result = 1
      str_loop:
        unless pos < eos goto str_done
        .local string char
        char = substr src_s, pos, 1
        if char == '_' goto str_next
        result *= 10
      str_next:
        inc pos
        goto str_loop
      err_base:
	src.'panic'('Invalid radix conversion of "', char, '"')
      str_done:
        %r = box result
    });
}


our sub str2num-rat($int-part, $frac-part is copy) {
    $frac-part.=subst(/(\d)0+$/, { ~$_[0] });
    str2num-int($int-part) + str2num-int($frac-part) / str2num-base($frac-part);
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

