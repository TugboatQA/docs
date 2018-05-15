# Debugging Your Build Script

In this section we'll walk through the basic steps of debugging your Build Script. 



Usually try and rebuild (or delete, then build it again from scratch) rebuild is buggy.

Open up a terminal
nano Makefile
run indiudal commands
make tugboat-inut or tugboat build
edit the makefile in the terminal window
make tugboat-build
git diff Makefile
git commit

// Switch to project because I 
// can't make the commit in my terminal. It has no connection back to remote.
**Tugboat suspending in the midst of terminal access**
No configured push destination.
git show
// go back to the project and make the change. 

git commit, git push. 

//back to tugboat

git pull

Delete the preview and then build it again. 

Even if a preview is failed, you can still get terminal access.

There was an error on a given line, copy that command, launch terminal, paste it in and run it. 

Most of the tweaks are going to be in tugboat-init.