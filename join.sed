#! /bin/sed -nf

s/^\xEF\xBB\xBF// # remove unicode byte order mask if present
s/\r$// # remove carriage return symbols

/^[[:digit:]]\+\:[[:digit:]]\+\.[[:digit:]]\+/ { # search for pattern like 18:13.379001 at the beginning of pattern space
 
  x # switch pattern space and hold space
    
  /./ { # check if the pattern space is not empty
    s/\n/ /g # remove newlines
    p # print the pattern space
  }
  
  $ { # in case it is the last line
    x # bring the text from hold space back
    P # print
    Q # quit
  }

  d # clean up the pattern space and start a new cycle
}

H # appent newline to the hold space, then append the pattern space

$ { # if it is the last line

  x # switch spaces

  /./ { # check if the pattern space is not empty
    s/\n/ /g # replace newlines with spaces
    s/^\s\+// # remove spaces in case of a single line
    p # print the pattern space
  }
}
