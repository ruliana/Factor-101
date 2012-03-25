! Copyright (C) 2012 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors unicode assocs biassocs combinators hashtables
kernel lists literals math namespaces make multiline openal
openal.alut parser sequences splitting strings synth
synth.buffers ;
IN: morse

CONSTANT: morse-code-table $[
    H{
        { CHAR: a ".-"      }
        { CHAR: b "-..."    }
        { CHAR: c "-.-."    }
        { CHAR: d "-.."     }
        { CHAR: e "."       }
        { CHAR: f "..-."    }
        { CHAR: g "--."     }
        { CHAR: h "...."    }
        { CHAR: i ".."      }
        { CHAR: j ".---"    }
        { CHAR: k "-.-"     }
        { CHAR: l ".-.."    }
        { CHAR: m "--"      }
        { CHAR: n "-."      }
        { CHAR: o "---"     }
        { CHAR: p ".--."    }
        { CHAR: q "--.-"    }
        { CHAR: r ".-."     }
        { CHAR: s "..."     }
        { CHAR: t "-"       }
        { CHAR: u "..-"     }
        { CHAR: v "...-"    }
        { CHAR: w ".--"     }
        { CHAR: x "-..-"    }
        { CHAR: y "-.--"    }
        { CHAR: z "--.."    }
        { CHAR: 1 ".----"   }
        { CHAR: 2 "..---"   }
        { CHAR: 3 "...--"   }
        { CHAR: 4 "....-"   }
        { CHAR: 5 "....."   }
        { CHAR: 6 "-...."   }
        { CHAR: 7 "--..."   }
        { CHAR: 8 "---.."   }
        { CHAR: 9 "----."   }
        { CHAR: 0 "-----"   }
        { CHAR: . ".-.-.-"  }
        { CHAR: , "--..--"  }
        { CHAR: ? "..--.."  }
        { CHAR: ' ".----."  }
        { CHAR: ! "-.-.--"  }
        { CHAR: / "-..-."   }
        { CHAR: ( "-.--."   }
        { CHAR: ) "-.--.-"  }
        { CHAR: & ".-..."   }
        { CHAR: : "---..."  }
        { CHAR: ; "-.-.-."  }
        { CHAR: = "-...- "  }
        { CHAR: + ".-.-."   }
        { CHAR: - "-....-"  }
        { CHAR: _ "..--.-"  }
        { CHAR: " ".-..-."  }
        { CHAR: $ "...-..-" }
        { CHAR: @ ".--.-."  }
        { CHAR: \s "/"      }
    } >biassoc
]

: ch>morse ( ch -- morse )
    ch>lower morse-code-table at ;

: morse>ch ( morse -- ch )
    morse-code-tabel value-at ;

: word>morse ( str -- morse )
    [ ch>morse ] { } map-as " " join ;

: morse>word ( morse -- str )
    " " split [ morse>ch ] "" map-as ;

: sentence>morse ( str -- morse )
    " " split [ word>morse ] map " / " join ;

: trim-blanks ( str -- newstr )
    [ blank? ] trim ; inline

: morse>sentence ( morse -- str )
    "/" split [ trim-blanks morse>word ] map " " join ;

: replace-underscores ( str -- newstr )
    [ dup CHAR: _ = [ drop CHAR: - ] when ] map ;

: >morse ( plain -- morse )
    trim-blanks sentence>morse ;

: morse> ( morse -- plain )
    replace-underscores morse>sentence ;
