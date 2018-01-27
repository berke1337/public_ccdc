`crunch` is a BSD utility to put a lot of programs in a single binary, the result is like busybox.

Here is an i386 version:
http://bsdbox.sourceforge.net

To extract crunch from BSDbox:
* Using BSD, loop-mount the `.bin`
* Loop-mount a file `mfs`, find it in the previous mount
* Every binary in `/stand` is a hard-linked copy of the `crunch` binary
