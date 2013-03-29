# `
# function writeCode(callback) {
#   // do something
#   callback();
# }

# function introduceBugs() {
#   // ... make bugs
# }
# `

###
notes: 
  - functions are objects
  - they provide local scope

  when you pass the function introduceBugs (<-- without parenthesis) to the 
  function writeCode(), then at some point, writeCode() is likely to call
  introduceBugs()  (<--- with parenthesis)
  - this makes introduceBugs a callback function(or just a callback for short)
  - we pass introduceBugs without () in order to just pass a reference to the 
    function -- writeCode() will execute the introduceBugs() on its own, in other
    words, it will call it back (this term implicitly has two parts - one, another
    part of the code is in charge of executing the reference to the function, and 
    two, call it BACK infers that we also want the scope of the original function
    to be available, as though we were going back to the place where the function
    was defined and calling it as though we called it directly, we're going back
    to where we passed the function in to grab scope -- which is the second part
    of this phenomena)
###

